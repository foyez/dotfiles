if status is-interactive
    # Commands to run in interactive sessions can go here
    # override fish welcome message
    set fish_greeting

    # golang paths
    set -x GOPATH $HOME/Documents/projects/go
    # add the go bin path to be able to execute our programs
    set -x PATH $PATH /usr/local/go/bin $GOPATH/bin
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/foyez/opt/anaconda3/bin/conda "shell.fish" "hook" $argv |           source
# <<< conda initialize <<<


# Bun
set -Ux BUN_INSTALL "/Users/foyez/.bun"
set -px --path PATH "/Users/foyez/.bun/bin"