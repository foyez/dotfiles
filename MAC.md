# Mac Setup

- [robinwieruch mac setup](https://www.robinwieruch.de/mac-setup-web-development/)
- **Enable tap to click and increase tracking speed**: `Settings > Trackpad`
- **Adjust Display for more space**: `Settings > Display`
- **Enable three finger drag**: navigate `Settings > Accessibility > Pointer Control > Trackpad Options`, enable `Enable dragging` and select `Three Finger Drag`
- **Launchpad on Cmd + Shift + Space**: `Settings > Keyboard Shortcut > Launchpad & Dock`
- **Disable showing recent apps in Dock**: navigate `Settings > Desktop & Dock` and uncheck `Show suggested and recent apps in Dock`
- **Setup ssh key**:

```sh
# Generate public/private rsa key pair
ssh-keygen -t rsa -b 4096 -C "username@email.com"
# ssh-keygen -t ed25519 -C "github"
# follow instructions
# use file name: github
# use passphrase and store it somewhere secure


# Copy public key
pbcopy < ~/.ssh/id_rsa.pub
```

- **Git configuration**:

```sh
git config --global user.name "username"
git config --global user.email "username@email.com"

# set the default branch to main instead of master
git config --global init.defaultBranch main

# improved git log
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git lg

# print global git configuration:
git config --list
```

- **Install VS Code**: https://code.visualstudio.com/docs/setup/mac
- **Install Homebrew**:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# to add Homebrew to your PATH
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# update everything in Homebrew
brew update

# install GUI applications
# Google Chrome (web development, web browsing)
# Brave (web browsing, wallet)
# Tor (secret web browsing)
# Visual Studio Code (web development IDE)
# Docker (containerization)
# Slack (team messenger)
# VLC (video player)
# Figma (design)
# ImageOptim (performance)
# ProtonVPN (VPN)
brew install --cask \
  google-chrome  \
  brave-browser \
  tor \
  visual-studio-code \
  docker \
  slack \
  vlc \
  figma \
  imageoptim \
  protonvpn

# install terminal applications
# git (version control)
# nvm (node version manager)
# pnpm (node package manager)
brew install \
  git \
  nvm \
  yarn \
  pnpm
```

- **Install zsh with oh-my-zsh**:

```sh
# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Update everything (e.g. plugins)
omz update

# Install Starship as your new terminal theme
# https://starship.rs/
brew install starship
# Make it the default theme for Oh My ZSH
echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# Install plugins
# 1. completions
git clone https://github.com/zsh-users/zsh-completions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
# 2. auto suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# 3. Syntax highlight
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# update configurations
sudo vi ~/.zshrc
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)
# reload terminal
source ~/.zshrc
```

- **Install NVM for Node/npm - to install and manage multiple Node versions**:

```sh
# install nvm
brew install nvm
echo "source $(brew --prefix nvm)/nvm.sh" >> ~/.zshrc
source ~/.zshrc

# install the latest LTS version
nvm install --lts

# check node and npm versions
node -v && npm -v

# update npm to its latest version
npm install -g npm@latest

# set defaults for npm:
npm set init-author-name="your name"
npm set init-author-email="name@example.com"
npm set init-author-url="example.com"

# log in to npm
npm adduser

#  list all your Node.js installation
nvm list

# install a newer node.js version
nvm install <version> --reinstall-packages-from=$(nvm current)
nvm use <version>
nvm alias default <version>

#  list all globally installed packages
npm list -g --depth=0
```

- **Install Go**:

```sh
# Install go: https://go.dev/dl/
brew install go

# Set go path
# set the workspace path
export GOPATH=$HOME/go-workspace # change your path correctly!
# add the go bin path to be able to execute our programs
export PATH=$PATH:$GOPATH/bin

# Create workspace
mkdir go-workspace
```
