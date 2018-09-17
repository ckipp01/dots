run_on_startup() {
  stty -ixon
}
cd_up() {
  cd $(printf "%.s../" $(seq 1 $1));
}
