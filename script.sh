#!/bin/bash

# Run as root
if [ "$EUID" -ne 0 ]; then 
  echo "Please run as root (use sudo)"
fi 

echo "Updating the system..."
apt update && apt upgrade -y

if ! command -v ufw &> /dev/null; then 
  echo "Installing UFW..."
  apt install ufw -y
else
  echo "UFW is already installed."
fi

eco "Enabling UFW..."
ufw enable

echo "Allowing SSH..."
ufw allow ssh 

echo "Allowing HTTP..."
ufw allow http 

echo "Allowing HTTPS..."
ufw allow https 

echo "Checking UFW status..."
ufw status verbose


