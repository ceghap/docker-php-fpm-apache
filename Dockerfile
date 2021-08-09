FROM php:7.4-apache

RUN apt-get -qq update
RUN apt-get -y install wget gnupg
RUN wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
RUN echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

RUN apt-get -qq update

RUN rm /etc/apt/preferences.d/no-debian-php
RUN apt-get -y install php7.4-fpm

COPY ./src /var/www/html

COPY ./docker/conf/000-default.conf /etc/apache2/sites-available
RUN a2enmod proxy proxy_fcgi setenvif
RUN a2enconf php7.4-fpm

COPY ./docker/entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

CMD ["/sbin/entrypoint.sh"]
