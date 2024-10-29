#!/bin/bash
echo "Created by Jaxon Brown, Loudoun County High School, Leesburg, VA, USA"

echo " "
echo " "
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

echo "Enabling UFW..."
ufw enable

echo "Allowing SSH..."
ufw allow ssh 

echo "Allowing HTTP..."
ufw allow http 

echo "Allowing HTTPS..."
ufw allow https 

echo "Checking UFW status..."
ufw status verbose

FILEA="/etc/login.defs"

if [ ! -f "$FILEA" ]; then
  echo "File $FILEA not found."
fi 

KEYA="PASS_MIN_DAYS 0"
NEW_LINEA="PASS_MIN_DAYS 7"
KEYB="PASS_MAX_DAYS"
NEW_LINEB="PASS_MAX_DAYS 90"
KEYC="PASS_WARN_AGE"
NEW_LINEC="PASS_WARN_AGE 14"

if grep -q "^$KEYA" "#FILEA"; then
  echo "Updating existing parameter..."
  sed -i "s|^KEYA.*|$NEW_LINEA|" "$FILEA"
fi 

if grep -q "^$KEYB" "#FILEA"; then
  echo "Updating existing parameter..."
  sed -i "s|^KEYB.*|$NEW_LINEB|" "$FILEA"
fi 

if grep -q "^$KEYC" "#FILEA"; then
  echo "Updating existing parameter..."
  sed -i "s|^KEYC.*|$NEW_LINEC|" "$FILEA"
fi 
