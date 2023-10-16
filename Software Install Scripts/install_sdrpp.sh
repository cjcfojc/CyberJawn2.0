#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Install dependencies for SDR++
print_info "Installing dependencies for SDR++..."
sudo apt-get update
sudo apt-get install -y git cmake build-essential \
                        libglfw3-dev libglew-dev \
                        libvolk2-dev libsoapysdr-dev \
                        libairspy-dev libhackrf-dev \
                        librtlsdr-dev libbladerf-dev

# Clone the SDR++ repository
print_info "Cloning SDR++ repository from GitHub..."
git clone https://github.com/AlexandreRouma/SDRPlusPlus.git

# Navigate to the cloned directory and make a build directory
cd SDRPlusPlus
mkdir build
cd build

# Configure and compile SDR++
print_info "Configuring and compiling SDR++..."
cmake ..
make -j$(nproc)

# Install the software
print_info "Installing SDR++..."
sudo make install

# Create Desktop Entry for SDR++
print_info "Creating Desktop Icon for SDR++..."
cat > ~/Desktop/SDRPlusPlus.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=SDR++
Exec=sdrpp
Icon=path_to_icon.png
Comment=Run SDR++
Terminal=false
Categories=HamRadio;Radio;
EOL

chmod +x ~/Desktop/SDRPlusPlus.desktop

print_info "Installation and setup of SDR++ completed!"

