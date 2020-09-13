set -l cs_commands " \
  bootstrap \
  complete \
  fetch \
  install \
  java \
  java-home \
  launch \
  list \
  publish \
  resolve \
  setup \
  uninstall \
  update"

complete -c cs -f
complete -c cs -n "not __fish_seen_subcommand_from $cs_commands" -a $cs_commands
