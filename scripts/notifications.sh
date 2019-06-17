#!/usr/bin/env bash

MODE= $1
if [ "$MODE" != "on" ] && [ "$MODE" != "off" ]
then
  echo 'You must specifcy on or off'
  exit
fi

DESKTOP=$XDG_CURRENT_DESKTOP
echo $DESKTOP

case $DESKTOP in
  "i3")
    if [ "$MODE" = "on"]
    then
#notify-send DUNST_COMMAND_PAUSE     


CURRENT_VAL=$(gsettings get org.gnome.desktop.notifications show-banners)
if [ "$CURRENT_VAL" = true ]
  then
    notify-send "Notifications script"  "Notifications are now turned off."
    gsettings set org.gnome.desktop.notifications show-banners false
  else
    gsettings set org.gnome.desktop.notifications show-banners true
    notify-send "Notifications script"  "Notifications are now turned on."
fi
