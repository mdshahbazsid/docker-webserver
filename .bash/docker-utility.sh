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

    # Check if the .env file exists
    if [ ! -f "$DOCKER_FILE" ]; then
        echo -e "   ${RED}✖${ENDCOLOR} ${BOLDRED}Error: Dockerfile file not found at $DOCKER_FILE ${ENDCOLOR}"
        exit 1
    fi

    # Check if php_version placeholder is present in Dockerfile
    if grep -q "php:PHP_VERSION-apache" $DOCKER_FILE; then
        # Replace php:PHP_VERSION-apache with the desired version (e.g., 7.4)
        sed -i "s/php:PHP_VERSION-apache/php:${php_version}-apache/" $DOCKER_FILE
        echo -e "   ${GREEN}➜ Added : ${php_version} In Dockerfile.${ENDCOLOR}"
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

