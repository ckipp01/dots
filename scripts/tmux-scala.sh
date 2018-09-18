#!/bin/sh
#
# Setup for my work environment

session="scala"

#Grap the snapshot on load
tmux start-server

# create a new tmux window called notes and split it vertically
tmux new-session -d -s $session -n "notes"
tmux send-keys "cd ~/notes && vim todo.md" C-m
tmux split-window -v
tmux send-keys "cd ~/notes" C-m

# create a new tmux window called husky and split it vertically
tmux new-window -t $session:1 -n "scala-workspace"
tmux send-keys "cd ~/Documents/scala-workspace" C-m

# create a new tmux window called husky and split it vertically
tmux new-window -t $session:2 -n "scratch"
tmux send-keys "cd ~" C-m

# jump back to notes window to start
tmux select-window -t $session:0

# setup is finished, attatch the session
tmux -2 attach-session -t $session
