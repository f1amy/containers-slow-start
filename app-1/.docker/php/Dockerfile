#syntax=docker/dockerfile:1.5

# The different stages of this Dockerfile are meant to be built into separate images
# https://docs.docker.com/develop/develop-images/multistage-build/#stop-at-a-specific-build-stage
# https://docs.docker.com/compose/compose-file/#target


# Versions
FROM php:8.2-fpm-alpine AS php_upstream
FROM mlocati/php-extension-installer:2 AS php_extension_installer_upstream
FROM composer/composer:2-bin AS composer_upstream


# Base PHP image
FROM php_upstream AS php_base

WORKDIR /srv/app

# persistent / runtime deps
RUN apk add --no-cache \
		fcgi \
		git \
		bash \
		openssh-client \
	;

# php extensions installer: https://github.com/mlocati/docker-php-extension-installer
COPY --from=php_extension_installer_upstream --link /usr/bin/install-php-extensions /usr/local/bin/

RUN set -eux; \
    install-php-extensions \
		apcu \
		opcache \
		zip \
    	redis \
    	amqp \
    	pdo_mysql \
    ;

COPY --link conf.d/app.ini $PHP_INI_DIR/conf.d/

COPY --link php-fpm.d/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
RUN mkdir -m 777 -p /var/run/php

COPY --link docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

ENTRYPOINT ["docker-entrypoint"]
CMD ["php-fpm"]

# https://getcomposer.org/doc/03-cli.md#composer-allow-superuser
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV PATH="${PATH}:/root/.composer/vendor/bin"

COPY --from=composer_upstream --link /composer /usr/bin/composer


# Dev image
FROM php_base AS app_php

ENV APP_ENV=dev XDEBUG_MODE=off

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

COPY --link conf.d/app.dev.ini $PHP_INI_DIR/conf.d/

# setup user
RUN addgroup -g 1000 dev-user \
    && adduser -u 1000 -D -S -G dev-user dev-user

USER dev-user
