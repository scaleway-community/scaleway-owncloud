#!/bin/bash
#================================================================
# Let's Encrypt renewal script for Apache on Ubuntu/Debian
# @author Erika Heidi<erika@do.co>
# Usage: ./le-renew.sh [base-domain-name]
# More info: http://do.co/1mbVihI
#================================================================
domain=$1
le_path='/opt/letsencrypt'
le_conf='/etc/letsencrypt'
exp_limit=30;

get_domain_list(){
        certdomain=$1
        config_file="$le_conf/renewal/$certdomain.conf"

	if [ ! -f $config_file ] ; then
                echo "[ERROR] The config file for the certificate $certdomain was not found."
                exit 1;
        fi

        domains=$(grep --only-matching --perl-regex "(?<=domains \= ).*" "${config_file}")
        last_char=$(echo "${domains}" | awk '{print substr($0,length,1)}')

        if [ "${last_char}" = "," ]; then
                domains=$(echo "${domains}" |awk '{print substr($0, 1, length-1)}')
        fi

        echo $domains;
}

if [ -z "$domain" ] ; then
        echo "[ERROR] you must provide the domain name for the certificate renewal."
        exit 1;
fi

cert_file="/etc/letsencrypt/live/$domain/fullchain.pem"

if [ ! -f $cert_file ]; then
	echo "[ERROR] certificate file not found for domain $domain."
	exit 1;
fi

exp=$(date -d "`openssl x509 -in $cert_file -text -noout|grep "Not After"|cut -c 25-`" +%s)
datenow=$(date -d "now" +%s)
days_exp=$(echo \( $exp - $datenow \) / 86400 |bc)

echo "Checking expiration date for $domain..."

if [ "$days_exp" -gt "$exp_limit" ] ; then
	echo "The certificate is up to date, no need for renewal ($days_exp days left)."
	exit 0;
else
	echo "The certificate for $domain is about to expire soon. Starting renewal request..."
	domain_list=$( get_domain_list $domain )
	"$le_path"/letsencrypt-auto certonly --apache --renew-by-default --domains "${domain_list}"
	echo "Restarting Apache..."
	/usr/sbin/service apache2 reload
	echo "Renewal process finished for domain $domain"
	exit 0;
fi
