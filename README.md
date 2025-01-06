# Docker Webserver - Apache, MySQL, PHP

This repository provides a Docker-based setup for a web development environment featuring Apache, MySQL (MariaDB), PHP, and additional useful tools. This setup is designed to allow developers to quickly spin up a local web environment with all the services needed for web development and testing.

## Supported PHP Versions

- PHP 8.3
- PHP 8.2
- PHP 8.1
- PHP 7.4

## Installed Services

### 1. Webserver (Apache with PHP)
Apache is a widely-used web server, and when combined with PHP, it provides a powerful platform for developing and serving dynamic web applications.

- **Port**: `80:80`

### 2. Composer
Composer is a dependency manager for PHP, allowing you to easily manage your project's libraries and dependencies.

- **Port**: N/A

### 3. MariaDB
MariaDB is an open-source relational database management system, a fork of MySQL, known for its reliability and performance.

- **Port**: `3306:3306`

### 4. phpMyAdmin
phpMyAdmin is a free and open-source administration tool for MySQL and MariaDB, providing a graphical interface to manage databases.

- **Port**: `8081:80`

### 5. Varnish
Varnish is a web application accelerator, also known as a caching HTTP reverse proxy, which speeds up web servers by caching content.

- **Port**: `8082:80`

### 6. Elasticsearch
Elasticsearch is a distributed, RESTful search and analytics engine capable of addressing a growing number of use cases.

- **Port**: `9200:9200`

### 7. MailHog
MailHog is an email testing tool that captures emails sent by your application and displays them in a web interface. It runs a fake SMTP server and provides an easy way to test email functionality without sending real emails.

- **UI Port**: `8025`
- **SMTP Server Port**: `1025`

## Usage

### Starting the Services
To start all the services in detached mode (background), run the following command:

```bash
docker-compose up -d
