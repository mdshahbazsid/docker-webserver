#!/bin/bash

set -e

RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
CYAN="\e[36m"
MAGENTA="\e[35m"
BLUE="\e[34m"
LIGHTMAGENTA="\e[95m"

BOLDRED="\e[1;31m"
BOLDGREEN="\e[1;32m"
BOLDYELLOW="\e[1;33m"
BOLDCYAN="\e[1;36m"
ITALICRED="\e[3;31m"

ENDCOLOR="\e[0m"

echo -e "${BOLDYELLOW}======================================================================${ENDCOLOR}"
echo -e "${BOLDYELLOW}STARTING Script By Dev. Mohd Shahbaz ...                              ${ENDCOLOR}"
echo -e "${BOLDYELLOW}======================================================================${ENDCOLOR}"
sleep 2

PS3='**Please Enter Your Choice : '
options=(
"Full Deploy (Upgrade + Compile + Static Content Deploy)"
"Only Static-Content Deploy"
"Only Setup-Upgrade"
"Only Di-Compile"
"Run Indexers"
"Cache Flush"
"Enable Maintenance Mode"
"Disable Maintenance Mode"
"Quit"
)
select opt in "${options[@]}"
do
    case $opt in
        "Full Deploy (Upgrade + Compile + Static Content Deploy)")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}ENABLING Maintenance Mode ...                                         ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento maintenance:enable
            echo "------ || Maintenance Mode Enabled || ------"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}REMOVING FILES : (cache/di/generation/pub/static/view_processed)...   ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            rm -rf var/cache/*
            rm -rf var/page_cache/*
            rm -rf var/di/*
            rm -rf var/generation/*
            rm -rf var/view_processed/*
            rm -rf pub/static/*

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Setup Upgrade ...                                             ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento setup:upgrade
            echo "------ || Finished Setup Upgrade || ------"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Di Compile ...                                                ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento setup:di:compile
            echo "------ || Finished Di Compile || ------"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Static Content Deploy ...                                     ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento setup:static-content:deploy -f
            echo "------ || Finished Deploy || ------"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Cache Flush ...                                               ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento cache:flush
            echo "------ || Finished Cache Flush || ------"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}DISABLING Maintenance Mode ...                                        ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento maintenance:disable
            echo "------ || Maintenance Mode Disabled ||  ------"
            break;
            ;;
        "Only Static-Content Deploy")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}REMOVING FILES : (pub/static, var/view_processed files)...            ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            rm -rf var/cache/*
            rm -rf var/page_cache/*
            rm -rf var/view_processed/*
            rm -rf pub/static/*

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Static Content Deploy ...                                     ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento setup:static-content:deploy -f
            echo "------ || Finished Deploy || ------"
            break;
            ;;
        "Only Setup-Upgrade")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Setup Upgrade ...                                             ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento setup:upgrade
            echo "------ || Finished Setup Upgrade || ------"
            break;
            ;;
        "Only Di-Compile")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}REMOVING FILES : (var/di/generated)...                                ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            rm -rf genearted/*
            rm -rf var/cache/*

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Di Compile ...                                                ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento setup:di:compile
            echo "------ || Finished Di Compile || ------"
            break
            ;;
        "Run Indexers")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Indexers ...                                                  ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento indexer:reindex
            echo "------ || Finished Reindexing || ------"
            break
            ;;
        "Cache Flush")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}RUNNING Cache Flush ...                                               ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento cache:flush
            echo "------ || Finished Cache Flush || ------"
            break
            ;;
        "Enable Maintenance Mode")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}ENABLING Maintenance Mode ...                                         ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento maintenance:enable
            echo "------ || Maintenance Mode Enabled || ------"
            break
            ;;
        "Disable Maintenance Mode")
            echo -e "${BOLDCYAN}You Choosed - $opt${ENDCOLOR}"
            sleep 2

            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            echo -e "${CYAN}DISABLING Maintenance Mode ...                                        ${ENDCOLOR}"
            echo -e "${CYAN}======================================================================${ENDCOLOR}"
            php -d memory_limit=-1 bin/magento maintenance:disable
            echo "------ || Maintenance Mode Disabled ||  ------"
            break
            ;;
        "Quit")
            echo -e "${BOLDRED}Quiting...${ENDCOLOR}"
            break
            ;;
        *) echo -e "${BOLDRED}Invalid Option - $REPLY ${ENDCOLOR}";;
    esac
done
sleep 2
echo -e "${BOLDYELLOW}======================================================================${ENDCOLOR}"
echo -e "${BOLDYELLOW}END Script Executed Successfully.                                     ${ENDCOLOR}"
echo -e "${BOLDYELLOW}======================================================================${ENDCOLOR}"
