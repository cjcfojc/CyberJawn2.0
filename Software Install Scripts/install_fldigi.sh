#!/bin/bash

# Fldigi Installation Script

echo "INFO: Updating package lists..."
sudo apt update

echo "INFO: Installing Fldigi and its dependencies..."
sudo apt install -y fldigi

echo "INFO: Installation complete. You should be able to launch Fldigi now."

