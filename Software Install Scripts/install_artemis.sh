#!/bin/bash

# Script to install Artemis on DietPi ARMv8 for RPi4b from source.

echo "Updating the system..."
# Update the system
sudo apt update && sudo apt upgrade -y

echo "Installing required packages..."
# Install required packages
sudo apt install -y qt5-default libpcap-dev libgeoip-dev libssl-dev git python3-pip python3-dev

echo "Cloning the Artemis repository..."
# Clone the Artemis repository
git clone https://github.com/AresValley/Artemis.git
cd Artemis

echo "Installing Python packages..."
# Install Python packages
sudo pip3 install -r requirements.txt

echo "Compiling Artemis..."
# Compilation
qmake Artemis.pro
make

echo "Moving the compiled binary to the appropriate directory..."
# Move the compiled binary to the appropriate directory
sudo mkdir -p /usr/local/Artemis
sudo mv Artemis /usr/local/Artemis/
sudo ln -s /usr/local/Artemis/Artemis /usr/local/bin/Artemis

echo "Installing additional data..."
# Installing additional data
sudo mkdir -p /usr/local/share/Artemis/
sudo cp -r languages/ /usr/local/share/Artemis/
sudo cp -r sounds/ /usr/local/share/Artemis/

# Finishing up
echo "Artemis installation is complete. You can run it by typing 'Artemis' in the terminal."

