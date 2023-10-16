#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Install dependencies for SDR++
print_info "Installing dependencies for SDR++..."
sudo apt update
sudo apt install -y git cmake build-essential \
                        libglfw3-dev libglew-dev \
                        libvolk2-dev libsoapysdr-dev \
                        libairspy-dev libhackrf-dev \
                        librtlsdr-dev libbladerf-dev \
                        libfftw3-dev libzstd-dev \
                        libairspyhf-dev libairspyhf1 \
                        librtaudio-dev libiio-dev \
                        libad9361-dev

# Clone the SDR++ repository
print_info "Cloning SDR++ repository from GitHub..."
if [ ! -d "SDRPlusPlus" ]; then
    git clone https://github.com/AlexandreRouma/SDRPlusPlus.git
fi

# Navigate to the cloned directory and make a build directory
cd SDRPlusPlus
mkdir -p build
cd build

# Configure and compile SDR++
print_info "Configuring and compiling SDR++..."
cmake ..
make -j$(nproc)

# Install the software
print_info "Installing SDR++..."
sudo make install

print_info "Installation and setup of SDR++ completed!"

