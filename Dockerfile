# We're using php5 since Alpine Linux's php7 is (as of this commit) on edge/testing.
FROM php:5-alpine

# The /run/apache2 directory is missing in the current apache2 package;
# this is a bug workaround. See:
# http://forum.alpinelinux.org/forum/general-discussion/cant-foreground-apache
RUN mkdir -p /run/apache2 /opt/hello-php

ADD . /opt/hello-php

RUN \
    # Upgrade old packages.
    apk --update upgrade && \
    # Ensure we have ca-certs installed.
    apk add --no-cache ca-certificates && \
    # Apache and PHP packages
    apk add apache2 php5-apache2

# Run Apache in the foreground to work well with Docker and log collection.
CMD /usr/sbin/httpd -f /opt/hello-php/httpd.conf -D FOREGROUND
