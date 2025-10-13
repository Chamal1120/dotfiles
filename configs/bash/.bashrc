# ~/.bashrc

[[ $- != *i* ]] && return

# Aliases
alias grep='grep --color=auto'
alias ls='eza --icons'
alias la='eza -a'
alias lla='eza -la'
alias cat='bat'
alias man='batman'
alias yt-dlp-fhd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf'
alias yt-dlp-hd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-720.conf'
alias yt-dlp-audio='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-audio.conf'

# Environment
export FUNCNEST=1000
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$HOME/.bun/bin:$HOME/.cargo/bin:$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
export JAVA_HOME="/usr/lib/jvm/java-24-openjdka"
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FLASK_DEBUG=1
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=24
export CHROME_EXECUTABLE=/usr/bin/vivaldi
export LIBVA_DRIVER_NAME=iHD
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DOCKER_CLIENT_PARALLELISM=1
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto
export EDITOR='nvim'
export BROWSER='vivaldi'
export BAT_THEME="Catppuccin Mocha"
export BAT_CONFIG_PATH="$HOME/.config/bat/config/bat.conf"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export COLORTERM=truecolor
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env"
export PATH="$PATH:$HOME/.local/scripts/"

# FZF
export FZF_DEFAULT_OPTS="
  --preview 'bat -n --color=always {}' \
  --bind=down:preview-down \
  --bind=up:preview-up \
  --color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"
if command -v fzf &>/dev/null; then
  source <(fzf --bash)
fi

# Shell options
shopt -s extglob
if [[ -n "$TMUX" ]]; then
  set -o ignoreeof
fi

# Key bindings
bind '"\C-f": "tsesh\n"'
bind '"\C-g": "gropen\n"'

# Starship prompt
eval "$(starship init bash)"

# Extra environment scripts
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Prompt fallback if Starship not installed
PS1='[\u@\h \W]\$ '
