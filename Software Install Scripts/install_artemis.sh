#!/bin/bash

# Define error handling function
function handle_error {
    echo "Error occurred on line $1."
    exit 1
}

# Set trap for error handling
trap 'handle_error $LINENO' ERR

# Update and upgrade the system
sudo apt-get update && sudo apt-get upgrade -y

# Installing essential tools
sudo apt-get install -y git

# Clone Artemis repository
git clone https://github.com/AresValley/Artemis.git

# Change to the Artemis directory
cd Artemis

# Change to the spec_files/Linux directory
cd spec_files/Linux

# Installing dependencies and setting up the environment
sudo apt-get update
sudo apt-get install -y build-essential python3 python3-pip python3-dev python3-venv python3-setuptools zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libopenjp2-7-dev libssl-dev libharfbuzz0b libfreetype6 libgstreamer-plugins-base0.10-0 libgstreamer-plugins-good0.10-0 libpulse0
sudo apt-get install -y python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-webkit2-4.0
sudo apt-get install -y python3-tk

# Setting alias for Python commands
echo "alias python3=python" >> ~/.bash_aliases
echo "alias pip3=pip" >> ~/.bash_aliases
echo "alias python-config=python3-config" >> ~/.bash_aliases

# Reload the bash configuration to apply aliases
source ~/.bashrc

# Install PyInstaller
pip3 install pyinstaller

# Install Artemis requirements
pip3 install --break-system-packages -r requirements/requirements.txt


# Build with PyInstaller
pyinstaller --onefile Artemis_onedir.spec

# Display success message
echo "Artemis installation and setup completed successfully."

exit 0

