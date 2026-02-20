FROM php:8.5-apache

RUN a2enmod rewrite

# (optional but helpful for builds)
ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
  apt-get update -o Acquire::Retries=5; \
  apt-get install -y --no-install-recommends \
    libzip-dev libicu-dev libpng-dev libjpeg-dev libfreetype6-dev \
    ca-certificates; \
  rm -rf /var/lib/apt/lists/*


RUN set -eux; \
  docker-php-ext-configure gd --with-freetype --with-jpeg; \
  docker-php-ext-install -j"$(nproc)" pdo_mysql intl zip gd

# optional: enable opcache settings (opcache is present in PHP 8.5)
RUN { \
  echo 'opcache.enable=1'; \
  echo 'opcache.enable_cli=1'; \
  echo 'opcache.jit=0'; \
  echo 'opcache.validate_timestamps=1'; \
  echo 'opcache.revalidate_freq=0'; \
} > /usr/local/etc/php/conf.d/opcache-recommended.ini

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY vhost.conf.template /etc/apache2/sites-available/000-default.conf.template
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
