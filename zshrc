# ==============================================================================
# 0. GUARDIA DE SHELL NO INTERACTIVA
# ==============================================================================
# Si la shell no es interactiva (ej. al correr scripts externos), sale de inmediato
# para no perder tiempo evaluando el resto del archivo.
[[ $- != *i* ]] && return

# ==============================================================================
# 1. OPCIONES DE LA SHELL & COMPORTAMIENTO
# ==============================================================================
# Permite cambiar de directorio escribiendo solo la ruta sin necesidad de 'cd'.
setopt AUTO_CD

# Solo una ocurrencia del mismo comando
setopt HIST_IGNORE_DUPS


# ==============================================================================
# 2. HISTORIAL DE COMANDOS
# ==============================================================================
# Archivo de persistencia y límites de historial (en memoria y guardado en disco).
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# APPEND_HISTORY: Agrega comandos al final del archivo en lugar de sobreescribirlo.
# SHARE_HISTORY: Comparte el historial entre terminales abiertas en tiempo real.
# INC_APPEND_HISTORY: Escribe cada comando al archivo apenas se ejecuta.
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# ==============================================================================
# 3. AUTOCOMPLETADO (Optimizado + Tema Tokyo Night)
# ==============================================================================
autoload -Uz compinit
# Carga rápida con caché (-C) salvo que el dump de autocompletado tenga más de 24 hs.
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Navegación con menú y matching insensible a mayúsculas/minúsculas.
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Z_a-z}'

# Colores de autocompletado ajustados a la paleta Tokyo Night.
zstyle ':completion:*' list-colors \
    "di=38;2;122;162;247" \
    "fi=38;2;169;177;214" \
    "ex=38;2;158;206;106" \
    "ln=38;2;187;154;247" \
    "*.zip=38;2;255;121;198" \
    "*.tar=38;2;255;121;198" \
    "*.gz=38;2;255;121;198"

# Formato visual de mensajes y avisos del autocompletador.
zstyle ':completion:*:descriptions' format '%F{#7aa2f7}[%d]%f'
zstyle ':completion:*:warnings' format '%F{#f7768e}no matches%f'
zstyle ':completion:*:messages' format '%F{#e0af68}%d%f'
zstyle ':completion:*' group-name ''

# ==============================================================================
# 4. PROMPT (Tokyo Night)
# ==============================================================================
# Extrae metadata del repositorio git activo para mostrar la rama actual.
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%F{#ff79c6}(%b)%f '
setopt PROMPT_SUBST

# Prompt con usuario, host, directorio actual (~), rama git y símbolo ❯.
PROMPT='%F{208}%n%F{15} %F{15}%m %F{74}%~ %F{205}${vcs_info_msg_0_}%F{15}❯ %f'

# ==============================================================================
# 5. ATAJOS DE TECLADO (Keybindings)
# ==============================================================================
bindkey -e
bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char

# Ctrl+X Ctrl+E: Abre el comando que estés escribiendo en el buffer dentro de Neovim.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# ==============================================================================
# 6. FUNCIONES
# ==============================================================================
# Sube N niveles en el árbol de directorios (por defecto 1).
up() {
  local levels=${1:-1}
  local dir=""
  for ((i=0; i<levels; i++)); do
      dir="../$dir"
  done
  cd "$dir"
}

# Realiza un git add, commit y push secuencial en una sola ejecución.
git-update() {
  local commit="$*"
  if [[ -z "$commit" ]]; then
    echo "Empty commit message, please write an informative message"
    return 1
  fi
  git add . && git commit -m "$commit" && git push
}

# Descarga archivos de Moodle autenticando con la cookie de sesión configurada.
mget() {
  if [ -z "$MOODLE_SESSION" ]; then
    echo "Error: Primero define tu cookie con: export MOODLE_SESSION=\"tu_cookie\""
    return 1
  fi
  wget --header="Cookie: MoodleSession=$MOODLE_SESSION" --content-disposition "$@"
}

# ==============================================================================
# 7. ALIASES
# ==============================================================================
# Comandos generales del sistema
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias vim="nvim"
alias lss="ls | sort"
alias dot="cd ~/dotfiles"

# Detección dinámica de la carpeta Desktop para el launcher de Cuis Smalltalk
if command -v xdg-user-dir >/dev/null 2>&1; then
  _desktop_dir="$(xdg-user-dir DESKTOP)"
else
  _desktop_dir="$HOME/Desktop"
  for _d in "$HOME/Desktop" "$HOME/desktop" "$HOME/Escritorio" "$HOME/escritorio"; do
    [[ -d "$_d" ]] && { _desktop_dir="$_d"; break; }
  done
fi

# Lanza Cuis-Smalltalk en segundo plano totalmente desacoplado de la terminal
alias cuis="cd \"$_desktop_dir/cuis\" && nohup ./RunCuisUniversityOnLinux.sh >/dev/null 2>&1 & disown && exit"

# Scripts y utilidades locales
alias cad="$HOME/dev/suckless-btw/scripts/audio-device-selector-handler.sh"
alias shortcuts="~/dev/suckless-btw/scripts/shortcuts.sh"

# Git y submódulos
alias git-up="git pull --recurse-submodules && git submodule update --remote --recursive --rebase"

# Accesos rápidos a dotfiles de Rofi
alias crofi="vim ~/.config/rofi/config.rasi"
alias trofi="vim ~/.config/rofi/theme.rasi"
alias colrofi="vim ~/.config/rofi/colors.rasi"

# Mantenimiento de Arch Linux (caché de pacman, huérfanos y logs de systemd)
alias clean='echo "--- Limpiando caché de paquetes ---" && sudo paccache -rk 2 && echo "--- Eliminando huérfanos ---" && (sudo pacman -Rs $(pacman -Qdtq) || echo "No hay huérfanos") && echo "--- Limpiando logs ---" && sudo journalctl --vacuum-time=2weeks && echo "Sistema limpio!"'

# Facultad
alias cursada="cd ~/Desktop/cursada-2026/"

# ==============================================================================
# 8. PLUGINS & INTEGRACIONES
# ==============================================================================
# Carga plugins instalados desde los repositorios de Arch
[[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Agrega la llave SSH ed25519 al agente si aún no está registrada
if ! ssh-add -l > /dev/null 2>&1; then
    ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi

# Carga variables o scripts de entorno local si existen
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
