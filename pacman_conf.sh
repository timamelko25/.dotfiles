#! /bin/bash

PACMAN_CONF="/etc/pacman.conf"

if [ ! -f "$PACMAN_CONF" ]; then
	echo "No file $PACMAN_CONF"
	exit 1
fi

if ! grep -q "^ILoveCandy" "$PACMAN_CONF"; then
	sudo sed -i '/^\[options\]/a ILoveCandy' "$PACMAN_CONF"
    echo "Added line ILoveCandy"
else
    echo "Line ILoveCandy already exists"
fi

sudo sed -i 's/^#Color/Color/' "$PACMAN_CONF"

sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' "$PACMAN_CONF"

sudo sed -i 's/^#VerbosePkgLists/VerbosePkgLists/' "$PACMAN_CONF"

echo "pacman conf updated successfully"
