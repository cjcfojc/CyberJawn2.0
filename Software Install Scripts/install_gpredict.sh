#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing Gpredict..."

# Update the system
sudo apt update

# Install Gpredict
sudo apt install -y gpredict

print_info "Gpredict installation completed!"

