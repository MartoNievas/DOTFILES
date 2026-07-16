# --- OPTION CONFIG (Suckless Style) ---
# Si no es interactivo, salir
[[ $- != *i* ]] && return

# Historial
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- AUTOCOMPLETADO ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Z_a-z}'

# Tokyo Night colors
zstyle ':completion:*' list-colors \
    "di=38;2;122;162;247" \
    "fi=38;2;169;177;214" \
    "ex=38;2;158;206;106" \
    "ln=38;2;187;154;247" \
    "*.zip=38;2;255;121;198" \
    "*.tar=38;2;255;121;198" \
    "*.gz=38;2;255;121;198"

zstyle ':completion:*:descriptions' format '%F{#7aa2f7}[%d]%f'
zstyle ':completion:*:warnings' format '%F{#f7768e}no matches%f'
zstyle ':completion:*:messages' format '%F{#e0af68}%d%f'
zstyle ':completion:*' group-name ''

# --- PREFERENCIAS & ALIASES ---

up() {
  local levels=${1:-1}
  local dir=""

  for ((i=0; i<levels; i++)); do
      dir="../$dir"
  done

  cd "$dir"
}

git-update() {
  local commit=$1

  if [[ -z "$commit" ]]; then
    echo "Empty commit message, please write an informative message"
    return 1
  fi

  git add . && git commit -m "$commit" && git push
}

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias vim="nvim"
alias lss="ls | sort"
alias dot="cd ~/dotfiles"
alias cad="$HOME/dev/suckless-btw/scripts/audio-device-selector-handler.sh"

if command -v xdg-user-dir >/dev/null 2>&1; then
  _desktop_dir="$(xdg-user-dir DESKTOP)"
else
  _desktop_dir="$HOME/Desktop"
  for _d in "$HOME/Desktop" "$HOME/desktop" "$HOME/Escritorio" "$HOME/escritorio"; do
    [[ -d "$_d" ]] && { _desktop_dir="$_d"; break; }
  done
fi

alias cuis="cd \"$_desktop_dir/linux64\" && (./run.sh &) && exit"

# --- PREFERENCIAS DE GIT ---

alias git-up="git pull --recurse-submodules && git submodule update --remote --recursive --rebase"

alias shortcuts="~/dev/suckless-btw/scripts/shortcuts.sh"

# --- ROFI CONFIG ---
alias crofi="vim ~/.config/rofi/config.rasi"
alias trofi="vim ~/.config/rofi/theme.rasi"
alias colrofi="vim ~/.config/rofi/colors.rasi"

# --- MANTENIMIENTO ---
alias clean='echo "--- Limpiando caché de paquetes ---" && sudo paccache -rk 2 && echo "--- Eliminando huérfanos ---" && (sudo pacman -Rs $(pacman -Qdtq) || echo "No hay huérfanos") && echo "--- Limpiando logs ---" && sudo journalctl --vacuum-time=2weeks && echo "--- Limpiando cache usuario ---" && rm -rf ~/.cache/* && echo "Sistema limpio!"'

# --- EXPORTS ---
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# --- PROMPT (Tokyo Night) ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{#ff79c6}(%b)%f '
setopt PROMPT_SUBST
PROMPT='%F{208}%n%F{15} %F{15}%m %F{74}%~ %F{205}${vcs_info_msg_0_}%F{15}❯ %f'

bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
bindkey -e

# --- PLUGINS ---
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export PATH="$HOME/.npm-global/bin:$PATH"

# --- GESTION DE CLAVE SSH ---

# Archivo donde guardaremos la info del agente
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Si el socket no existe, iniciamos el agente
if [ ! -S "$SSH_AUTH_SOCK" ]; then
    ssh-agent -a "$SSH_AUTH_SOCK" > /dev/null
fi

# Intentar añadir la llave solo si no está ya cargada
if ! ssh-add -l > /dev/null 2>&1; then
    ssh-add ~/.ssh/id_ed25519
fi

[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
