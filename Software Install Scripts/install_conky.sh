#!/bin/bash

# Install required dependencies for Conky
sudo apt-get update
sudo apt-get install -y conky conky-all curl

# Install Conky Manager 2 from TeeJee's PPA
sudo add-apt-repository -y ppa:teejee2008/ppa
sudo apt-get update
sudo apt-get install -y conky-manager

# Create Conky directory and download the Conky configuration file
mkdir -p /home/dietpi/Documents/Conky
curl -o /home/dietpi/Documents/Conky/cj20conky https://raw.githubusercontent.com/cjcfojc/CyberJawn2.0/main/Conky/cj20conky

# Adjust permissions
chmod +x /home/dietpi/Documents/Conky/cj20conky

# Create .desktop file for autostart
mkdir -p ~/.config/autostart/
echo "[Desktop Entry]
Type=Application
Name=Conky
Exec=sh -c 'sleep 20s; conky -c /home/dietpi/Documents/Conky/cj20conky'
Comment=Start Conky after a delay
NoDisplay=true" > ~/.config/autostart/conky.desktop

# Ensure permissions are set correctly
chmod +x ~/.config/autostart/conky.desktop

echo "Conky and Conky Manager 2 installation complete. Conky will start automatically after a 20-second delay on boot."

