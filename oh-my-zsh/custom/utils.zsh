#!/bin/bash

# ----- Files and Folders ----- #
function extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz) tar xzf "$1" ;;
      *.bz2) bunzip2 "$1" ;;
      *.rar) unrar x "$1" ;;
      *.gz) gunzip "$1" ;;
      *.tar) tar xf "$1" ;;
      *.tbz2) tar xjf "$1" ;;
      *.tgz) tar xzf "$1" ;;
      *.zip) unzip "$1" ;;
      *.7z) 7z x "$1" ;;
      *) echo "unknown archive" ;;
    esac
  fi
}

function dirsize() {
  du -sh "$1"
}

function fd() {
  find . -type d -iname "*$1*"
}

function ff() {
  find . -type f -iname "*$1*"
}

# ----- Networking ----- #
function myip() {
  curl -s ifconfig.me
}

function serve() {
  python3 -m http.server "${1:-8000}"
}

