#!/bin/sh
#
# setup for scala work

session="scala"

tmux start-server

# vertical split notes 
tmux new-session -d -s $session -n "notes"
tmux send-keys "cd ~/notes && vim todo.md" C-m
tmux split-window -v
tmux send-keys "cd ~/notes" C-m

# scala-workspace 
tmux new-window -t $session:1 -n "scala-workspace"
tmux send-keys "cd ~/Documents/scala-workspace" C-m

# scratch 
tmux new-window -t $session:2 -n "scratch"
tmux send-keys "cd ~" C-m

# select window to start 
tmux select-window -t $session:0

# attatchment 
tmux -2 attach-session -t $session
