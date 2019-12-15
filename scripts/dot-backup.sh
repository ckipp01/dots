#!/bin/sh

#include colors
. ${HOME}/bin/colors.sh

#files directly in ~
echo "${UNDERLINE}~ files${END}"
for i in .vimrc .tmux.conf .bashrc .Xresources
do
    if [ -e ${HOME}/${i} ]
    then
      if [ ! -e ${HOME}/dots/tilde/${i} ]
      then
        cp ${HOME}/${i} ${HOME}/dots/tilde/${i} &&
          echo "${GREEN}${i} is now being tracked${END}"
      elif [ ${HOME}/${i} -nt ${HOME}/dots/tilde/${i} ]
      then
          cp ${HOME}/${i} ${HOME}/dots/tilde/${i} &&
        echo "${GREEN}${i} copied${END}"
      else
        echo "${BLUE}${i} was the same${END}"
      fi
    else
        echo "${RED}no ${i} on this machine${END}"
    fi
done

#flavor files
echo "${UNDERLINE}flavor files${END}"
for f in aliases function.bash \
  plugs plug.settings vim-themes \
  coc.settings lsc.settings \
  vim.functions xterm-256color-italic
do
  if [ -e ${HOME}/.flavor/${f} ]
  then
    if [ ! -e ${HOME}/dots/tilde/flavor/${f} ]
    then
      cp ${HOME}/.flavor/${f} ${HOME}/dots/tilde/flavor/${f} &&
        echo "${GREEN}${f} is now being tracked${END}"
    elif [ ${HOME}/.flavor/${f} -nt ${HOME}/dots/tilde/flavor/${f} ]
    then
        cp ${HOME}/.flavor/${f} ${HOME}/dots/tilde/flavor/${f} &&
          echo "${GREEN}${f} copied${END}"
    else
      echo "${BLUE}${f} was the same${END}"
    fi
  else
      echo "${RED}no ${f} on this machine${END}"
  fi
done

#config directory files
echo "${UNDERLINE}config files${END}"
for c in ranger/rc.conf nvim/coc-settings.json nvim/init.vim \
  i3/config polybar/config polybar/launch.sh fish/config.fish \
  fish/functions.fish
do
  if [ -e ${HOME}/.config/${c} ]
  then
    if [ ! -e ${HOME}/dots/tilde/config/${c} ]
    then
      cp ${HOME}/.config/${c} ${HOME}/dots/tilde/config/${c} &&
        echo "${GREEN}${c} is now being tracked${END}"
    elif [ ${HOME}/.config/${c} -nt ${HOME}/dots/tilde/config/${c} ]
    then
        cp ${HOME}/.config/${c} ${HOME}/dots/tilde/config/${c} &&
          echo "${GREEN}${c} copied${END}"
    else
      echo "${BLUE}${c} was the same${END}"
    fi
  else
      echo "${RED}no ${c} on this machine${END}"
  fi
done

#scripts
echo "${UNDERLINE}bin scripts${END}"
for s in dot-backup.sh tmux-scala.sh tmux-js.sh dot-populate.sh \
  colors.sh get-waka-summary.sh notifications.sh
do
  if [ -e ${HOME}/bin/${s} ]
  then
    if [ ! -e ${HOME}/dots/scripts/${s} ]
    then
      cp ${HOME}/bin/${s} ${HOME}/dots/scripts/${s} &&
        echo "${GREEN}${s} is now being tracked${END}"
    elif [ ${HOME}/bin/${s} -nt ${HOME}/dots/scripts/${s} ]
    then
        cp ${HOME}/bin/${s} ${HOME}/dots/scripts/${s} &&
          echo "${GREEN}${s} copied${END}"
    else
      echo "${BLUE}${s} was the same${END}"
    fi
  else
    echo "${RED}no ${s} on this machine${END}"
  fi
done
