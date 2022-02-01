#!/usr/bin/env sh

cs update && \
  brew update && \
  brew upgrade && \
  brew reinstall nvim && \
  brew cleanup
