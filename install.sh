#!/bin/bash

#Introduce dependency scripts
source ./scripts/lib.sh

# Signal processing
trap 'rm -f .env; exit' SIGINT SIGTSTP SIGTERM

# Clean up unnecessary files
clean_files

# Install dependencies
echo -e "\e[34m========== Checking server environment... | Checking server environment... =========\e[0m"
install_dependencies

# Check environment
echo -e "\e[34m========== Checking the panel environment... | Checking the panel operating environment... =========\e[0m"
check_env

# Setting permissions
echo -e "\e[34m========== Setting Folder Permissions... | Set folder permissions... =========\e[0m"
set_permissions

# Check Composer
echo -e "\e[34m========= Checking Composer... | Checking Composer... =========\e[0m"
check_composer

# Execute Composer installation
echo -e "\e[34m========== Installing packages via Composer... | Installing packages via Composer... =========\e[0m"
composer install --no-interaction --no-dev --optimize-autoloader

# Execute Panel installation
php artisan panel:install

# Set up scheduled tasks
echo -e "\e[34m========== Enabling Panel schedule tasks... | Enabling panel scheduled tasks... =========\e[0m"
set_schedule

# Set Horizon
echo -e "\e[34m========= Setting Horizon daemon... | Setting Horizon daemon... =========\e[0m"
set_horizon

# Download IP database file
echo -e "\e[34m========== Downloading IP database files... | Downloading IP database files... =========\e[0m"
cd scripts/ && bash download_dbs.sh && cd ../
