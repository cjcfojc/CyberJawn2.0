#!/bin/bash

# Exit on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Update and upgrade the system
print_info "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install Python and PIP
print_info "Installing Python and PIP..."
sudo apt install -y python3 python3-pip

# Install Git
print_info "Installing Git..."
sudo apt install -y git

# Install Meshtastic Python CLI
print_info "Installing Meshtastic Python CLI..."
pip3 install --user meshtastic --break-system-packages

# Add user to dialout group for serial port access (e.g., USB)
print_info "Adding user to dialout group..."
sudo usermod -a -G dialout $USER

# Clone Meshtastic repository (optional, if you need to work with the source code)
print_info "Cloning Meshtastic repository..."
git clone https://github.com/meshtastic/Meshtastic-python.git

# Navigate into the repository directory
cd Meshtastic-python

# Install Meshtastic-python dependencies
print_info "Installing Meshtastic-python dependencies..."
pip3 install -r requirements.txt --break-system-packages

# Add local bin to PATH if it's not already there
if ! grep -q '^\s*export PATH="\$HOME/.local/bin:\$PATH"' "$HOME/.bashrc"; then
    print_info "Adding $HOME/.local/bin to PATH in .bashrc..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Reboot (optional, but recommended due to group changes)
print_info "Installation completed. It's recommended to reboot the system now."

