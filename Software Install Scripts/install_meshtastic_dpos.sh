#!/bin/bash

# Exit on any error
set -e

# Print a message
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Update System
print_info "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install Python and PIP with break-system-packages option
print_info "Installing Python and PIP..."
dietpi-software install 130 --break-system-packages

# Install Git
print_info "Installing Git..."
sudo apt install -y git

# Install Meshtastic Python CLI
print_info "Installing Meshtastic Python CLI..."
pip3 install --user meshtastic --break-system-packages

# Add user to dialout group for serial port access (e.g., USB)
print_info "Adding user to dialout group..."
sudo usermod -a -G dialout $USER

# Clone Meshtastic repository (optional, for development or advanced uses)
print_info "Cloning Meshtastic repository..."
git clone https://github.com/meshtastic/Meshtastic-python.git

# Navigate into the Meshtastic-python directory
cd Meshtastic-python

# Install Meshtastic-python dependencies
print_info "Installing Meshtastic-python dependencies..."
pip3 install -r requirements.txt --break-system-packages

# Reboot (optional, but recommended due to group changes)
print_info "Installation completed. It's recommended to reboot the system now."

