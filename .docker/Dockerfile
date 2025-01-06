FROM php:PHP_VERSION-apache

# Mandatory Arguments
ARG COMPOSER_VERSION
ARG APACHE_USER
ARG USER_ID

# Use an official PHP runtime

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

#Install - mhsendmail (Mail Support)
RUN apt-get update && \
    apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git && \
    rm -rf /var/lib/apt/lists/*
    
# Fetch and install Go library
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -

# Update PATH to include Go binary directory
ENV PATH /usr/local/go/bin:$PATH

# Install mhsendmail
RUN go get github.com/mailhog/mhsendmail

# Copy mhsendmail binary to /usr/bin for easier access
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

# Configure sendmail path
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini
# End


