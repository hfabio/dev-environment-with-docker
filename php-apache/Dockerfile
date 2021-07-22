FROM php:7.2-apache

LABEL description="apache2-php-7.2"

# RUN a2enmod rewrite

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libldap2-dev default-mysql-client \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install gd mbstring opcache pdo pdo_mysql zip ldap bcmath \
    && install-php-extensions xdebug 
# && service apache2 restart

ADD ./xdebug.ini /etc/php/7.2/mods-available/xdebug.ini