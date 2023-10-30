export ZDOTDIR=$HOME/.config/zsh
source "$HOME/.config/zsh/.zshrc"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
zellij

if [ -e /home/s/.nix-profile/etc/profile.d/nix.sh ]; then . /home/s/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
