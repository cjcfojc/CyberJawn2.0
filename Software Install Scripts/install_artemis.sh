#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# Update and upgrade system packages
apt-get update
apt-get upgrade -y

# Install dependencies
apt-get install -y \
    git \
    python3 \
    python3-pip \
    libqt5widgets5 \
    libqt5gui5 \
    libqt5core5a \
    qt5-default \
    pyqt5-dev \
    pyqt5-dev-tools \
    python3-pyqt5 \
    python3-pyqt5.qtsvg \
    libssl-dev \
    openssl \
    python3-setuptools \
    python3-tk

# Clone Artemis repository from your fork
git clone https://github.com/cjcfojc/Artemis.git

# Change directory to Artemis
cd Artemis

# Install Python requirements
pip3 install --break-system-packages -r requirements/requirements.txt

# Run the provided build script for Raspbian
chmod +x spec_files/Linux/raspbian_build.sh
./spec_files/Linux/raspbian_build.sh

# Print statement on how to launch Artemis
echo "To launch Artemis, run the command: ./path-to-artemis-executable" # Replace 'path-to-artemis-executable' with the actual path if known.

