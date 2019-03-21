#!/bin/bash

CURRENT_VAL=$(gsettings get org.gnome.desktop.notifications show-banners)
if [ "$CURRENT_VAL" = true ]
  then
    NEW_VAL=false
  else
    NEW_VAL=true
fi

gsettings set org.gnome.desktop.notifications show-banners $NEW_VAL
