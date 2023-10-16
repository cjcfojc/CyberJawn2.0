#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Update repositories
print_info "Updating repositories..."
sudo apt update

# Install KDE Marble and its data packages
print_info "Installing KDE Marble and map packages..."
sudo apt install -y marble marble-data marble-plugins

print_info "Installation of KDE Marble and its map packages completed!"

