#!/usr/bin/env sh

if [ -f "$PWD/.git/config" ]; then
  if [ "$1" == "work" ]; then
    echo "[user]\n\tname = Chris Kipp\n\temail = chris.kipp@lunatech.nl" >> "$PWD/.git/config"
  else
    echo "[user]\n\tname = ckipp01\n\temail = ckipp@pm.me" >> "$PWD/.git/config"
  fi
else
  echo "No .git/config exists here"
fi
