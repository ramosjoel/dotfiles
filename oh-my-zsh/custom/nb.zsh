#!/bin/zsh

# Environment / helpers for nb terminal notebook
# https://xwmx.github.io/nb/#overview

export NB_DIR="/Users/${USER}/.nb"

# List open tasks
function ot() {
  nb tasks/ todos open
}
