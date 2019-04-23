#!/bin/bash

#include colors
. ${HOME}/bin/colors.sh

#files directly in ~
echo -e "${UNDERLINE}~ files${END}"
for i in .vimrc .tmux.conf .bashrc
do
    if [ -e ${HOME}/${i} ]
    then
      if [ ! -e ${HOME}/dots/tilde/${i} ]
      then
        cp ${HOME}/${i} ${HOME}/dots/tilde/${i} &&
          echo -e "${GREEN}${i} is now being tracked${END}"
      elif [ ${HOME}/${i} -nt ${HOME}/dots/tilde/${i} ]
      then
          cp ${HOME}/${i} ${HOME}/dots/tilde/${i} &&
        echo -e "${GREEN}${i} copied${END}"
      else
        echo -e "${BLUE}${i} was the same${END}"
      fi
    else
        echo -e "${RED}no ${i} on this machine${END}"
    fi
done

#flavor files
echo -e "${UNDERLINE}flavor files${END}"
for f in alias.bash function.bash \
  plugs plug.settings vim-themes \
  coc.settings lsc.settings \
  vim.functions
do
  if [ -e ${HOME}/.flavor/${f} ]
  then
    if [ ! -e ${HOME}/dots/tilde/flavor/${f} ]
    then
      cp ${HOME}/.flavor/${f} ${HOME}/dots/tilde/flavor/${f} &&
        echo -e "${GREEN}${f} is now being tracked${END}"
    elif [ ${HOME}/.flavor/${f} -nt ${HOME}/dots/tilde/flavor/${f} ]
    then
        cp ${HOME}/.flavor/${f} ${HOME}/dots/tilde/flavor/${f} &&
          echo -e "${GREEN}${f} copied${END}"
    else
      echo -e "${BLUE}${f} was the same${END}"
    fi
  else
      echo -e "${RED}no ${f} on this machine${END}"
  fi
done

#config directory files
echo -e "${UNDERLINE}config files${END}"
for c in termite/config gtk-3.0/gtk.css ranger/rc.conf \
  nvim/coc-settings.json
do
  if [ -e ${HOME}/.config/${c} ]
  then
    if [ ! -e ${HOME}/dots/tilde/config/${c} ]
    then
      cp ${HOME}/.config/${c} ${HOME}/dots/tilde/config/${c} &&
        echo -e "${GREEN}${c} is now being tracked${END}"
    elif [ ${HOME}/.config/${c} -nt ${HOME}/dots/tilde/config/${c} ]
    then
        cp ${HOME}/.config/${c} ${HOME}/dots/tilde/config/${c} &&
          echo -e "${GREEN}${c} copied${END}"
    else
      echo -e "${BLUE}${c} was the same${END}"
    fi
  else
      echo -e "${RED}no ${c} on this machine${END}"
  fi
done

#scripts
echo -e "${UNDERLINE}bin scripts${END}"
for s in dot-backup.sh tmux-scala.sh tmux-js.sh dot-populate.sh colors.sh get-waka-summary.sh notifications.sh
do
  if [ -e ${HOME}/bin/${s} ]
  then
    if [ ! -e ${HOME}/dots/scripts/${s} ]
    then
      cp ${HOME}/bin/${s} ${HOME}/dots/scripts/${s} &&
        echo -e "${GREEN}${s} is now being tracked${END}"
    elif [ ${HOME}/bin/${s} -nt ${HOME}/dots/scripts/${s} ]
    then
        cp ${HOME}/bin/${s} ${HOME}/dots/scripts/${s} &&
          echo -e "${GREEN}${s} copied${END}"
    else
      echo -e "${BLUE}${s} was the same${END}"
    fi
  else
    echo -e "${RED}no ${s} on this machine${END}"
  fi
done
