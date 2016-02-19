#!/bin/bash

if [ ! -f /root/.my.cnf ]; then
    username="root"
    password=$(pwgen 42)

    echo mysql-server mysql-server/root_password password $password | debconf-set-selections
    echo mysql-server mysql-server/root_password_again password $password | debconf-set-selections
    apt-get -q update
    apt-get install -y -q mysql-server
    cat <<EOF > /root/.my.cnf
[client]
user = $username
password = $password
EOF
fi
