#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Download and install NWJS
print_info "Downloading and installing NWJS..."
wget -O nwjs-downloader.deb "https://gridtracker.org/index.php/downloads/debian-nwjs-downloader/routedownload/nwjs-downloader-0-68-1"
sudo apt install ./nwjs-downloader.deb
sudo apt-get install -f
nwjs-downloader --install

# Download and extract GridTracker
print_info "Downloading and installing GridTracker..."
wget -O GridTracker.tar.gz "https://downloads.gridtracker.org/v1.23.1015/GridTracker-1.23.1015-linux-arm64.tar.gz"
mkdir -p GridTracker
tar -xf GridTracker.tar.gz -C GridTracker

# Provide execute permissions to the GridTracker binary
chmod +x GridTracker/GridTracker*

# Create Desktop Entry for GridTracker
print_info "Creating Desktop Icon for GridTracker..."
cat > ~/Desktop/GridTracker.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=GridTracker
Exec=$(pwd)/GridTracker/GridTracker
Icon=$(pwd)/GridTracker/path_to_icon.png
Comment=Run GridTracker
Terminal=false
Categories=HamRadio;
EOL

chmod +x ~/Desktop/GridTracker.desktop

print_info "GridTracker and its NWJS dependency are installed!"
print_info "To run GridTracker, navigate to the GridTracker directory and execute the GridTracker binary."

