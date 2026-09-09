# --- OPTION CONFIG (Suckless Style) ---
[[ $- != *i* ]] && return

# Historial
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# --- AUTOCOMPLETADO OPTIMIZADO ---
autoload -Uz compinit
# Regenera zcompdump si tiene más de 24 hs; si no, carga rápido con -C
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

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
  local commit="$*"
  if [[ -z "$commit" ]]; then
    echo "Empty commit message, please write an informative message"
    return 1
  fi
  git add . && git commit -m "$commit" && git push
}

mget() {
  if [ -z "$MOODLE_SESSION" ]; then
    echo "Error: Primero define tu cookie con: export MOODLE_SESSION=\"tu_cookie\""
    return 1
  fi
  wget --header="Cookie: MoodleSession=$MOODLE_SESSION" --content-disposition "$@"
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

alias cuis="cd \"$_desktop_dir/cuis\" && nohup ./RunCuisUniversityOnLinux.sh >/dev/null 2>&1 & disown && exit"

# --- PREFERENCIAS DE GIT ---
alias git-up="git pull --recurse-submodules && git submodule update --remote --recursive --rebase"
alias shortcuts="~/dev/suckless-btw/scripts/shortcuts.sh"

# --- ROFI CONFIG ---
alias crofi="vim ~/.config/rofi/config.rasi"
alias trofi="vim ~/.config/rofi/theme.rasi"
alias colrofi="vim ~/.config/rofi/colors.rasi"

# --- MANTENIMIENTO ---
alias clean='echo "--- Limpiando caché de paquetes ---" && sudo paccache -rk 2 && echo "--- Eliminando huérfanos ---" && (sudo pacman -Rs $(pacman -Qdtq) || echo "No hay huérfanos") && echo "--- Limpiando logs ---" && sudo journalctl --vacuum-time=2weeks && echo "Sistema limpio!"'

# --- PROMPT (Tokyo Night) ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{#ff79c6}(%b)%f '
setopt PROMPT_SUBST
PROMPT='%F{208}%n%F{15} %F{15}%m %F{74}%~ %F{205}${vcs_info_msg_0_}%F{15}❯ %f'

# --- KEYBINDINGS (Modo Emacs) ---
bindkey -e
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char

# Ctrl+x, Ctrl+e para editar comando actual en Neovim
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# --- PLUGINS (Arch Linux repo paths) ---
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if ! ssh-add -l > /dev/null 2>&1; then
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# --- ENTORNO LOCAL ---
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

# --- FACULTAD ---
alias cursada="cd ~/Desktop/cursada-2026/"
