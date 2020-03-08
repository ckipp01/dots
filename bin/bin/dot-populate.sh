#!/usr/bin/env bash

echo "Is this a desktop or server?"
read setupType

[ ! -f ${HOME}/.vim/autoload/plug.vim ] && \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#files directly in ~
echo -e "${UNDERLINE}~ files${END}"
for i in .vimrc .tmux.conf
do
    if [ -e ${HOME}/dots/tilde/${i} ]
    then
      if [ ! -e ${HOME}/${i} ]
      then
        cp ${HOME}/dots/tilde/${i} ${HOME}/${i} && echo "${i} has been created in ${HOME}"
      elif [ ${HOME}/dot/tilde/${i} -nt ${HOME}/${i} ]
      then
          cp ${HOME}/dots/tilde/${i} ${HOME}/${i} && echo -e "${GREEN}updated ${i}${END}"
      else
        echo -e "${BLUE}${i} was the same${END}"
      fi
    else
        echo -e "${RED}no ${i} found in your dots repo${END}"
    fi
done

#flavor files
echo -e "${UNDERLINE}flavor files${END}"
if [ ! -d ${HOME}/.flavor ]
then
  mkdir ${HOME}/.flavor && echo -e "${GREEN}created .flavor directory${END}"
fi

for f in alias.bash function.bash vimrc.plug
do
  if [ -e ${HOME}/dots/tilde/flavor/${f} ]
  then
    if [ ! -e ${HOME}/.flavor/${f} ]
    then
      cp ${HOME}/dots/tilde/flavor/${f} ${HOME}/.flavor/${f} && echo -e "${GREEN}${f} has been created in .flavor${END}"
    elif [ ${HOME}/dots/tilde/flavor/${f} -nt ${HOME}/.flavor/${f} ]
    then
        cp ${HOME}/dots/tilde/flavor/${f} ${HOME}/.flavor/${f} && echo -e "${GREEN}${f} updated${END}"
    else
      echo -e "${BLUE}${f} was the same${END}"
    fi
  else
      echo -e "${RED}no ${f} found in your dots repo${END}"
  fi
done

#config directory files
echo -e "${UNDERLINE}config files${END}"
for c in termite/config gtk-3.0/gtk.css
do
  if [ -e ${HOME}/dots/tilde/config/${c} ]
  then
    if [ -e ${HOME}/.config/${c} ]
    then
      if [ ${HOME}/dots/tilde/config/${c} -nt ${HOME}/.config/${c} ]
      then
        cp ${HOME}/dots/tilde/config/${c} ${HOME}/.config/${c} && echo -e "${GREEN}${c} updated${END}"
      else
        echo -e "${BLUE}${c} was the same${END}"
      fi
    else
      echo -e "${RED}${c} does not exist on this machine -- make sure the program is installed${END}"
    fi
  else
      echo -e "${RED}no ${c} found in your dots repo${END}"
  fi
done


#scripts
echo -e "${UNDERLINE}bin scripts${END}"
for s in dot-backup.sh tmux-work.sh dot-populate.sh
do
  if [ -e ${HOME}/bin/${s} ]
  then
    if [ ! -e ${HOME}/dots/scripts/${s} ]
    then
      cp ${HOME}/dots/scripts/${s} ${HOME}/bin/${s} && echo -e "${GREEN}${s} has been created in /bin${END}"
    elif [ ${HOME}/dots/scripts/${s} -nt ${HOME}/bin/${s} ]
    then
        cp ${HOME}/dots/scripts/${s} ${HOME}/bin/${s} && echo -e "${GREEN}${s} updated${END}"
    else
      echo -e "${BLUE}${s} was the same${END}"
    fi
  else
    echo -e "${RED}no ${s} found in your dots repo${END}"
  fi
done
