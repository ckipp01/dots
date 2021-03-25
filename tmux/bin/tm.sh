#!/bin/sh


###########################################################
# General startup of tmux with my most common setup
###########################################################

session="main"

tmux start-server

tmux new-session -d -s $session -n "config"
tmux send-keys "cd ~/.config/nvim" C-m

tmux new-window -t $session:1 -n "notes"
tmux send-keys "cd ~/Documents/notes && v todo.md" C-m

tmux new-window -t $session:2 -n "scratch"
tmux send-keys "cd ~/Documents/scratch-workspace" C-m

# select window to start 
tmux select-window -t $session:1

# attatchment 
tmux -2 attach-session -t $session
