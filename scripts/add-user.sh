#!/usr/bin/env sh

if [ -f "$PWD/.git/config" ]; then
  echo "[user]\n\tname = ckipp01\n\temail = ckipp@pm.me" >> "$PWD/.git/config"
else
  echo "No .git/config exists here"
fi
