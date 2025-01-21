#!/bin/bash

# Function to update or add a variable in docker .env file
update_env_variable() {
    local key=$1
    local value=$2

    # Check if the .env file exists
    if [ ! -f "$DOCKER_ENV_FILE" ]; then
        echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: .env file not found at $DOCKER_ENV_FILE ${ENDCOLOR}"
        exit 1
    fi

    # Check if the variable exists in the file
    if grep -q "^${key}=" "$DOCKER_ENV_FILE"; then

        # Existing value
        local current_value
        current_value=$(grep "^${key}=" "$DOCKER_ENV_FILE" | cut -d'=' -f2)
        echo -e "   ${GREEN}➜ Skipped updating ${key} = ${value}, Already Present ${key} = ${current_value}${ENDCOLOR}"
    else
        # Append the variable if it doesn't exist
        echo "${key}=${value}" >> "$DOCKER_ENV_FILE"
        echo -e "   ${GREEN}➜ Added : ${key} = ${value}${ENDCOLOR}"
    fi
}

# Function to update php version in Dockerfile
update_php_variable() {
    local php_version=$1

    # Check if the Dockerfile file exists
    if [ ! -f "$DOCKER_FILE" ]; then
        echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: Dockerfile file not found at $DOCKER_FILE ${ENDCOLOR}"
        exit 1
    fi

    # Check if php_version placeholder is present in Dockerfile
    if grep -q "php:PHP_VERSION-apache" $DOCKER_FILE; then
        # Replace php:PHP_VERSION-apache with the desired version (e.g., 7.4)
        sed -i "s/php:PHP_VERSION-apache/php:${php_version}-apache/" $DOCKER_FILE
        echo -e "   ${GREEN}➜ Added : PHP Version = ${php_version} In Dockerfile.${ENDCOLOR}"
    else
        # Check if the PHP version is already set in Dockerfile (e.g., php:8.5-apache)
        current_version=$(grep -oP 'FROM php:\K[0-9.]+(?=-apache)' $DOCKER_FILE)
        if [ -n "$current_version" ]; then
            echo -e "   ${GREEN}➜ Skipped Updating PHP version ${php_version}, Already Present PHP version ${current_version}.${ENDCOLOR}"
        else
            echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: No PHP version found in Docker. ${ENDCOLOR}"
            exit 1
        fi
    fi
}

# Function to update SMTP PORT in custom-php.ini file
update_smptport_variable() {
    local smptport=$1

    # Check if the custom-php.ini file exists
    if [ ! -f "$CUSTOM_PHP_INI_FILE" ]; then
        echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: custom-php.ini file not found at $CUSTOM_PHP_INI_FILE ${ENDCOLOR}"
        exit 1
    fi

    # Check if SMTP_PORT placeholder is present in custom-php.ini
    if grep -q "mailhog:SMTP_PORT" $CUSTOM_PHP_INI_FILE; then
        # Replace mailhog:SMTP_PORT with the desired port
        sed -i "s/mailhog:SMTP_PORT/mailhog:${smptport}/" $CUSTOM_PHP_INI_FILE
        echo -e "   ${GREEN}➜ Added : SMTP Port = ${smptport} In custom-php.ini file.${ENDCOLOR}"
    else
        # Check if the smptport version is already set in custom-php.ini
	current_value=$(grep -- 'smtp-addr=mailhog:' "$CUSTOM_PHP_INI_FILE" | sed 's/.*mailhog://; s/"//g')
        if [ -n "$current_value" ]; then
            echo -e "   ${GREEN}➜ Skipped Updating SMTP Port ${smptport}, Already Present Port ${current_value}.${ENDCOLOR}"
        else
            echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: No SMTP_POST found in Docker. ${ENDCOLOR}"
            exit 1
        fi
    fi
}

# Function to validate PHP_VERSION in Dockerfile
validate_php_version() {

    # Check if the Dockerfile file exists
    if [ ! -f "$DOCKER_FILE" ]; then
        echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: Dockerfile file not found at $DOCKER_FILE ${ENDCOLOR}"
        exit 1
    fi

    # Extract the PHP_VERSION Line from the Dockerfile
    if ! php_version_line=$(grep -E '^FROM php:[^ ]+-apache' "$DOCKER_FILE"); then
        echo "Error: No valid FROM line found in $DOCKER_FILE"
        exit 1
    fi

    # Extract the version part from the line
    local php_version=$(echo "$php_version_line" | sed -E 's/^FROM php:([^ ]+)-apache/\1/')
        
    # Check if the version matches the required patterns
    if [[ "$php_version" =~ ^[0-9]+\.[0-9]+$ ]]; then
        return 0  # Valid version
    else
        return 1  # Invalid version
    fi
}

# Function to check if a command runs without errors
command_runs() {
    "$1" --version >/dev/null 2>&1
}


# Function To Build Docker
build_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD build && \
      echo -e "
 ===================== 🚀 Done 🚀 ===========================================================

        Created by Dev. Mohd Shahbaz
        v.${VERSION}
        ${GREEN}➜ Success :${ENDCOLOR} Now, Please Run ${CYAN}bash docker-start${ENDCOLOR} To Start The Containers.

 ===================== 🚀 Done 🚀 ==========================================================="
}

# Function To Start Docker
start_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD up -d && \
      echo -e "
 ===================== 🚀 Done 🚀 ===================

        Created by Dev. Mohd Shahbaz
        v.${VERSION}
        Access your links:

        🌎 ${GREEN}Web server:${ENDCOLOR} http://localhost/
        ✉️  ${GREEN}Local emails:${ENDCOLOR} http://localhost:8025
        ⚙️  ${GREEN}PhpMyAdmin:${ENDCOLOR} http://localhost:8081
        🔍 ${GREEN}ElasticSearch:${ENDCOLOR} http://localhost:9200
        ☁️  ${GREEN}Ngrok:${ENDCOLOR} http://localhost:4040

 ===================== 🚀 Done 🚀 ==================="
}


# Function To Stop Docker
stop_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD down 
}

# Function To Restart Docker
restart_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD restart 
}

# Function To check the services in Docker
show_service_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD ps 
}

# Function To Stop Docker
stop_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD down 
}

# Function To Stop Docker
restart_docker() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD restart 
}

# Function To get inside the docker user - jarvis
inside_docker_bash_user() {
    #Determine which command to use
      if command_runs docker-compose; then
            DOCKER_COMPOSE_CMD="docker-compose"
      elif command_runs docker compose; then
            DOCKER_COMPOSE_CMD="docker compose"
      else
            echo -e "${RED}✖ Error :${ENDCOLOR} Neither 'docker-compose' nor 'docker compose' is available."
            exit 1
      fi

      # Usage of the determined command
      $DOCKER_COMPOSE_CMD exec webserver su jarvis 
}
