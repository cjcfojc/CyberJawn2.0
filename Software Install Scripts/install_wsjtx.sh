#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Update repositories and Install necessary packages
print_info "Updating repositories..."
sudo apt update

print_info "Installing pavucontrol and PulseAudio..."
sudo apt install -y pavucontrol pulseaudio

# Ensure PulseAudio is running
pulseaudio --start

# Virtual audio sink
print_info "Setting up virtual audio sink..."
sudo bash -c 'echo "load-module module-null-sink sink_name=Virtual_Sink sink_properties=device.description=Virtual_Sink" >> /etc/pulse/default.pa'

# Restart PulseAudio for changes to take effect
pulseaudio -k
pulseaudio --start
print_info "Virtual audio sink 'Virtual_Sink' has been configured successfully."

# Download WSJT-X .deb package
print_info "Downloading WSJT-X package..."
wget https://wsjt.sourceforge.io/downloads/wsjtx_2.6.1_arm64.deb

# Install WSJT-X from the .deb package
print_info "Installing WSJT-X..."
sudo apt install -y ./wsjtx_2.6.1_arm64.deb

print_info "Installation and setup of WSJT-X completed!"

