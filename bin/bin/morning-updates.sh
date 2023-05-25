#!/usr/bin/env sh

# Update all the things
echo "========== starting updates ==========" && \
  echo "========== coursier ==========" && \
  cs update && \
  echo "========== brew update ==========" && \
  brew update && \
  echo "========== brew upgrade ==========" && \
  brew upgrade && \
  echo "========== neovim ==========" && \
  brew upgrade neovim --fetch-HEAD && \
  echo "========== wezterm ==========" && \
  brew upgrade --cask wezterm-nightly --no-quarantine --greedy-latest && \
  echo "========== brew cleanup ==========" && \
  brew cleanup && \
  echo "========== npm ==========" && \
  npm --location=global update && \
  echo "========== updates completed =========="
