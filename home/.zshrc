# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Vim-style command-line editing
bindkey -v

# Faster Esc response when switching to command mode
export KEYTIMEOUT=10

# User configuration
export PATH="$PATH:$(go env GOPATH)/bin"

# Aliases
alias ip="ipconfig getifaddr en0"
alias cls="clear"
alias k="kubectl"
alias tf='terraform'
alias claude-personal="CLAUDE_CONFIG_DIR=~/.claude-personal claude"
alias claude-chayon="CLAUDE_CONFIG_DIR=~/.claude-chayon claude"
alias claude-work="CLAUDE_CONFIG_DIR=~/.claude-work claude"
