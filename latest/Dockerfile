## -*- docker-image-name: "scaleway/owncloud:latest" -*-
ARG SCW_ARCH
FROM scaleway/ubuntu:${SCW_ARCH}-xenial

MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter

# Install packages
RUN apt-get update && apt-get install apt-transport-https \
  && curl -Ls https://download.owncloud.org/download/repositories/stable/Ubuntu_16.04/Release.key | apt-key add - \
  && echo 'deb https://download.owncloud.org/download/repositories/stable/Ubuntu_16.04/ /' | sudo tee /etc/apt/sources.list.d/owncloud.list \
  && apt-get -q update \
  && apt-get -y -q upgrade \
  && apt-get install -y -q \
     libffi-dev \
     libssl-dev \
     git \
     php7.0 \
     php7.0-curl \
     mysql-server \
     pwgen \
     python \
     python-dev \
     apache2 \
     python-pip \
     owncloud-files \
  && apt-get install -y -q \
     libapache2-mod-php7.0 \
     php7.0-gd \
     php7.0-json \
     php7.0-mysql \
     php7.0-curl \
     php7.0-intl \
     php7.0-mcrypt \
     php-imagick \
     php7.0-zip \
     php7.0-xml \
     php7.0-mbstring \
     php-apcu \
     redis-server \
     php7.0-ldap \
     php-smbclient \
  && apt-get clean

# Configure Apache
RUN a2enmod rewrite php7.0 \
  && ln -s /var/www/owncloud /var/www/html/owncloud \
  && mkdir -p /var/www/html/owncloud/themes/

# Patch rootfs
COPY ./overlay /

# Symlink doc readme to /root/
RUN ln -s /usr/share/doc/scaleway/owncloud/README /root/README

# Enable services
RUN systemctl enable init-owncloud init-mysql mysql

# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
