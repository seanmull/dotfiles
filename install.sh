#!/bin/bash

# Add additional repositories
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:deadsnakes/ppa
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
sudo add-apt-repository universe

# Get the lastest package lists
sudo apt update
sudo apt upgrade

# Python
sudo apt install python-pip
sudo apt install python3-pip
pip install pyvim
sudo apt-get install python2.7
sudo apt-get install python3.10
sudo pip3 install ueberzug

# Package managers
sudo apt-get install curl
sudo apt install wget
sudo apt install snap

# Neovim
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
npm i -g eslint prettier
sudo apt install cargo
sudo apt install g++
cargo install ripgrep
sudo apt install fzf
sudo apt install ripgrep
sudo apt install universal-ctags
sudo apt install silversearcher-ag
sudo apt install fd-find
sudo apt-get install zsh
sudo apt install tmux
sudo apt install neovim
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)

# Utilities
apt-get install x11-xkb-utils
apt-get install x11-xserver-utils
sudo apt-get install libxext-dev
curl -fsSL https://fnm.vercel.app/install | bash
curl -sS https://webinstall.dev/zoxide | bash
sudo apt install alacritty
sudo apt install tree
sudo apt install unzip
sudo apt install zip
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
sudo apt-get install insomnia
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo snap install httpie
sudo snap install --classic code
sudo apt-get install stow

# Themes

# Install docker
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Final message
echo All applications have been installed

# Exit the script
exit 0
