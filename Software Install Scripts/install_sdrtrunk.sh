#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing SDRTrunk..."

# Navigate to the home directory
cd ~

# Download SDRTrunk for aarch64
wget https://github.com/DSheirer/sdrtrunk/releases/download/v0.6.0-beta-2/sdr-trunk-linux-aarch64-v0.6.0-beta2.zip

# Extract the downloaded ZIP file
unzip sdr-trunk-linux-aarch64-v0.6.0-beta2.zip

# Remove the downloaded ZIP file to save space
rm sdr-trunk-linux-aarch64-v0.6.0-beta2.zip

# Navigate to the extracted directory (assuming it extracts to a folder named "sdr-trunk")
cd sdr-trunk-linux-aarch64-v0.6.0-beta2/

# Download the JMBE library
wget https://github.com/cjcfojc/CyberJawn2.0/raw/main/jmbe-1.0.9.jar

print_info "SDRTrunk installation and setup completed!"

