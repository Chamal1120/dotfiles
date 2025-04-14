#Aliases
alias ffetch='fastfetch'
alias cd='z'
alias ls='eza --icons'
alias la='eza -a'
alias lla='eza -la'
alias lt='eza -TL 2'
alias cat='bat'
alias yt-dlp-fhd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf'
alias yt-dlp-hd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-720.conf'
alias yt-dlp-audio='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-audio.conf'
alias yz='yazi'
alias kblit='set_kb_backlight'
alias inlyne="inlyne -c ~/.config/inlyne/inlyne.default.toml"

# zsh history config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Variable exports
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/java-24-openjdk
export FLASK_DEBUG=1
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export CHROME_EXECUTABLE=/usr/bin/vivaldi
export XCURSOR_THEME="BreezeX-RosePine-Linux"
export XCURSOR_SIZE=24
export LIBVA_DRIVER_NAME=iHD # Force Intel-media-driver intel vaapi driver
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DOCKER_CLIENT_PARALLELISM=1
export QT_SCALE_FACTOR=1
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export WAYLAND_DISPLAY=wayland-1
export XDG_SESSION_TYPE=wayland
export ELECTRON_ENABLE_WAYLAND=1
export GTK_CSD=0
export ELECTRON_OZONE_PLATFORM_HINT=auto # Wayland Electron Development (v28+)
export EDITOR='nvim' # Set default text edtior for terminal
export BROWSER='brave'
export BAT_THEME="Catppuccin Mocha"
export BAT_CONFIG_PATH="/Users/$USER/.config/bat/config/bat.conf"
export STARSHIP_CONFIG=~/.config/starship.toml
export COLORTERM=truecolor
export PATH="/home/$USER/.bun/bin:$PATH"
export FZF_DEFAULT_OPTS=" --preview 'bat -n --color=always {}' --bind=down:preview-down --bind=up:preview-up \
--color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
# pnpm
export PNPM_HOME="/home/$USER/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# source directories for custom plugins
source /home/$USER/.fsh-repo/fast-syntax-highlighting.plugin.zsh # Fast Syntax Highlighting
source /home/$USER/.zsh-auto-suggest-repo/zsh-autosuggestions.zsh # zsh Autosuggestions
source <(fzf --zsh) # enable fzf for zsh completions (use ctrl + t)
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
