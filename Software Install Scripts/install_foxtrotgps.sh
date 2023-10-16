#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Installing FoxtrotGPS..."

# Update the system
sudo apt update

# Install FoxtrotGPS
sudo apt install -y foxtrotgps

# Create Desktop Entry for FoxtrotGPS
print_info "Creating Desktop Icon for FoxtrotGPS..."
cat > ~/Desktop/FoxtrotGPS.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=FoxtrotGPS
Exec=foxtrotgps
Icon=path_to_icon.png
Comment=Run FoxtrotGPS
Terminal=false
Categories=GIS;Geography;Science;
EOL

chmod +x ~/Desktop/FoxtrotGPS.desktop

print_info "Installation and setup of FoxtrotGPS completed!"
