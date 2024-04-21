#!/bin/zsh

# Oh My Posh
# Customized terminal prompts.

##   Docs - https://ohmyposh.dev/docs/installation/customize
## Themes - https://ohmyposh.dev/docs/themes

# Themes
## https://ohmyposh.dev/docs/themes#montys
## https://ohmyposh.dev/docs/themes#mt
## https://ohmyposh.dev/docs/themes#multiverse-neon
OMP_THEME="montys"

# Avoid ugliness on Apple Terminal if using for some reason.
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  # eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/${OMP_THEME}.omp.json)"
  eval "$(oh-my-posh init zsh --config /Users/${USER}/.dotfiles/omp/joel.omp.json)"
fi
