#!/bin/bash

set -e

# Get the directory where the script is located
SCRIPT_DIR=$(dirname "$(realpath "$0")")

# Include .sh
source .bash/docker-env.sh
source .bash/docker-utility.sh

echo -e "${BOLDYELLOW}======================================================================${ENDCOLOR}"
echo -e "${BOLDYELLOW}Script By Dev. Mohd Shahbaz (mdshahbazsid@gmail.com)                  ${ENDCOLOR}"
echo -e "${BOLDYELLOW}======================================================================${ENDCOLOR}"
sleep 2

PS3='**Please Select The PHP Version For Which The Docker Image Will Setup : '
options=(
"Php - 7.4"
"Php - 8.1"
"Php - 8.2"
"Php - 8.3"
"Quit"
)
select opt in "${options[@]}"
do
    case $opt in
        "Php - 7.4")
            echo -e "${GREEN}✔${ENDCOLOR} ${BOLDYELLOW}You Choosed : $opt${ENDCOLOR}"
            
            # Start the timer
            start_time=$(date +%s.%N)

            # Process
            update_smptport_variable "$PORT_MAILHOG_SMTP"
            sleep 1
            update_php_variable "$PHP_VERSION_74"
            sleep 1
            update_env_variable "PHP_VERSION" "$PHP_VERSION_74"
            sleep 1
            update_env_variable "COMPOSER_VERSION" "$COMPOSER_VERSION_74"
            sleep 1
            update_env_variable "MARIA_DB_VERSION" "$MARIA_DB_VERSION_74"
            sleep 1
            update_env_variable "VARNISH_VERSION" "$VARNISH_VERSION_74"
            sleep 1
            update_env_variable "ELASTICSEARCH_VERSION" "$ELASTICSEARCH_VERSION_74"
            sleep 1

            # End the timer
            end_time=$(date +%s.%N)

            # Calculate duration
            duration=$(echo "$end_time - $start_time" | bc)
            formatted_duration=$(printf "%.1fs" "$duration")
            echo -e "${GREEN}✔${ENDCOLOR} ${CYAN}Exported Environment Variables For $opt${ENDCOLOR}               ${GREEN}${formatted_duration} Done.${ENDCOLOR}"
            break;
            ;;
        "Php - 8.1")
            echo -e "${GREEN}✔${ENDCOLOR} ${BOLDYELLOW}You Choosed : $opt${ENDCOLOR}"
            
            # Start the timer
            start_time=$(date +%s.%N)

            # Process
            update_smptport_variable "$PORT_MAILHOG_SMTP"
            sleep 1
            update_php_variable "$PHP_VERSION_81"
            sleep 1
            update_env_variable "PHP_VERSION" "$PHP_VERSION_81"
            sleep 1
            update_env_variable "COMPOSER_VERSION" "$COMPOSER_VERSION_81"
            sleep 1
            update_env_variable "MARIA_DB_VERSION" "$MARIA_DB_VERSION_81"
            sleep 1
            update_env_variable "VARNISH_VERSION" "$VARNISH_VERSION_81"
            sleep 1
            update_env_variable "ELASTICSEARCH_VERSION" "$ELASTICSEARCH_VERSION_81"
            sleep 1

            # End the timer
            end_time=$(date +%s.%N)

            # Calculate duration
            duration=$(echo "$end_time - $start_time" | bc)
            formatted_duration=$(printf "%.1fs" "$duration")
            echo -e "${GREEN}✔${ENDCOLOR} ${CYAN}Exported Environment Variables For $opt${ENDCOLOR}               ${GREEN}${formatted_duration} Done.${ENDCOLOR}"
            break;
            ;;
        "Php - 8.2")
            echo -e "${GREEN}✔${ENDCOLOR} ${BOLDYELLOW}You Choosed : $opt${ENDCOLOR}"
            
            # Start the timer
            start_time=$(date +%s.%N)

            # Process
            update_smptport_variable "$PORT_MAILHOG_SMTP"
            sleep 1
            update_php_variable "$PHP_VERSION_82"
            sleep 1
            update_env_variable "PHP_VERSION" "$PHP_VERSION_82"
            sleep 1
            update_env_variable "COMPOSER_VERSION" "$COMPOSER_VERSION_82"
            sleep 1
            update_env_variable "MARIA_DB_VERSION" "$MARIA_DB_VERSION_82"
            sleep 1
            update_env_variable "VARNISH_VERSION" "$VARNISH_VERSION_82"
            sleep 1
            update_env_variable "ELASTICSEARCH_VERSION" "$ELASTICSEARCH_VERSION_82"
            sleep 1

            # End the timer
            end_time=$(date +%s.%N)

            # Calculate duration
            duration=$(echo "$end_time - $start_time" | bc)
            formatted_duration=$(printf "%.1fs" "$duration")
            echo -e "${GREEN}✔${ENDCOLOR} ${CYAN}Exported Environment Variables For $opt${ENDCOLOR}               ${GREEN}${formatted_duration} Done.${ENDCOLOR}"
            break;
            ;;
        "Php - 8.3")
            echo -e "${GREEN}✔${ENDCOLOR} ${BOLDYELLOW}You Choosed : $opt${ENDCOLOR}"
            
            # Start the timer
            start_time=$(date +%s.%N)

            # Process
            update_smptport_variable "$PORT_MAILHOG_SMTP"
            sleep 1
            update_php_variable "$PHP_VERSION_83"
            sleep 1
            update_env_variable "PHP_VERSION" "$PHP_VERSION_83"
            sleep 1
            update_env_variable "COMPOSER_VERSION" "$COMPOSER_VERSION_83"
            sleep 1
            update_env_variable "MARIA_DB_VERSION" "$MARIA_DB_VERSION_83"
            sleep 1
            update_env_variable "VARNISH_VERSION" "$VARNISH_VERSION_83"
            sleep 1
            update_env_variable "ELASTICSEARCH_VERSION" "$ELASTICSEARCH_VERSION_83"
            sleep 1

            # End the timer
            end_time=$(date +%s.%N)

            # Calculate duration
            duration=$(echo "$end_time - $start_time" | bc)
            formatted_duration=$(printf "%.1fs" "$duration")
            echo -e "${GREEN}✔${ENDCOLOR} ${CYAN}Exported Environment Variables For $opt${ENDCOLOR}               ${GREEN}${formatted_duration} Done.${ENDCOLOR}"
            break;
            ;;
        "Quit")
            echo -e "${RED}✖${ENDCOLOR} ${BOLDRED}Quiting...${ENDCOLOR}"
            break
            ;;
        *) echo -e "${RED}✖${ENDCOLOR} ${BOLDRED}Invalid Option : $REPLY ${ENDCOLOR}";;
    esac
done

