#!/bin/bash

echo "[1/3] Installing kitty"
sudo pacman -S --noconfirm kitty

echo "[2/3] Creating config file"
mkdir -p ~/.config/kitty

if [ -d "kitty" ]; then
	echo "[3/3] Coping config file"
	cp -r kitty/* ~/.config/kitty/
else
	echo "Warning: folder 'kitty' not found, config error"
fi

echo "Finished"
