#!/bin/sh
#
# setup for js work 

session="js"

tmux start-server

# horizontal split notes 
tmux new-session -d -s $session -n "notes"
tmux send-keys "cd ~/notes && vim todo.md" C-m
tmux split-window -h
tmux send-keys "cd ~/notes" C-m

# horizont split and resized js 
tmux new-window -t $session:1 -n "js-workspace"
tmux send-keys "cd ~/Documents/js-workspace" C-m
tmux split-window -h
tmux resize-pane -R 70
tmux send-keys "cd ~/Documents/js-workspace" C-m

# scratch 
tmux new-window -t $session:2 -n "scratch"
tmux send-keys "cd ~" C-m

# select window to start 
tmux select-window -t $session:0

# attatchment 
tmux -2 attach-session -t $session
