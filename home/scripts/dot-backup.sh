#!/bin/sh

for i in .vimrc .vimrc.plug .tmux.conf .tmux.snapshot .zshrc tmux-256color-italic.terminfo xterm-256color-italic.terminfo
do
    if [ ! -e $i ]
    then
        [[ `diff ${HOME}/$i ${HOME}/dots/home/$i` ]] &&
            (cp ${HOME}/$i ${HOME}/dots/home/$i && echo "$i copied") ||
                (echo "$i was the same")
    else
        echo "no $i on this machine"
    fi
done

for i in dot-backup.sh
do
    if [ ! -e $i ]
    then
        [[ `diff ${HOME}/bin/$i ${HOME}/dots/home/scripts/$i` ]] &&
            (cp ${HOME}/bin/$i ${HOME}/dots/home/scripts/$i && echo "$i copied") ||
                (echo "$i was the same")
    else
        echo "no $i on this machine"
    fi
done
