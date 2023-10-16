#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing FoxtrotGPS, gpsd, and gpsd-tools..."

# Update the system
sudo apt update

# Install FoxtrotGPS, gpsd, and gpsd-tools together
sudo apt install -y foxtrotgps gpsd gpsd-tools

print_info "Installation and setup completed!"

