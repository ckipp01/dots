#!/bin/sh

for i in .vimrc .vimrc.plug .tmux.conf \
        .tmux.snapshot .zshrc tmux-256color-italic.terminfo \
        xterm-256color-italic.terminfo \
        .config/termite/config
do
    if [ -e ${HOME}/$i ]
    then
        [[ ! -e ${HOME}/dots/home/$i ]] &&
            (cp ${HOME}/$i ${HOME}/dots/home/$i && echo -e "\033[0;32m$i is now being tracked \033[0m") ||
            [[ `diff ${HOME}/$i ${HOME}/dots/home/$i` ]] &&
                (cp ${HOME}/$i ${HOME}/dots/home/$i && echo -e "\033[0;32m$i copied \033[0m") ||
                    (echo "$i was the same")
    else
        echo "no $i on this machine"
    fi
done

for w in dot-backup.sh
do
    if [ -e ${HOME}/bin/$w ]
    then
        [[ `diff ${HOME}/bin/$w ${HOME}/dots/scripts/$w` ]] &&
            (cp ${HOME}/bin/$w ${HOME}/dots/scripts/$w && echo -e "\033[0;32m$w copied \033[0m") ||
                (echo "$w was the same")
    else
        echo "no $w on this machine"
    fi
done

