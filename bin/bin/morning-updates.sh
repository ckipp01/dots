#!/usr/bin/env sh

# Update all the things
cs update && \
  brew update && \
  brew upgrade && \
  brew reinstall nvim && \
  brew cleanup && \
  npm --location=global update
