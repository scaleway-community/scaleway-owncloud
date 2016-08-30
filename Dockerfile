## -*- docker-image-name: "scaleway/owncloud:latest" -*-
FROM scaleway/ubuntu:amd64-xenial
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/ubuntu:armhf-xenial       # arch=armv7l
#FROM scaleway/ubuntu:arm64-xenial       # arch=arm64
#FROM scaleway/ubuntu:i386-xenial        # arch=i386
#FROM scaleway/ubuntu:mips-xenial        # arch=mips
      

MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN sh -c "echo 'deb http://download.owncloud.org/download/repositories/stable/Ubuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list" \
 && curl -Ls https://download.owncloud.org/download/repositories/stable/Ubuntu_14.04/Release.key | apt-key add - \
 && apt-get -q update \
 && apt-get -y -q upgrade \
 && apt-get install -y -q \
     libffi-dev \
     libssl-dev \
     git \
     php5-curl \
     pwgen \
     python \
     python-dev \
     python-pip \
 && apt-get install --no-install-recommends -y -q \
     owncloud \
 && apt-get clean

# Configure Apache
RUN a2enmod rewrite \
 && ln -s /var/www/owncloud /var/www/html/owncloud

# Patch rootfs
COPY ./overlay /

# Add letsencrypt
RUN update-rc.d letsencrypt defaults

# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
