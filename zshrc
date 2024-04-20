# Joel
#
# Set readline editing to vi
set -o vi

MAC_ARCH=$(uname -m)
if [[ ${MAC_ARCH} = "x86_64" ]]
then
  export EDITOR=/usr/local/bin/nvim
  export VISUAL=/usr/local/bin/nvim
else
  export EDITOR=/opt/homebrew/bin/nvim
  export VISUAL=/opt/homebrew/bin/nvim
fi


# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/${USER}/.oh-my-zsh"

# zsh syntax highlighting
if [[ ${MAC_ARCH} = "x86_64" ]]
then
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  source /opt/homebrew/opt/zsh-syntax-highlighting/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# autostart tmux
ZSH_TMUX_AUTOSTART=true

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ***** DO CUSTOMIZATIONS AFTER ZSH SETUP ***** #

script_arr=()
script_arr+=("/Users/${USER}/dev/env/github.sh")
script_arr+=("/Users/${USER}/bin/excel")
script_arr+=("/Users/${USER}/bin/bazel.sh")
for s in $script_arr; do
  if [[ -f "${s}" ]]; then
    # echo " [zshrc][DEBUG] Sourcing ${s}..."
    source $s
  fi
done

# Cheat.sh
export PATH=$PATH:"/Users/${USER}/bin"

# Android
export ANDROID_HOME="/Users/${USER}/Library/Android/sdk"
export ANDROID_JDK="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
export PATH=$PATH:"${ANDROID_HOME}/emulator"
export PATH=$PATH:"${ANDROID_HOME}/platform-tools"

# Chromedriver
export PATH=$PATH:"/Users/${USER}/dev/webdrivers/chrome90"

# Java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home"
export PATH=$PATH:"${JAVA_HOME}/bin"

# powerline status bar
# powerline_root=$(pip3 show powerline-status | grep Location | awk '{print $2}')
# . ${powerline_root}/powerline/bindings/zsh/powerline.zsh

# Fork for behave-parallel on Catalina
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
