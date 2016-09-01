FROM php:5-alpine

RUN mkdir -p /run/apache2 /opt/hello-php

ADD . /opt/hello-php

RUN \
    # Upgrade old packages.
    apk --update upgrade && \
    # Ensure we have ca-certs installed.
    apk add --no-cache ca-certificates && \
    # PHP packages
    apk add apache2 php5-apache2

CMD /usr/sbin/httpd -f /opt/hello-php/httpd.conf -D FOREGROUND
