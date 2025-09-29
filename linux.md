# Linux Setup

- **Setup ssh key**:

```sh
# Generate public/private rsa key pair
ssh-keygen -t rsa -b 4096 -C "username@email.com"
# ssh-keygen -t ed25519 -C "github"
# follow instructions
# use file name: github
# use passphrase and store it somewhere secure


# Copy public key
cat ~/.ssh/id_rsa.pub
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

- **Install zsh with oh-my-zsh**:

```sh
# Install oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Update everything (e.g. plugins)
omz update

# Install Starship as your new terminal theme
# https://starship.rs/
curl -sS https://starship.rs/install.sh | sh
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

- **Install AppImage ("universal" Linux package) as a non-root user**

```bash
## 🛠 Step 1 — Download WezTerm AppImage
mkdir -p ~/apps
cd ~/apps
wget https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage -O wezterm
chmod +x wezterm

## 🛠 Step 2 — Add it to your PATH
mkdir -p ~/bin
# Then symlink WezTerm:
ln -s ~/apps/wezterm ~/bin/wezterm
# Add this line to your `~/.bashrc` or `~/.zshrc`:
export PATH="$HOME/bin:$PATH"
# Reload shell
source ~/.bashrc # source ~/.zshrc
# Now you can run from terminal:
wezterm

## 🛠 Step 3 — Add to Application Menu (GUI integration)
# Create a `.desktop` file:
mkdir -p ~/.local/share/applications
vim ~/.local/share/applications/wezterm.desktop
# Add this in wezterm.desktop
[Desktop Entry]
Name=WezTerm
Exec=/home/YOUR_USERNAME/apps/wezterm
Icon=utilities-terminal
Type=Application
Categories=System;TerminalEmulator;
# Replace `YOUR_USERNAME` with your actual username.

# update desktop database:
update-desktop-database ~/.local/share/applications
```

1. Neovim AppImage: https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
2. Wezterm AppImage: https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage

- **Configure Wezterm terminal**

Put the configuration: `~/.wezterm.lua` or `~/.config/wezterm/wezterm.lua`

```sh
local wezterm = require("wezterm")

return {
  font = wezterm.font_with_fallback {
    {
      family = 'JetBrainsMono Nerd Font',
      harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
    },
    -- Add more fallback fonts here if needed
  },
  font_size = 13.0,

  color_scheme = "Snazzy",

  enable_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  window_decorations = "RESIZE",

  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },

  use_fancy_tab_bar = false,

  window_close_confirmation = "NeverPrompt",
}
```

- **Install precompiled binary (clangd, ripgrep, etc)**

**ripgrep:** https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz

```sh
wget https://github.com/clangd/clangd/releases/download/20.1.8/clangd-linux-20.1.8.zip
unzip clangd-linux-20.1.8.zip -d ~/apps/
# tar -xvzf ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz -C ~/apps/

# ~/bin holds the executables
ln -sfn ~/apps/clangd_20.1.8/bin/clangd ~/bin/clangd
# ln -sfn ~/apps/ripgrep-14.1.1-x86_64-unknown-linux-musl/rg ~/bin/rg

# add path in ~/.bashrc or ~/.zshrc
export CLANGD_PATH="$HOME/clangd"
export PATH="$HOME/bin:$CLANGD_PATH/bin:$PATH"
# Reload shell
source ~/.bashrc # source ~/.zshrc

# Now you can run from terminal:
clangd --version
```

- **Install nvm**

```sh
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.6/install.sh | bash

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Add to .bashrc/.zshrc for persistence
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$NVM_DIR/versions/node/$(nvm version)/bin:$PATH"
source ~/.bashrc

# Install a node version
nvm install --lts   # e.g., installs Node 20.x
nvm use --lts
node -v
npm -v

# Install packages
npm install -g typescript-language-server pyright
```

- **Install go**

```sh
# create apps and bin dirs if not already exists
mkdir -p ~/apps ~/bin

#  fetch and extract go package
wget https://go.dev/dl/go1.25.0.linux-amd64.tar.gz
unzip go1.25.0.linux-amd64.tar.gz -d ~/apps/
cd ~/apps
mv go go-1.25.0

# ~/bin holds the executables
ln -sfn ~/apps/go-1.25.0/bin/go ~/bin/go
ln -sfn ~/apps/go-1.25.0/bin/gofmt ~/bin/gofmt

# add path in ~/.bashrc or ~/.zshrc
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$GOPATH/bin:$PATH"
# Reload shell
source ~/.bashrc # source ~/.zshrc

# Test go
go version
# go version go1.25.0 linux/amd64
which go
# /home/you/bin/go

# install gopls
go install golang.org/x/tools/gopls@latest
which gopls
# /home/you/go/bin/gopls

```

- **Install fonts (user only)**

```sh
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
# Update the font cache
fc-cache -f -v
# check installed fonts
fc-list | grep -i "JetBrainsMono"
```