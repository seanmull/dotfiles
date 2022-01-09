sudo apt update
sudo apt upgrade
sudo apt-get install curl
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node
sudo apt install cargo
sudo apt install g++
cargo install ripgrep
sudo apt update
sudo apt install python-pip
sudo apt update
sudo apt install python3-pip
pip install pyvim
sudo apt install fzf
sudo apt install ripgrep
sudo apt install universal-ctags
sudo apt install silversearcher-ag
sudo apt install fd-find
sudo apt-get install zsh
sudo apt install tmux
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt install neovim
LV_BRANCH=rolling bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/rolling/utils/installer/install.sh)
apt-get install x11-xkb-utils
apt-get install x11-xserver-utils
curl -fsSL https://fnm.vercel.app/install | bash
curl -sS https://webinstall.dev/zoxide | bash
sudo apt install alacritty
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
sudo apt install tree
sudo apt install unzip
sudo apt install zip
mkdir -p ~/.local/shae/fonts
cd ~/.local/share/fonts && curl -fLo "Fira Code Regular Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.otf