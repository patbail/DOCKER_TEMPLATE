FROM php:8.5-apache

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y --no-install-recommends \
    libzip-dev libicu-dev libpng-dev libjpeg-dev libfreetype6-dev \
  && docker-php-ext-configure gd --with-freetype --with-jpeg \
  && docker-php-ext-install -j$(nproc) pdo_mysql intl zip gd opcache \
  && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY vhost.conf.template /etc/apache2/sites-available/000-default.conf.template
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
