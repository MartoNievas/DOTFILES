# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Preferencias
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias vim="nvim"

#Config dwm
alias cdwm="vim ~/dev/suckless-btw/dwm/config.def.h"
alias mdwm="cd ~/dev/suckless-btw/dwm/; sudo rm config.h && sudo make clean install; cd ..; cd .."
alias ddwm="cd ~/dev/suckless-btw/dwm/"

#Dwm blocks
alias cdwmb="vim ~/dev/suckless-btw/dwm/dwmblocks/blocks.def.h"
alias mdwmb="cd ~/dev/suckless-btw/dwm/dwmblocks/; sudo rm blocks.h && sudo make clean install; cd ~/"
alias ddwmb="cd ~/dev/suckless-btw/dwm/dwmblocks/"

#Config st
alias cst="vim ~/dev/suckless-btw/st/config.def.h"
alias mst="cd ~/dev/suckless-btw/st/; sudo rm config.h && sudo make clean install; cd ..; cd .."
alias dst="cd ~/dev/suckless-btw/st/"
PS1='[\u@\h \W]\$ '

#Config slstatus
alias csl="vim ~/dev/suckless-btw/slstatus/config.def.h"
alias msl="cd ~/dev/suckless-btw/slstatus/; sudo rm config.h && sudo make clean install; cd ..; cd .."
alias dsl="cd ~/dev/suckless-btw/slstatus/"

#Config rofi

alias crofi="sudo vim ~/.config/rofi/config.rasi"
alias trofi="sudo vim ~/.config/rofi/theme.rasi"
alias colrofi="sudo vim ~/.config/rofi/colors.rasi"

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
export PS1="${FG_ORANGE}\u${FG_WHITE} ${FG_WHITE}\h ${FG_BLUE}\w${FG_PINK}\$(parse_git_branch)${FG_WHITE} ❯ ${C_RESET}"

alias clean='echo "--- Limpiando caché de paquetes ---" && sudo paccache -rk 2 && echo "--- Eliminando huérfanos ---" && sudo pacman -Rs $(pacman -Qdtq) || echo "No hay huérfanos que eliminar" && echo "--- Limpiando logs antiguos ---" && sudo journalctl --vacuum-time=2weeks && echo "--- Limpiando caché de usuario ---" && rm -rf ~/.cache/* && echo "Sistema limpio!"'

export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

alias lss="ls | sort"

alias up=". /usr/local/bin/up.sh"
alias dot="cd ~/dev/suckless-btw/dotfiles/"

#Smalltalk
alias cuis="cd ~/Escritorio/linux64/ && (./run.sh &) && exit"
. "$HOME/.cargo/env"

. "$HOME/.local/share/../bin/env"
