# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Preferencias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias vim="nvim"
alias lss="ls | sort"

#Config rofi
alias crofi="vim ~/.config/rofi/config.rasi"
alias trofi="vim ~/.config/rofi/theme.rasi"
alias colrofi="vim ~/.config/rofi/colors.rasi"

# Bash config
# Definición de Colores (ANSI)
FG_ORANGE='\[\033[38;5;208m\]' # Naranja similar a tu barra
FG_BLUE='\[\033[38;5;74m\]'    # Azul suave para carpetas
FG_PINK='\[\033[38;5;205m\]'   # Rosa/Magenta para Git
FG_WHITE='\[\033[38;5;15m\]'   # Blanco brillante
C_RESET='\[\033[0m\]'

# Función de Git mejorada (solo texto)
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/'
}

# Valgrind debug flags
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# Prompt estilo "Minimal-Warm"
export PS1="${FG_ORANGE}\u${FG_WHITE} ${FG_WHITE}\h ${FG_BLUE}\w${FG_PINK}\$(parse_git_branch)${FG_WHITE} ❯ ${C_RESET}"

alias clean='echo "--- Limpiando caché de paquetes ---" && sudo paccache -rk 2 && echo "--- Eliminando huérfanos ---" && (sudo pacman -Rs $(pacman -Qdtq) || echo "No hay huérfanos que eliminar") && echo "--- Limpiando logs antiguos ---" && sudo journalctl --vacuum-time=2weeks && echo "--- Limpiando caché de usuario ---" && rm -rf ~/.cache/* && echo "Sistema limpio!"'

up() {
  local levels=${1:-1}
  local dir=""

  for ((i=0; i<levels; i++)); do
      dir="../$dir"
  done

  cd "$dir"
}

alias dot="cd ~/dotfiles"

#Smalltalk
if command -v xdg-user-dir >/dev/null 2>&1; then
  _desktop_dir="$(xdg-user-dir DESKTOP)"
else
  _desktop_dir="$HOME/Desktop"
  for _d in "$HOME/Desktop" "$HOME/desktop" "$HOME/Escritorio" "$HOME/escritorio"; do
    [[ -d "$_d" ]] && { _desktop_dir="$_d"; break; }
  done
fi
alias cuis="cd \"$_desktop_dir/linux64\" && (./run.sh &) && exit"

[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
