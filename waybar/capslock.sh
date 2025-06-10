#!/bin/bash

if xset q | grep -q "Caps Lock:   on"; then
    echo "{\"text\": \"!\", \"tooltip\": \"Caps Lock ON\"}"
else
    echo "{\"text\": \"\", \"tooltip\": \"Caps Lock OFF\"}"
fi
