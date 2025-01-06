#!/bin/bash

# Set the Magento root directory
MAGENTO_DIR=$(pwd)

# Change to the Magento root directory
cd $MAGENTO_DIR

# Find all Magento modules and their composer.json files
MODULES=$(find app/code/ -type f -name composer.json)

# Loop through each module and extract name and version
for MODULE_FILE in $MODULES; do
    MODULE_NAME=$(jq -r '.name' $MODULE_FILE)
    MODULE_VERSION=$(jq -r '.version' $MODULE_FILE)

    # Print module name and version
    echo "Module: $MODULE_NAME, Version: $MODULE_VERSION"
done
