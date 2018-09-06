#!/bin/bash

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

