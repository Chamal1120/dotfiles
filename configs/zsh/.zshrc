#Aliases
alias ls='eza --icons'
alias la='eza -a'
alias lla='eza -la'
#alias lt='eza -TL 2'
#alias vim='nvim'
alias cat='bat'
alias man='batman'
alias yt-dlp-fhd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf'
alias yt-dlp-hd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-720.conf'
alias yt-dlp-audio='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-audio.conf'
#alias ctltui='systemctl-tui'
#alias kblit='set_kb_backlight'
#alias myed="ed -p ':'"

# Enable completion system
autoload -Uz compinit
compinit

# Load bash completions
autoload -U bashcompinit && bashcompinit

# Show comp menu if multiple matches
zstyle ':completion:*' menu select

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a=z}={A-Za-z}'

# Better completion for paths
zstyle ':completions:*' list-colors ''

# Ignore duplicate entries
zstyle ':completions:*' squeeze-slashes true

export FUNCNEST=1000
DISABLE_AUTO_TITLE="true"

# zsh history config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Enable extended globbing
setopt EXTENDED_GLOB

# Variable exports
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export JAVA_HOME=/usr/lib/jvm/java-24-openjdka
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FLASK_DEBUG=1
export XCURSOR_SIZE=24
export CHROME_EXECUTABLE=/usr/bin/google-chrome-stable
export LIBVA_DRIVER_NAME=iHD
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DOCKER_CLIENT_PARALLELISM=1
export MOZ_ENABLE_WAYLAND=1
export ELECTRON_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto # Wayland Electron Development (v28+)
export EDITOR='nvim'
export BROWSER='chrome'
export BAT_THEME="Catppuccin Mocha"
export BAT_CONFIG_PATH="/Users/$USER/.config/bat/config/bat.conf"
export STARSHIP_CONFIG=~/.config/starship.toml
export COLORTERM=truecolor
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
export PATH="/home/$USER/.bun/bin:$PATH"
export PATH="/home/$USER/.cargo/bin:$PATH"
export FZF_DEFAULT_OPTS=" --preview 'bat -n --color=always {}' --bind=down:preview-down --bind=up:preview-up \
--color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
# pnpm
export PNPM_HOME="/home/$USER/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
[ -f "/$HOME/.ghcup/env" ] && . "/$HOME/.ghcup/env" # ghcup-env
export PATH="$PATH":"$HOME/.local/scripts/"

# Shell hotkeys (keybinds)
bindkey -s '^f' 'tsesh\n'
bindkey -s '^g' 'gropen\n'

if [[ -n "$TMUX" ]]; then
  setopt ignoreeof
fi

# source directories for custom plugins
source /home/$USER/.zsh-plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
#source /home/$USER/.zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh) # enable fzf for zsh completions (use ctrl + t)
eval "$(starship init zsh)"
