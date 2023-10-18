#!/bin/bash

# Install Conky
sudo apt update
sudo apt install -y conky-all

# Fetch and replace the content of the default .conkyrc with the content from GitHub
curl -o /home/dietpi/.conkyrc https://raw.githubusercontent.com/cjcfojc/CyberJawn2.0/main/Conky/cj20conky

# Create autostart directory if it doesn't exist
mkdir -p /home/dietpi/.config/autostart

# Create Conky desktop entry for autostart
cat > /home/dietpi/.config/autostart/conky.desktop <<EOL
[Desktop Entry]
Type=Application
Exec=sh -c 'sleep 20; conky'
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name[en_US]=Conky
Name=Conky
Comment[en_US]=
Comment=
EOL

echo "Conky installation complete. Conky will start automatically after a 20-second delay on boot."

