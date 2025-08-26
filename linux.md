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

- **Install clangd**

```sh
wget https://github.com/clangd/clangd/releases/download/20.1.8/clangd-linux-20.1.8.zip
unzip clangd-linux-20.1.8.zip -d ~/apps/
# add path in ~/.bashrc or ~/.zshrc
export PATH="$HOME/apps/clangd_20.1.8/bin:$PATH"
# Reload shell
source ~/.bashrc # source ~/.zshrc
# Now you can run from terminal:
clangd --version
```

- **Install fonts (user only)**

```sh
mkdir -p ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -f -v
```