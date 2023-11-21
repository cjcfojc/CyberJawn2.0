#!/bin/bash

# Exit on any error
set -e

# Function to print messages
print_info() {
    echo -e "\e[34mINFO: $1\e[0m"
}

# Check if a package is installed
check_package() {
    dpkg -s "$1" &> /dev/null
    if [ $? -ne 0 ]; then
        echo "false"
    else
        echo "true"
    fi
}

# Update and upgrade the system
print_info "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Check for Python, PIP, and Git
print_info "Checking for required packages..."
REQUIRED_PKGS=("python3" "python3-pip" "git")
for pkg in "${REQUIRED_PKGS[@]}"; do
    if [ $(check_package "$pkg") = "false" ]; then
        print_info "Installing $pkg..."
        sudo apt install -y "$pkg"
    else
        print_info "$pkg is already installed."
    fi
done

# Install Meshtastic Python CLI
print_info "Installing Meshtastic Python CLI..."
pip3 install --user meshtastic --break-system-packages

# Add user to dialout group for serial port access (e.g., USB)
print_info "Adding user to dialout group..."
sudo usermod -a -G dialout $USER

# Clone Meshtastic repository (optional, if you need to work with the source code)
print_info "Cloning Meshtastic repository..."
if [ ! -d "Meshtastic-python" ]; then
    git clone https://github.com/meshtastic/Meshtastic-python.git
else
    print_info "Meshtastic-python repository already cloned."
fi

# Navigate into the repository directory and install dependencies
cd Meshtastic-python
print_info "Installing Meshtastic-python dependencies..."
pip3 install -r requirements.txt --break-system-packages

# Check if PATH already contains .local/bin
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    print_info "Adding /home/dietpi/.local/bin to PATH in .bashrc..."
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
else
    print_info "/home/dietpi/.local/bin is already in PATH."
fi

print_info "Installation and setup completed!"

