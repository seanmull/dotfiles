install:
	./install.sh

restore:
	./recover.sh

config:
	cd ~
	git clone git@github.com:seanmull/dotfiles.git
	cd ~/dotfiles
	stow zsh
	stow lvim
	stow alacritty
	stow .tmux.conf


