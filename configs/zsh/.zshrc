# =========================
# 1. Shell options & history
# =========================
setopt EXTENDED_GLOB
DISABLE_AUTO_TITLE="true"
FUNCNEST=10000

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Ignore Ctrl-D exit in TMUX
if [[ -n "$TMUX" ]]; then
  setopt ignoreeof
fi

# =========================
# 2. Environment variables
# =========================
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='chrome'
export PATH="$HOME/.cargo/bin:$HOME/.bun/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk # Replace 21 with the installed version
export PATH=$JAVA_HOME/bin:$PATH
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export FLASK_DEBUG=1
export XCURSOR_SIZE=24
export CHROME_EXECUTABLE=/usr/local/bin/helium
export LIBVA_DRIVER_NAME=iHD
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export DOCKER_CLIENT_PARALLELISM=1
export MOZ_ENABLE_WAYLAND=1
export GVIM_ENABLE_WAYLAND=1
export ELECTRON_ENABLE_WAYLAND=1
export ELECTRON_OZONE_PLATFORM_HINT=auto
export BAT_THEME="Catppuccin Mocha"
export BAT_CONFIG_PATH="$HOME/.config/bat/config/bat.conf"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
export COLORTERM=truecolor
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
export NODE_REPL_MODE=sloppy
export NODE_REPL_HISTORY_FILE=~/.node_repl_history
export NODE_NO_READLINE=0

# Add .NET Core SDK tools
export PATH="$PATH:$HOME/.dotnet/tools"

# PNPM
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# FZF customization
export FZF_DEFAULT_OPTS=" --preview 'bat -n --color=always {}' \
--bind=down:preview-down --bind=up:preview-up \
--color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# ghcup environment (uncomment if haskell toolchain was installed with ghcup)
#[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# Custom scripts
export PATH="$PATH:$HOME/.local/scripts/"

# =========================
# 3. Vi-mode for Zsh
# =========================
bindkey -v

# =========================
# 4. Aliases
# =========================
alias ls='eza --icons'
alias la='eza -a'
alias lla='eza -la'
alias ll='eza -l'
alias lt='eza -TL 2'
alias vim='nvim'
alias cat='bat'
alias man='batman'
alias yt-dlp-fhd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf'
alias yt-dlp-hd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-720.conf'
alias yt-dlp-audio='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-audio.conf'
# alias ctltui='systemctl-tui'
# alias kblit='set_kb_backlight'
# alias myed="ed -p ':'"

# =========================
# 5. Completion system
# =========================
autoload -Uz compinit
compinit

# Load bash completions
autoload -U bashcompinit && bashcompinit

# Completion behavior
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a=z}={A-Za-z}'
zstyle ':completions:*' list-colors ''
zstyle ':completions:*' squeeze-slashes true

# =========================
# 6. Plugins
# =========================
# Fast syntax highlighting
source $HOME/.zsh-plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# FZF integration (Ctrl+T, etc.)
source <(fzf --zsh)

# Starship prompt
eval "$(starship init zsh)"

# =========================
# 7. Custom keybinds
# =========================
bindkey -s '^f' 'tsesh\n'
bindkey -s '^g' 'gropen\n'
