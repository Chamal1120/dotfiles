# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#Alias for fastfetch
alias ffetch='fastfetch'

alias cd='z'

# Aliases for eza commands
alias ls='eza --icons'
alias la='eza -a'
alias lla='eza -la'
alias lt='eza -TL 2'

# Alias for bat to use as cat
alias cat='bat'

# Aliases for yt-dlp.configs
alias yt-dlp-fhd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp.conf'
alias yt-dlp-hd='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-720.conf'
alias yt-dlp-audio='yt-dlp --config-location ~/.config/yt-dlp/yt-dlp-audio.conf'

# Alias for yazi
alias yz='yazi'

# Alias for mbp12,1/arch/i3 keyboard backlit script
alias kblit='set_kb_backlight'

# Alias for inlyine
alias inlyne="inlyne -c ~/.config/inlyne/inlyne.default.toml"

# History file settings for zsh-suggestions
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# intel vaapi driver for mbp12,1/arch/i3
#export LIBVA_DRIVER_NAME=i965
export LIBVA_DRIVER_NAME=iHD

export XDG_RUNTIME_DIR=/run/user/$(id -u)

export DOCKER_CLIENT_PARALLELISM=1

# Wayland stuff
export QT_SCALE_FACTOR=1
export GDK_SCALE=1
export GDK_DPI_SCALE=1
export MOZ_ENABLE_WAYLAND=1

export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export XDG_SESSION_TYPE=wayland
export ELECTRON_ENABLE_WAYLAND=1

# source directories for custom plugins
# Fast Syntax Highlighting
source /home/randy99/.fsh-repo/fast-syntax-highlighting.plugin.zsh
# zsh Autosuggestions
source /home/randy99/.zsh-auto-suggest-repo/zsh-autosuggestions.zsh

# Set default text edtior for terminal
export EDITOR='nvim'
export BROWSER='firefox-developer-edition'

# Other variable exports
export BAT_THEME="Catppuccin Mocha"
export BAT_CONFIG_PATH="/Users/randy99/.config/bat/config/bat.conf"

export COLORTERM=truecolor

export FZF_DEFAULT_OPTS=" --preview 'bat -n --color=always {}' --bind=down:preview-down --bind=up:preview-up \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Special init commands for custom packages
eval "$(zoxide init zsh)"

# pnpm
export PNPM_HOME="/home/randy99/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
