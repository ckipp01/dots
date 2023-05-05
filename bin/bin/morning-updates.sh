#!/usr/bin/env sh

# Update all the things
cs update && \
  brew update && \
  brew upgrade && \
  brew upgrade neovim --fetch-HEAD && \
  brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest && \
  brew cleanup && \
  npm --location=global update && \
  echo "finished!"
