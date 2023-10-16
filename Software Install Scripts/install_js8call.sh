#!/bin/bash

# JS8Call Installation Script

echo "INFO: Updating package lists..."
sudo apt update

echo "INFO: Adding architecture support for armhf..."
sudo dpkg --add-architecture armhf
sudo apt update

echo "INFO: Installing JS8Call..."
sudo apt install -y js8call

echo "INFO: Installation complete. You should be able to launch JS8Call now."

