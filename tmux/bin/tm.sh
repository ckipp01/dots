#!/bin/sh

###########################################################
# General startup of tmux with my most common setup
###########################################################

session="main"

tmux start-server

tmux new-session -d -s $session -n "dots"
tmux send-keys "cd ~/dots/nvim/.config/nvim" C-m

tmux new-window -t $session:1 -n "notes"
tmux send-keys "cd ~/Documents/notes" C-m

tmux new-window -t $session:2
tmux send-keys "cd ~/Documents/scratch-workspace" C-m

# select window to start 
tmux select-window -t $session:1

# attatchment 
tmux -2 attach-session -t $session
