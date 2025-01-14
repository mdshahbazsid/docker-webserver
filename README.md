# Docker-WebServer
Docker Webserver - Apache, Mysql, Php

<sup><code>**Specifically engineered to seamlessly run Magento, the Adobe Commerce platform.</code></sup>

## Supported PHP Versions : 
- Php 8.3
- Php 8.2
- Php 8.1
- Php 7.4

## Installed Services :

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

* __Composer__
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


## Prerequisites

##### 1. Install Docker and Docker Compose
Docker must be installed on your system, along with Docker Compose. Follow the instructions in the official or community-provided documentation:  
 
- [How to Install and Use Docker on Ubuntu (DigitalOcean)](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)  
- [How to Install and Use Docker Compose on Ubuntu (DigitalOcean)](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-20-04)  

##### 2. Set Proper Permissions for the `.docker` Directory
The `.docker` folder must have the appropriate permissions to ensure smooth operation. Use the following command to grant necessary permissions:  

```bash
sudo chmod -R 755 .docker/
```
## Setup Instructions

##### 1. Configuration Files
- **`.env` File**: Used to declare global variables such as database username, password, and database name.  
- **`custom-php.ini` File**: Used to define custom `php.ini` variables.  

##### 2. Folder Structure
- **Root Path**: All source files should be placed in the `src/` directory.  
- **Docker Directory**: Create a directory to store your Docker setup, e.g., `docker-local`, and extract all the Docker-related files into this directory.  

##### 3. Docker Commands
- Create a folder anywhere like `docker-local` in your system and extract all the Files In the Above Folder.

- Go to the above directory an Run Command : 
    ```bash
    bash docker-setup.sh
    ```
- Build the Docker images:  
   ```bash
   docker-compose build
    ```
- Start the Docker containers in detached mode:
    ```bash
    docker-compose up -d
    ```
- Verify that the containers are running:
    ```bash
    docker ps
    ```
- Add the following entry to your /etc/hosts file and save it:
    ```bash
    127.0.0.1    localhost    local.docker.com
    ``` 
- Restart the Docker containers:
    ```bash
    docker-compose restart
    ```  
- Accessing the Docker Container, To access the webserver container's shell as the `jarvis` user:
   ```bash
   docker-compose exec webserver su jarvis
   ```
  
- Access **Apache WebServer :** http://localhost/

     ![alt text](https://github.com/mdshahbazsid/docker-webserver/blob/main/src/misc/docker-webserver-success.png?raw=true)

- Access **phpMyAdmin :** http://localhost:8081/

    ![alt text](https://github.com/mdshahbazsid/docker-webserver/blob/main/src/misc/docker-phpmyadmin-success.png?raw=true)

- Access **MailHog :** http://localhost:8025/

    ![alt text](https://github.com/mdshahbazsid/docker-webserver/blob/main/src/misc/docker-mailhog-success.png?raw=true)
    
- Access **ElasticSearch :** http://localhost:9200/

    ![alt text](https://github.com/mdshahbazsid/docker-webserver/blob/main/src/misc/docker-elasticsearch-success.png?raw=true)
  
## Setup Magento 2

- **Install Magento 2.x :** All the commands below must be executed inside the Docker container.

- **Create Empty Directory :** To install Magento Create the Empty directory By Command:
    ```bash
    mkdir magento
    cd magento
    ```

- **Create Empty Database :** Create empty database by running below command:
    ```bash
    (This command must be run outside the Docker container) :
    -----------------------------------------------------------------------------
    docker exec -it <mysql-container-name> -uroot -ppassword -e 'CREATE DATABASE magento;'
    ```
  
- **Community Edition (CE) :** To install the Community Edition (CE), use the following command:
    ```bash
    composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition=2.*
    ```  
  
- **Enterprise Edition (EE) :** To install the Enterprise Edition (EE), use the following command:
    ```bash
    composer create-project --repository-url=https://repo.magento.com/ magento/project-enterprise-edition=2.*
    ```  
  
- **Magento Installation Command**
    ```bash
    php bin/magento setup:install \
    --base-url=http://local.docker.com/magento/pub/ \
    --db-host=mysql-db \
    --db-name=magento \
    --db-user=root \
    --db-password=password \
    --admin-firstname=Admin \
    --admin-lastname=Admin \
    --admin-email=admin@admin.com \
    --admin-user=admin \
    --admin-password=admin123 \
    --language=en_US \
    --currency=USD \
    --timezone=America/Chicago \
    --backend-frontname="admin" \
    --use-rewrites=1 \
    --search-engine=elasticsearch7 \
    --elasticsearch-host=elasticsearch \
    --elasticsearch-port=9200
    ```
  
- **Disable Two-Factor Authentication Modules :** To disable the two-factor authentication modules, use the following command:
    ```bash
    php bin/magento module:disable Magento_AdminAdobeImsTwoFactorAuth Magento_TwoFactorAuth
    ```
  
- **Install Magento Sample Data :** To deploy Magento sample data, use the following command:
    ```bash
    php bin/magento sampledata:deploy
    ```
  
- **Run Magento Commands Using a Script :** To simplify running Magento commands, you can use the deploy_magento.sh script. Make sure the script is located in the Magento root directory.
    ```bash
    bash deploy_magento.sh
    ```
    **Note :**  Ensure the file deploy_magento.sh exists in the <magento-root>/ directory.

## Help and Support

- Custom Php ini file support : .docker/custom-php.ini
- File deploy_magento.sh Location : src/misc/deploy_magento.sh
- Magento Command Help : src/misc/Help_Mage.txt
- Known Docker Issues Refer to File : Issues.txt


## Maintainer
- Dev. Mohd Shahbaz | @mdshahbazsid@gmail.com
