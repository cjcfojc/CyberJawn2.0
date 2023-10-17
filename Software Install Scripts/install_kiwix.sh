#!/bin/bash

# Update package repositories
echo "Updating package repositories..."
sudo apt update

# Install dependencies
echo "Installing dependencies..."
sudo apt install -y git cmake build-essential qtbase5-dev qttools5-dev-tools qtwebengine5-dev libqt5webenginecore5 libqt5webenginewidgets5 libqt5webchannel5-dev qtdeclarative5-dev libqt5gui5 libqt5widgets5 libqt5network5 libqt5qml5 libqt5core5a zlib1g-dev liblzma-dev libicu-dev libxapian-dev libzim-dev

# Clone the kiwix-desktop repository
echo "Cloning kiwix-desktop repository..."
if [ ! -d "kiwix-desktop" ]; then
    git clone --recursive https://github.com/kiwix/kiwix-desktop.git
else
    echo "kiwix-desktop directory already exists. Skipping cloning..."
fi

# Enter the kiwix-desktop directory and fetch any required submodules
cd kiwix-desktop
echo "Fetching submodules..."
git submodule update --init --recursive

# Build kiwix-desktop using qmake
echo "Building kiwix-desktop..."
qmake
make

# Install kiwix-desktop
echo "Installing kiwix-desktop..."
sudo make install

echo "Installation completed!"


