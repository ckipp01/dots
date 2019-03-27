#!/bin/bash

CURRENT_VAL=$(gsettings get org.gnome.desktop.notifications show-banners)
if [ "$CURRENT_VAL" = true ]
  then
    notify-send "Notifications script"  "Notifications are now turned off."
    gsettings set org.gnome.desktop.notifications show-banners false
  else
    gsettings set org.gnome.desktop.notifications show-banners true
    notify-send "Notifications script"  "Notifications are now turned on."
fi
