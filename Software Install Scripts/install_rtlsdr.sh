#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Update and install required dependencies
print_info "Updating package lists and installing required dependencies..."
sudo apt update
sudo apt install -y git cmake build-essential libusb-1.0-0-dev

# Clone the rtl-sdr repository
print_info "Cloning the rtl-sdr repository from GitHub..."
if [ ! -d "rtl-sdr" ]; then
    git clone https://github.com/osmocom/rtl-sdr.git
fi

cd rtl-sdr

# Create a build directory
print_info "Setting up the build directory..."
mkdir -p build
cd build

# Configure the build
print_info "Configuring the build..."
cmake ../

# Compile the source code
print_info "Compiling the source code..."
make

# Install the software
print_info "Installing the software..."
sudo make install
sudo ldconfig

# Install udev rules and reload them
print_info "Setting up udev rules..."
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

# Blacklist the default RTL drivers
print_info "Blacklisting default RTL drivers..."
echo 'blacklist dvb_usb_rtl28xxu' | sudo tee /etc/modprobe.d/blacklist-rtl.conf

# Allow user to use the RTL-SDR without root privileges
print_info "Setting up permissions for RTL-SDR..."
sudo usermod -aG plugdev $USER
sudo cp ../rtl-sdr.rules /etc/udev/rules.d/
sudo udevadm control --reload
sudo service udev restart
sudo udevadm trigger

print_info "Installation and setup completed!"

