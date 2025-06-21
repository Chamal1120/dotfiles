#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Please run this script with sudo or as root."
  exit 1
fi

# Exit immediately if any command failed
set -e

# Define the dirs
DOTFILES_DIR="$PWD/configs"
BACKUP_DIR="$HOME/.dotfiles_backup"
ZSH_PLUGINS_DIR="$HOME/.zsh-plugins"

# Define the required files and folder lists
DOTFILE_LIST=(
  alacritty
  bat
  btop
  cava
  desktop-shortcuts
  electron-flags-wayland
  fastfetch
  foot
  fsh
  gtk3
  gtk4
  hushlogin
  hyprland
  hyprpanel
  icons
  mpd
  mpv
  nvim
  nwg-look
  rofi
  starship
  thunar
  tmux
  vim
  waybar
  yazi
  yt-dlp
  zathura
  zsh
)

# Define the pacman package names
PACMAN_PKGS=(
  git
  neovim
  zsh
  alacritty
  bat
  bat-extras
  btop
  cava
  fastfetch
  foot
  mpv
  nwg-look
  rofi-wayland
  starship
  thunar
  tumbler
  ffmpegthumbnailer
  thunar-media-tags-plugin
  thunar-shares-plugin
  thunar-volum
  thunar-archive-plugin
  xarchiver
  tmux
  vim
  yazi
  yt-dlp
  zathura
  vivaldi
  libva-utils
  wireplumber
  libgtop
  bluez
  bluez-utils
  btop
  networkmanager
  dart-sass
  wl-clipboard
  brightnessctl
  swww
  python
  upower
  pacman-contrib
  gvfs
  wf-recorder
  obs-studio
  ttf-cascadia-code-nerd
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  noto-fonts-extra
  vesktop
  hyprlock
  hypridle
  hyprpaper
  hyprsunset
  hyprpicker
  rofi-emoji
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk
  papirus-icon-theme
  ripgrep
  node
  pnpm
  man-db
  xdg-utils
  wtype
  polkit-gnome
  polkit
  rar
  g4music
  swaync
)

# Define aur package names
AUR_PKGS=(
  catppuccin-gtk-theme-mocha
  papirus-folders-catppuccin-git
  webapp-manager
)

# Backup exisiting configs
backup_existing() {
  echo "Creating backup"
  mkdir -p "$BACKUP_DIR/home/.config"
  mkdir -p "$BACKUP_DIR/home"
  mkdir -p "$BACKUP_DIR/etc"

  # Backup .config
  if [ -d "$HOME/.config" ]; then
    cp -r "$HOME/.config" "$BACKUP_DIR/home/"
    echo "Backed up ~/.config"
  fi

  # Backup /etc/pacman.conf
  if [ -f /etc/pacman.conf ]; then
    sudo cp /etc/pacman.conf "$BACKUP_DIR/etc/"
    echo "Backed up /etc/pacman.conf"
  fi

  # Backup other dotfiles
  for file in .zshrc .vimrc .tmux.conf; do
    if [ -f "$HOME/$file" ]; then
      cp "$HOME/$file" "$BACKUP_DIR/home"
      echo "Backed up $file"
    fi
  done
}

# Delete the backed up configs
delete_existing() {
  echo "Deleting existing dotfiles"
  [ -d "$HOME/.config" ] && rm -rf "$HOME/.config"/*
  [ -f /etc/pacman.conf ] && sudo rm /etc/pacman.conf
  rm .zshrc .vimrc .tmux.conf
  echo "Deletion done"
}

# Symlink randy's dotfiles
symlink_dotfiles() {
  echo "Installing randy's dotfiles with stow"
  [ -d "$HOME/dotfiles/configs" ] || { echo "Dotfiles directory not found"; exit 1; }
  sudo pacman -S --noconfirm stow --needed
  stow --target=$HOME "$DOTFILE_LIST"
  sudo stow --target=/etc pacman
  echo "Dotfile installed"
}

# Setup chaotic-aur repos
setup_chaotic_aur() {
  echo "Setting up chaotic-aur repos"
  sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
  sudo pacman-key --lsign-key 3056513887B78AEB
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
  sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  sudo pacman -Syu --noconfirm
  sudo pacman -S --noconfirm paru --needed
  echo "chaotic-aur is set"
}

# Install Packages and dependanceies
install_packages() {
  echo "Installing the packages"
  sudo pacman -S --noconfirm "${PACMAN_PKGS[@]}" --needed
  sudo paru -S --noconfirm "${AUR_PKGS[@]}" --needed
  mkdir -p "$ZSH_PLUGINS_DIR"
  cd "$ZSH_PLUGINS_DIR"
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git
  git clone https://github.com/zsh-users/zsh-autosuggestions.git
  mkdir -p "$HOME/.config/tmux/plugins/catppuccin/"
  git clone -b v2.1.3 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
  echo "Package installation done"
}

# Do the final touches
finalizing_touches() {
  ZSH_PATH=$(command -v zsh)
  sudo chsh -s "$ZSH_PATH"
  echo "Adding the final sprinkes"
  xdg-mime default org.pwmt.zathura.desktop application/pdf
  papirus-folders -C cat-mocha-lavender --theme Papirus-Dark
  bat cache --build
}

put_post_instructions() {
  echo "\nI have disabled the animations, blur and opacity"
  echo "You can enable them from .config/hypr/hyprland.conf"
  echo "Plus there are some WindowRules to override opacity in browser and mpv"
  echo "Remove them if you don't need\n"
  echo "Restart your shell or run 'exec zsh' to apply changes"
}

# Run the functions
backup_existing
delete_existing
symlink_dotfiles
install_packages
finalizing_touches
put_post_instructions
