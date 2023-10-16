#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing JS8Call for armhf on ARM64 architecture..."

# Update the system
sudo apt update

# Add armhf architecture
sudo dpkg --add-architecture armhf
sudo apt update

# Download the JS8Call .deb package for armhf
print_info "Downloading JS8Call for armhf..."
wget http://files.js8call.com/latest/js8call_2.2.0_armhf.deb

# Install JS8Call
print_info "Installing JS8Call..."
sudo apt install -y ./js8call_2.2.0_armhf.deb

# Clean up
rm js8call_2.2.0_armhf.deb

print_info "JS8Call installation completed!"

