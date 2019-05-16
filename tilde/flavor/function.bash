run_on_startup() {
  stty -ixon
}
cd-up() {
  cd $(printf "%.s../" $(seq 1 $1));
}
copy-last-command() {
  tail -n 1 ~/.bash_history | xclip -selection c
}
cheat() {
  curl cheat.sh/"$@"
}
