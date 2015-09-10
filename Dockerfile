## -*- docker-image-name: "armbuild/scw-app-owncloud:trusty" -*-
FROM armbuild/scw-distrib-ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN \
    sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_14.04/ /' >> /etc/apt/sources.list.d/owncloud.list" && \
    curl -Ls http://download.opensuse.org/repositories/isv:ownCloud:community/xUbuntu_14.04/Release.key | apt-key add - && \
    apt-get -q update && \
    apt-get -y -q upgrade && \
    apt-get install -y -q \
    php5-curl \
    pwgen \
    && apt-get install --no-install-recommends -y -q \
        owncloud \
    && apt-get clean


# Configure Apache
RUN a2enmod rewrite && a2enmod ssl && a2ensite default-ssl.conf


# Patch rootfs
ADD ./patches/etc/ /etc/
ADD ./patches/usr/local/ /usr/local/


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
