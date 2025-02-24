#!/bin/zsh

# Points the macOS network interfaces to the locally-running proxy.
function enable_macos_proxy() {
  interfaces="$(networksetup -listallnetworkservices | tail +2)" 

  IFS=$'\n' # split on newlines in the for loops

  for interface in $interfaces; do
    echo "Setting proxy on $interface"
    networksetup -setwebproxy "$interface" 127.0.0.1 8080
    networksetup -setwebproxystate "$interface" on
    networksetup -setsecurewebproxy "$interface" 127.0.0.1 8080
    networksetup -setsecurewebproxystate "$interface" on
  done
}

# Resets the network interfaces to disable proxying.
function disable_macos_proxy() {
  interfaces="$(networksetup -listallnetworkservices | tail +2)" 

  IFS=$'\n' # split on newlines in the for loops
  for interface in $interfaces; do
    echo "Disabling proxy on $interface"
    networksetup -setwebproxystate "$interface" off
    networksetup -setsecurewebproxystate "$interface" off
  done
}

