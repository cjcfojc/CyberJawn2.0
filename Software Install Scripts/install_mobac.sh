#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing Mobile Atlas Creator (MOBAC)..."

# Update the system
sudo apt update

# Install Java Runtime Environment (JRE) and other necessary utilities
sudo apt install -y openjdk-11-jre unzip

# Verify the Java installation
java -version

# Define the location for MOBAC
MOBAC_DIR="$HOME/mobac"

# Download and extract MOBAC from SourceForge
print_info "Downloading MOBAC from SourceForge..."
mkdir -p $MOBAC_DIR
wget -O $MOBAC_DIR/MOBAC.zip "https://sourceforge.net/projects/mobac/files/Mobile%20Atlas%20Creator/MOBAC%202.0/Mobile%20Atlas%20Creator%202.3.3.zip/download"
unzip $MOBAC_DIR/MOBAC.zip -d $MOBAC_DIR

print_info "Installation of Mobile Atlas Creator (MOBAC) completed!"

