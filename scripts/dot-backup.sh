#!/bin/bash

#files directly in ~
for i in .vimrc .tmux.conf
do
    if [ -e ${HOME}/$i ]
    then
      if [ ! -e ${HOME}/dots/tilde/$i ]
      then
        cp ${HOME}/$i ${HOME}/dots/tilde/$i && echo "$i is now being tracked"
      elif [ ${HOME}/$i -nt ${HOME}/dots/tilde/$i ]
      then
          cp ${HOME}/$i ${HOME}/dots/tilde/$i && echo "$i copied"
      else
        echo "$i was the same"
      fi
    else
        echo "no $i on this machine"
    fi
done

#flavor files
for f in alias.bash function.bash tmux.snapshot vimrc.plug
do
  if [ -e ${HOME}/.flavor/$f ]
  then
    if [ ! -e ${HOME}/dots/tilde/flavor/$f ]
    then
      cp ${HOME}/.flavor/$f ${HOME}/dots/tilde/flavor/$f && echo "$f is now being tracked"
    elif [ ${HOME}/.flavor/$f -nt ${HOME}/dots/tilde/flavor/$f ]
    then
        cp ${HOME}/.flavor/$f ${HOME}/dots/tilde/flavor/$f && echo "$f copied"
    else
      echo "$f was the same"
    fi
  else
      echo "no $f on this machine"
  fi
done

#config directory files
for c in termite/config gtk-3.0/gtk.css
do
  if [ -e ${HOME}/.config/$c ]
  then
    if [ ! -e ${HOME}/dots/tilde/config/$c ]
    then
      cp ${HOME}/.config/$c ${HOME}/dots/tilde/config/$c && echo "$c is now being tracked"
    elif [ ${HOME}/.config/$c -nt ${HOME}/dots/tilde/config/$c ]
    then
        cp ${HOME}/.config/$c ${HOME}/dots/tilde/config/$c && echo "$c copied"
    else
      echo "$c was the same"
    fi
  else
      echo "no $c on this machine"
  fi
done


#scripts
for s in dot-backup.sh tmux-work.sh
do
  if [ -e ${HOME}/bin/$s ]
  then
    if [ ! -e ${HOME}/dots/scripts/$s ]
    then
      cp ${HOME}/bin/$s ${HOME}/dots/scripts/$s && echo "$s is now being tracked"
    elif [ ${HOME}/bin/$s -nt ${HOME}/dots/scripts/$s ]
    then
        cp ${HOME}/bin/$s ${HOME}/dots/scripts/$s && echo "$s copied"
    else
      echo "$s was the same"
    fi
  else
      echo "no $s on this machine"
  fi
done
