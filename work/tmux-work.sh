#!/bin/sh
#
# Setup for my work environment
# This will start five tmux windows
# and will start the ssh process into my local5, test7, and test5

session="work"

#Grap the snapshot on load
tmux start-server

# create a new tmux session and also name the first window local7
tmux new-session -d -s $session -n "local7"

# create a new window called test7
tmux new-window -t $session:1 -n "test7"
tmux send-keys "ssh test7" C-m

# create a new window called local5
tmux new-window -t $session:2 -n "local5"
tmux send-keys "ssh local5" C-m

# create a new window called test5
tmux new-window -t $session:3 -n "test5"
tmux send-keys "ssh test5" C-m

# create a new window called notes and jumps to my notes directory
tmux new-window -t $session:4 -n "notes"
tmux send-keys "cd ~/notes" C-m

# jump back to test7 window to put in your pw
tmux select-window -t $session:1

# setup is finished, attatch the session
tmux -2 attach-session -t $session
