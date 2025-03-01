# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# go paths
# set the workspace path
export GOPATH=$HOME/Documents/projects/go
# add the go bin path to be able to execute our programs
export PATH=$PATH:$GOPATH/bin

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# get machine's ip address
alias ip="ipconfig getifaddr en0"
alias cls="clear"
alias k="kubectl"
alias valgrind='docker run -it --rm -v $PWD:/valgrind -w /valgrind --name valgrind valgrind:1.0'

# git aliases
alias gits="git status"
alias gitd="git diff"
# alias gitl="git log --pretty=oneline --abbrev-commit"
alias gitl="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gita="git add ."
alias gitc="cz commit"

# load zsh-completions
autoload -U compinit && compinit

# use nvm
source /opt/homebrew/opt/nvm/nvm.sh

# use starship theme (needs to be at the end)
eval "$(starship init zsh)"