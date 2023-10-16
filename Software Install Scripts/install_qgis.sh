#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing QGIS..."

# Update the system
sudo apt update

# Install QGIS
sudo apt install -y qgis

print_info "Installation of QGIS completed!"

