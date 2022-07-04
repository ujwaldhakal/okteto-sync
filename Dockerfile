ARG PHP_IMAGE=php:8.1-fpm-alpine

FROM $PHP_IMAGE as base

ARG COMPOSER_AUTH

WORKDIR /var/www/html

SHELL ["/bin/ash", "-eo", "pipefail", "-c"]

ENV CFLAGS="$CFLAGS -D_GNU_SOURCE"

RUN  apk add unzip curl fcgi alpine-sdk postgresql-dev libxml2-dev libzip-dev  \
 && docker-php-ext-install pdo pdo_pgsql pdo_mysql bcmath sockets \
 && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
 && rm -rf /var/cache/apk/* \
CMD ["php-fpm"]

