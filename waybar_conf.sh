#!/bin/bash

# Установка пакетов
echo "[1/5] Downloading Waybar and Wofi..."
sudo pacman -S --noconfirm waybar wofi

# Создание директорий конфигов
echo "[2/5] Creating config files..."
mkdir -p ~/.config/waybar
mkdir -p ~/.config/wofi

# Копирование конфигов Waybar
if [ -d "waybar" ]; then
    echo "[3/5] Coping config files Waybar..."
    cp -r waybar/* ~/.config/waybar/
else
    echo "Warning: folder 'waybar' not found, config error"
fi

if [ -d "wofi" ]; then
	echo "[4/5] Coping config files Wofi..."
	cp -r wofi/* ~/.config/wofi/
else
	echo "Waring: folder 'wofi' not found, config error"
fi

echo "Finished"
