#!/bin/bash

service php7.4-fpm start

source /etc/apache2/envvars
#tail -F /var/log/apache2/* &

exec apache2 -D FOREGROUND
