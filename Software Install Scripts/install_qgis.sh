#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

print_info "Setting up the QGIS repository and installing QGIS..."

# Add the QGIS signing key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key 51F523511C7028C3

# Add the QGIS repository
echo 'deb https://qgis.org/ubuntu-ltr focal main' | sudo tee /etc/apt/sources.list.d/qgis.list

# Update the system
sudo apt update

# Install QGIS
sudo apt install -y qgis qgis-plugin-grass

# Create Desktop Entry for QGIS
print_info "Creating Desktop Icon for QGIS..."
cat > ~/Desktop/QGIS.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=QGIS
Exec=qgis
Icon=path_to_icon.png
Comment=Run QGIS
Terminal=false
Categories=GIS;Geography;Science;
EOL

chmod +x ~/Desktop/QGIS.desktop

print_info "Installation and setup of QGIS completed!"
