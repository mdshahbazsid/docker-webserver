# Docker-Webserver
Docker Webserver - Apache, Mysql, Php

#### Supported PHP Versions
- Php 8.3
- Php 8.2
- Php 8.1
- Php 7.4

#### Installed Services :
```php
- webserver (apache with php)   | Port - 80:80
- composer                      | N/A
- mariadb                       | Port - 3306:3306
- phpmyadmin                    | Post - 8081:80
- varnish                       | Port - 8082:80
- elasticsearch                 | Port - 9200:9200
- mailhog                       | Port - 8025 For UI, Port - 1025 For SMTP Server
```
* __Webserver (Apache with PHP)__
    - __Description:__ Apache HTTP Server with PHP integration to serve dynamic web pages.
    - __Ports:__ 80:80
    - __Usage:__ It is used to host and serve web applications.

- __Composer__
    - __Description:__ Dependency manager for PHP, used for managing libraries and packages in PHP projects.
    - __Ports:__ N/A
    - __Usage:__ It is used to install and update dependencies in PHP projects.

- __MariaDB__
    - __Description:__ An open-source relational database management system, a fork of MySQL.
    - __Ports:__ 3306:3306
    - __Usage:__ It is used to manage databases for web applications.

- __PhpMyAdmin__
    - __Description:__ A free and open-source administration tool for MySQL and MariaDB.
    - __Ports:__ 8081:80
    - __Usage:__ It provides a web interface to manage MySQL and MariaDB databases.

- __Varnish__
    - __Description:__ A caching HTTP reverse proxy that can accelerate web applications by caching content.
    - __Ports:__ 8082:80
    - __Usage:__ It is used to improve the performance of web applications by caching static content.

- __Elasticsearch__
    - __Description:__ A distributed, RESTful search and analytics engine capable of solving a growing number of use cases.
    - __Ports:__ 9200:9200
    - __Usage:__ It is used to index and search data for web applications.

- __MailHog__
    - __Description:__ An email testing tool for developers that captures outgoing emails and provides a web interface to view them.
    - __Ports:__ 8025 (UI), 1025 (SMTP Server)
    - __Usage:__ It is used to test email sending functionality in web applications without sending emails to the actual recipients.

#### Maintainer
- Dev. Mohd Shahbaz | @mdshahbazsid@gmail.com
