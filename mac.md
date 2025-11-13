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

- **Install Apple’s command-line developer tools (CLT)**:

```sh
# Install Command Line Tools
# If you don’t need full Xcode, just the developer tools (e.g., git, gcc, make, etc.)
xcode-select --install

# Verify installation
xcode-select -p
# /Library/Developer/CommandLineTools

# To uninstall command line tools (if you install xcode manually)
sudo rm -rf /Library/Developer/CommandLineTools

# To fix broken configuration
sudo xcode-select --reset

# If you install Xcode form App store
sudo xcode-select --switch /Applications/Xcode.app
# Verify installation
xcode-select -p
```

- **Install Homebrew**:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# to add Homebrew to your PATH
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> $HOME/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# update everything in Homebrew
brew update && brew upgrade

# Cleanup unused packages
brew cleanup

# GUI (macOS applications, e.g. Chrome, Visula studio code)
brew install --cask <cask_name>
brew uninstall --cask <cask_name>
brew list --cask
brew list --cask --versions

# command-line tools (e.g. node, python, wget)
brew install <formula>
brew uninstall <formula>
brew list
brew list --formula
brew list --formula --versions

# check a specific package type
brew info <package_name>

# list availablity
brew search --formula
brew search node

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
  pnpm \
  go
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

- **Install Node**:

```sh
# Install fnm (Fast Node Manager)
# It’s much faster than nvm
brew install fnm
# or
cargo install fnm

# Add environment variable for fnm
echo 'eval "$(fnm env --use-on-cd)"' >> ~/.zshrc
source ~/.zshrc

# Install the latest LTS (Long-Term Support) version of Node
fnm install --lts
fnm install 20.14.0

# List all locally installed Node.js versions
fnm list

# Change Node.js version
# Usage: fnm use [OPTIONS] [VERSION]

# Set a version as the default version or get the current default version.
# This is a shorthand for `fnm alias VERSION default`
# Usage: fnm default [OPTIONS] [VERSION]

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

#  list all globally installed packages
npm list -g --depth=0
```

- **Install NVIM**:

```sh
# Install boo
# Bob is a Neovim version manager — like nvm for Node or pyenv for Python
# It allows: Install multiple versions, Switch between them, Keep them isolated
brew install bob

# Install nvim
bob install stable
bob install nightly
bob install 0.11.4

# Set a version as default
bob use stable

# Check which version is active
bob list

# Add nvim to your path
echo 'export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
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

- **Install Rust**:

```sh
# install
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# add path to: ~/.zshrc
export PATH="$HOME/.cargo/bin:$PATH"
source ~/.zshrc

# check version
rustc --version
cargo --version
```

**Install Anaconda**:

```sh
# Install Miniconda
brew install --cask miniconda

# Initialize conda
conda init "$(basename "${SHELL}")"

# Stop automatically activation of base env
conda config --set auto_activate false

# Remove all unneccesary packages from base
conda clean --all

# Create, activate and deactivate environment
conda create -n env_name python=3.9
conda activate env_name
conda deactivate

# Check created env list
conda env list

# Remove a env
conda remove --name env_name --all

# Remove a package from an env
conda remove --name env_name package_name

# Install official packages
conda install package_name

# Install Open-source community packages
conda install -c conda-forge package_name

# To set conda-forge as a default channel
conda config --add channels conda-forge
conda config --set channel_priority strict

# Show conda configurations
conda config --show

# To create virtual environment without anaconda
python3 -m venv venv
source venv/bin/activate
deactivate
pip install package_name
```

- **Install FFmpeg (screen recording)**:

```sh
brew install ffmpeg

# list available devices
ffmpeg -f avfoundation -list_devices true -i ""

# Output:
# [AVFoundation indev @ 0x138704900] AVFoundation video devices:
# [AVFoundation indev @ 0x138704900] [0] FaceTime HD Camera
# [AVFoundation indev @ 0x138704900] [1] iPhone 15 Pro Max Camera
# [AVFoundation indev @ 0x138704900] [2] iPhone 15 Pro Max Desk View Camera
# [AVFoundation indev @ 0x138704900] [3] Capture screen 0
# [AVFoundation indev @ 0x138704900] AVFoundation audio devices:
# [AVFoundation indev @ 0x138704900] [0] iPhone 15 Pro Max Microphone
# [AVFoundation indev @ 0x138704900] [1] MacBook Air Microphone

# to start record at a reasonable file size without losing important visual fidelity (especially for presentations, coding, terminal sessions, or slides)
# to record for a fixed time (e.g., 3 hours = 10800s): -t 10800
# to add video and audio if needed (e.g., Capture srceen index 3, mic index 1): -i "3:1", -i "3:none", etc
# the output video file will be saved in the current working directory as: screencast.mp4
# in MAC:
ffmpeg -f avfoundation -framerate 30 -i "3:none" \
  -preset veryfast -vcodec libx264 -crf 26 \
  -pix_fmt yuv420p screencast.mp4

# in LINUX:
ffmpeg -f x11grab -i $DISPLAY -framerate 2 \
  -probesize 40M -threads 2 -preset veryfast \
  -vcodec libx264 -crf 26 -pix_fmt yuv420p \
  screencast.mp4

# to compress further
ffmpeg -i screencast.mp4 -vcodec libx265 -crf 28 final.mp4
```

---

**Options:**

| Option                   | Meaning                                                                |
| ------------------------ | ---------------------------------------------------------------------- |
| `-f x11grab -i $DISPLAY` | Grabs the screen from your X11 display (Linux)                         |
| `-framerate 2`           | Records at 2 fps (sufficient for presentations, code, slides)          |
| `-probesize 40M`         | Improves input buffer handling, helpful for large desktops             |
| `-threads 2`             | Uses 2 threads (you can increase if needed)                            |
| `-preset veryfast`       | Balances speed and compression; `ultrafast` is faster but less compact |
| `-vcodec libx264`        | Uses efficient H.264 video compression                                 |
| `-crf 26`                | Controls quality and file size. (23 is better quality, 28 is smaller)  |
| `-pix_fmt yuv420p`       | Widely compatible pixel format                                         |
| `screencast.mp4`         | Output file name                                                       |

---

**Optional Tweaks:**

| Need                      | Change                                                     |
| ------------------------- | ---------------------------------------------------------- |
| Even smaller size         | Use `-vcodec libx265 -crf 28` (slower encoding)            |
| Higher quality            | Use `-crf 23` or `-crf 20`                                 |
| Full HD fast recording    | Use `-preset ultrafast` (less compression)                 |
| Specific window or screen | Use `-video_size 1280x720 -i :0.0+X,Y` to target area      |
| Specific output path      | Use `~/Desktop/screencast.mp4`                             |
| Part of the screen        | Use `-vf "crop=1280:720:0:0"` where `crop=out_w:out_h:x:y` |

---

**To measure specific screen region on macOS (`Cmd + Shift + 4`)**

1. Press **`Cmd + Shift + 4`**
2. Your cursor becomes a crosshair ➕
3. **Click and drag** to select an area
4. While dragging, **look at the tooltip next to your cursor** – it shows:

   * Start position (`x, y`)
   * Width × Height of the selected area
5. **Note down**:

   * The starting point (`x`, `y`)
   * The selected width and height

💡 Example output:

```
x = 200, y = 150, width = 1280, height = 720
```

Then in FFmpeg, use:

```bash
-vf "crop=1280:720:200:150"
```

---

