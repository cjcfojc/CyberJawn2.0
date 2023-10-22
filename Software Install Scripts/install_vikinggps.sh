#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing Viking GPS..."

# Update the system
sudo apt update

# Install Viking GPS and its dependencies
sudo apt install -y viking

# Verify the installation (viking version will be printed)
viking --version

print_info "Installation of Viking GPS completed!"


