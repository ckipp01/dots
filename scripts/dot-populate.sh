#!/bin/bash

#files directly in ~
for i in .vimrc .tmux.conf
do
    if [ -e ${HOME}/dots/tilde/$i ]
    then
      if [ ! -e ${HOME}/$i ]
      then
        cp ${HOME}/dots/tilde/$i ${HOME}/$i && echo "$i has been created in ${HOME}"
      elif [ ${HOME}/dot/tilde/$i -nt ${HOME}/$i ]
      then
          cp ${HOME}/dots/tilde/$i ${HOME}/$i && echo "updated $i"
      else
        echo "$i was the same"
      fi
    else
        echo "no $i found in your dots repo"
    fi
done

#flavor files
if [ ! -d ${HOME}/.flavor ]
then
  mkdir ${HOME}/.flavor
fi

for f in alias.bash function.bash tmux.snapshot vimrc.plug
do
  if [ -e ${HOME}/dots/tilde/flavor/$f ]
  then
    if [ ! -e ${HOME}/.flavor/$f ]
    then
      cp ${HOME}/dots/tilde/flavor/$f ${HOME}/.flavor/$f && echo "$f has been created in .flavor"
    elif [ ${HOME}/dots/tilde/flavor/$f -nt ${HOME}/.flavor/$f ]
    then
        cp ${HOME}/dots/tilde/flavor/$f ${HOME}/.flavor/$f && echo "$f updated"
    else
      echo "$f was the same"
    fi
  else
      echo "no $f found in your dots repo"
  fi
done

#config directory files
for c in termite/config gtk-3.0/gtk.css
do
  if [ -e ${HOME}/dots/tilde/config/$c ]
  then
    if [ -e ${HOME}/.config/$c ]
    then
      if [ ${HOME}/dots/tilde/config/$c -nt ${HOME}/.config/$c ]
      then
        cp ${HOME}/dots/tilde/config/$c ${HOME}/.config/$c && echo "$c updated"
      else
        echo "$c was the same"
      fi
    else
      echo "$c does not exist on this machine -- make sure the program is installed"
    fi
  else
      echo "no $c found in your dots repo"
  fi
done


#scripts
for s in dot-backup.sh tmux-work.sh dot-populate.sh
do
  if [ -e ${HOME}/bin/$s ]
  then
    if [ ! -e ${HOME}/dots/scripts/$s ]
    then
      cp ${HOME}/dots/scripts/$s ${HOME}/bin/$s && echo "$s has been created in /bin"
    elif [ ${HOME}/dots/scripts/$s -nt ${HOME}/bin/$s ]
    then
        cp ${HOME}/dots/scripts/$s ${HOME}/bin/$s && echo "$s updated"
    else
      echo "$s was the same"
    fi
  else
    echo "no $s found in your dots repo"
  fi
done
