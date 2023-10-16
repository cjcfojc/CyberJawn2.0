#!/bin/bash

# Exit script on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Install necessary packages
print_info "Setting up virtual audio sink..."
sudo apt update
sudo apt install -y pavucontrol

# Virtual audio sink
sudo bash -c 'echo "load-module module-null-sink sink_name=Virtual_Sink sink_properties=device.description=Virtual_Sink" >> /etc/pulse/default.pa'

# Restart PulseAudio
pulseaudio -k
print_info "Virtual audio sink 'Virtual_Sink' has been configured successfully."

# Install dependencies for WSJT-X
print_info "Installing dependencies for WSJT-X..."
sudo apt-get install -y g++ cmake libfftw3-dev \
                        libboost-all-dev libgsl-dev \
                        libqt5serialport5-dev \
                        asciidoctor python3-pygments \
                        libusb-1.0-0-dev

# Clone the WSJT-X repository
print_info "Cloning WSJT-X repository from GitHub..."
git clone https://github.com/wsjt-x/wsjt.git

# Navigate to the cloned directory and make a build directory
cd wsjt
mkdir build
cd build

# Configure and compile WSJT-X
print_info "Configuring and compiling WSJT-X..."
cmake ..
make -j$(nproc)

# Install the software
print_info "Installing WSJT-X..."
sudo make install

# Create Desktop Entry for WSJT-X
print_info "Creating Desktop Icon for WSJT-X..."
cat > ~/Desktop/WSJTX.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=WSJT-X
Exec=wsjtx
Icon=path_to_icon.png
Comment=Run WSJT-X
Terminal=false
Categories=HamRadio;Radio;
EOL

chmod +x ~/Desktop/WSJTX.desktop
print_info "Installation and setup of WSJT-X completed!"

