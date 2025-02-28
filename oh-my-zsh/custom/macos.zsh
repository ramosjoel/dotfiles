#!/bin/zsh

# Find out which process is using a port
function port() {
  PORT=$1
  lsof -i -P | grep LISTEN | grep :$PORT
}

# 
function portpid() {
  PORT=$1
  port $PORT | awk '{print $2}'
}
