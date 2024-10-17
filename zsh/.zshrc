# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

export LIBVA_DRIVER_NAME=iHD # intel vaapi driver for mbp12,1/arch/i3
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
export THEME_DIR="/usr/share/themes/catppuccin-mocha-lavender-standard+default"
export ELECTRON_OZONE_PLATFORM_HINT=auto # Wayland Electron Development (v28+)
export EDITOR='nvim' # Set default text edtior for terminal
export BROWSER='firefox-developer-edition'
export BAT_THEME="Catppuccin Mocha"
export BAT_CONFIG_PATH="/Users/randy99/.config/bat/config/bat.conf"
export COLORTERM=truecolor
export FZF_DEFAULT_OPTS=" --preview 'bat -n --color=always {}' --bind=down:preview-down --bind=up:preview-up \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
# pnpm
export PNPM_HOME="/home/randy99/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# source directories for custom plugins
source /home/randy99/.fsh-repo/fast-syntax-highlighting.plugin.zsh # Fast Syntax Highlighting
source /home/randy99/.zsh-auto-suggest-repo/zsh-autosuggestions.zsh # zsh Autosuggestions
eval "$(zoxide init zsh)"
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
