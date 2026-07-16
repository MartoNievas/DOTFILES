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
alias dot="cd ~/dev/suckless-btw/dotfiles/"
alias cad="./$HOME/dev/suckless-btw/scripts/audio-device-selector-handler.sh" 

if [[ "$(cat /etc/hostname)" == "archlinux-desktop" ]]; then
  _cuis_path="$HOME/escritorio/linux64/"
else
  _cuis_path="$HOME/Escritorio/linux64"
fi

alias cuis="cd $_cuis_path && (./run.sh &) && exit"

# --- PREFERENCIAS DE GIT ---

alias git-up="git pull --recurse-submodules && git submodule update --remote --recursive --rebase"

alias shortcuts="~/dev/suckless-btw/scripts/shortcuts.sh"

# --- DWM CONFIG ---
alias cdwm="vim ~/dev/suckless-btw/dwm/config.def.h"
alias mdwm="cd ~/dev/suckless-btw/dwm/ && sudo rm -f config.h && sudo make clean install && cd -"
alias ddwm="cd ~/dev/suckless-btw/dwm/"

# --- DWM BLOCKS ---
alias cdwmb="vim ~/dev/suckless-btw/dwm/dwmblocks/blocks.def.h"
alias mdwmb="cd ~/dev/suckless-btw/dwm/dwmblocks/ && sudo rm -f blocks.h && sudo make clean install && cd -"
alias ddwmb="cd ~/dev/suckless-btw/dwm/dwmblocks/"

# --- ST CONFIG ---
alias cst="vim ~/dev/suckless-btw/st/config.def.h"
alias mst="cd ~/dev/suckless-btw/st/ && sudo rm -f config.h && sudo make clean install && cd -"
alias dst="cd ~/dev/suckless-btw/st/"

# --- SLSTATUS CONFIG ---
alias csl="vim ~/dev/suckless-btw/slstatus/config.def.h"
alias msl="cd ~/dev/suckless-btw/slstatus/ && sudo rm -f config.h && sudo make clean install && cd -"
alias dsl="cd ~/dev/suckless-btw/slstatus/"

# --- SLOCK CONFIG ---
alias csk="vim ~/dev/suckless-btw/slock/config.def.h"
alias msk="cd ~/dev/suckless-btw/slock/ && sudo rm -f config.h && sudo make clean install && cd -"
alias dsk="cd ~/dev/suckless-btw/slock/"

# --- ROFI CONFIG ---
alias crofi="sudo vim ~/.config/rofi/config.rasi"
alias trofi="sudo vim ~/.config/rofi/theme.rasi"
alias colrofi="sudo vim ~/.config/rofi/colors.rasi"

# --- MANTENIMIENTO ---
alias clean='echo "--- Limpiando caché de paquetes ---" && sudo paccache -rk 2 && echo "--- Eliminando huérfanos ---" && (sudo pacman -Rs $(pacman -Qdtq) || echo "No hay huérfanos") && echo "--- Limpiando logs ---" && sudo journalctl --vacuum-time=2weeks && echo "--- Limpiando cache usuario ---" && rm -rf ~/.cache/* && echo "Sistema limpio!"'

# --- COMPILAR TODO EL SISTEMA ---
alias compile_all="mst && msl && mdwm"

# --- EXPORTS ---
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# --- PROMPT (Tokyo Night) ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{#ff79c6}(%b)%f '
setopt PROMPT_SUBST
PROMPT='%F{208}%n%F{15} %F{15}%m %F{74}%~ %F{205}${vcs_info_msg_0_}%F{15}❯ %f'

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

. "$HOME/.local/share/../bin/env"
