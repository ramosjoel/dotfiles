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

# Converts a timestamp to datetime
# E.g., 1784665171642 -> 2026-07-21T20:19:31.642Z
function ts_to_dt() {
  FORMAT='+%Y-%m-%dT%H:%M:%S'
  TS="$1"

  millis=$((TS % 1000))
  seconds=$((TS / 1000))

  if [ "$(uname)" = "Darwin" ]; then
    # MacOS uses -r
    printf '%s.%03dZ\n' "$(date -u -r $seconds $FORMAT)" "$millis"
  else
    # Linux uses -d
    printf '%s.%03dZ\n' "$(date -u -d $seconds $FORMAT)" "$millis"
  fi
}

# Converts a datetime to a timestamp
# Example: dt="2026-07-22T20:58:53.372Z"
function dt_to_ts() {

  DT="$1"

  # Split off milliseconds
  secs_str="${DT%.*}"   # 2026-07-22T20:58:53
  ms_str="${DT##*.}"    # 372Z
  ms="${ms_str%Z}"      # 372

  if [ "$(uname)" = "Darwin" ]; then
    # MacOS uses '-j -f format'
    secs=$(date -u -j -f '%Y-%m-%dT%H:%M:%S' "$secs_str" '+%s')
  else
    # Linux uses -d, without '-f format'
    secs=$(date -u -d "${secs_str}Z" '+%s')
  fi

  echo $((secs * 1000 + ms))
}
