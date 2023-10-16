#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Ensure dependencies
print_info "Updating package list..."
sudo apt update > /dev/null
print_info "Ensuring wget is installed..."
sudo apt install -y wget

# Download and install NWJS
print_info "Downloading and installing NWJS..."
wget -O nwjs-downloader.deb "https://raw.githubusercontent.com/cjcfojc/CyberJawn2.0/main/nwjs-downloader_0.68.1-1_all.deb"
sudo apt install ./nwjs-downloader.deb
sudo apt install -f

# Clean up the nwjs-downloader.deb file
rm nwjs-downloader.deb

# Download and extract GridTracker
print_info "Downloading and installing GridTracker..."
wget -O GridTracker.tar.gz "https://downloads.gridtracker.org/v1.23.1015/GridTracker-1.23.1015-linux-arm64.tar.gz"
mkdir -p GridTracker
tar -xf GridTracker.tar.gz -C GridTracker

# Clean up the GridTracker.tar.gz file
rm GridTracker.tar.gz

# Provide execute permissions to the GridTracker binary
chmod +x GridTracker/GridTracker*

print_info "GridTracker and its NWJS dependency are installed!"
print_info "To run GridTracker, navigate to the GridTracker directory and execute the GridTracker binary."

