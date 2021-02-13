# set the workspace path
set -x GOPATH /media/foyez/CAD86EE7D86ED0ED/MyBackup/junior-senior-webdev/golang

# add the go bin path to be able to execute our programs
set -x PATH $PATH /usr/local/go/bin $GOPATH/bin

# Add npm path
set PATH /home/foyez/.npm-packages/bin $PATH