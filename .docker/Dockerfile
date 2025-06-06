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
  nano \
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

# Install openssh-client
RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-client && \
    rm -rf /var/lib/apt/lists/*

# Install git
RUN apt-get update && apt-get install -y git

# Copy SSL certificate and key
COPY ./../.ssl/* /etc/apache2/ssl/

# Copy the custom Apache virtual host config
COPY ./../.apache/000-default.conf /etc/apache2/sites-available/000-default.conf

# Enable Apache modules, Enable SSL module
RUN a2enmod ssl && a2enmod rewrite

# Install Composer
# Downloading the composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION}

# Give the permission and Set the file permissions and ownership
RUN mkdir -p /home/$APACHE_RUN_USER/.composer && \
chown -R $APACHE_RUN_USER:$APACHE_RUN_GROUP /home/$APACHE_RUN_USER/.composer

COPY ./.docker/auth.json /home/$APACHE_RUN_USER/.composer/auth.json
# End

#Install - mhsendmail (Mail Support) [MailHog redirects emails from web apps to its SMTP server using mhsendmail, a sendmail replacement created specifically for MailHog]
RUN curl -Lo /usr/local/bin/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
    && chmod +x /usr/local/bin/mhsendmail
# End

# Setup Crontab
# Copy cron file to the container
COPY ./.apache/crontab /etc/cron.d/crontab

# Create the log file to be able to run tail for cron logs
RUN touch /var/log/cron.log
RUN chmod 0666 /var/log/cron.log

# Give the permission and Set the cron file permissions and ownership
RUN chown $APACHE_RUN_USER:$APACHE_RUN_GROUP /etc/cron.d/crontab && \
    chmod 0666 /etc/cron.d/crontab && \
    su -c "crontab /etc/cron.d/crontab" $APACHE_RUN_USER

# Start cron service
RUN sed -i 's/^exec /service cron start\n\nexec /' /usr/local/bin/apache2-foreground
# End
