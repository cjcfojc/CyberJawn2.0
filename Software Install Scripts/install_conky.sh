#!/bin/bash

# Install Conky and picom
sudo apt update
sudo apt install -y conky-all picom

# Fetch and replace the content of the default .conkyrc with the content from GitHub
curl -o /home/dietpi/.conkyrc https://raw.githubusercontent.com/cjcfojc/CyberJawn2.0/main/Conky/cj20conky

# Create autostart directory if it doesn't exist for conky
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

# Setup picom configuration
mkdir -p /home/dietpi/.config/picom
if [ ! -f /home/dietpi/.config/picom/picom.conf ]; then
    cp /etc/xdg/picom.conf /home/dietpi/.config/picom/picom.conf
fi

# Ensure picom starts every time you start LXDE
mkdir -p /home/dietpi/.config/lxsession/LXDE
echo "@picom -b" >> /home/dietpi/.config/lxsession/LXDE/autostart

echo "Conky and Picom installation complete. Conky will start automatically after a 20-second delay on boot, and Picom will start in the background."

