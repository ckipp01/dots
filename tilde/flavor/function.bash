cd_up() {
  cd $(printf "%.s../" $(seq 1 $1));
}
