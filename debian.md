# Debian Setup

## 1. Add sudoers

```
$ su -
$ nano /etc/sudoers
```

add this line

```
username ALL=(ALL) ALL
```

## 2. Install git

```
$ sudo apt install git

$ sudo apt install make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev libexpat1-dev gettext unzip
```

## 3. Set default Shell

```
$ chsh -s /usr/bin/fish # fish as default
$ chsh -s /bin/bash # bash
$ chsh -s /usr/bin/zsh # zsh
```

## 4. Install fish & oh-my-fish

- [fish](https://ostechnix.com/install-fish-friendly-interactive-shell-linux/)
- [oh-my-fish](https://ostechnix.com/oh-fish-make-shell-beautiful/)
