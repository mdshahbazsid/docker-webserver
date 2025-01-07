# Use an official PHP runtime
FROM php:PHP_VERSION-apache

# Mandatory Arguments
ARG COMPOSER_VERSION
ARG APACHE_USER
ARG USER_ID


LABEL maintainer="Dev. Mohd Shahbaz mdshahbazsid@gmail.com"

ENV APACHE_RUN_USER=$APACHE_USER

RUN adduser --uid $USER_ID --gecos 'Dev. Mohd Shahbaz' --disabled-password "$APACHE_RUN_USER" \
             && chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" /var/lock/apache2 /var/run/apache2 /var/www/html
             
# Install any extensions you need
RUN apt-get update && apt-get install -y \
  cron \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libssl-dev \
  lsof \
  vim \
  zip \
  jq

RUN docker-php-ext-configure \
  gd --with-freetype --with-jpeg

RUN apt-get install -y libzip-dev

RUN docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  intl \
  mysqli \
  opcache \
  pcntl \
  pdo_mysql \
  soap \
  sockets \
  sysvmsg \
  sysvsem \
  sysvshm \
  xsl \
  zip 

# Enable Apache modules
RUN a2enmod rewrite

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

COPY ./.docker/auth.json /home/$APACHE_RUN_USER/.composer/auth.json

#Install - mhsendmail (Mail Support) [MailHog redirects emails from web apps to its SMTP server using mhsendmail, a sendmail replacement created specifically for MailHog]
RUN curl -Lo /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
    && chmod +x /usr/local/bin/mhsendmail
# End