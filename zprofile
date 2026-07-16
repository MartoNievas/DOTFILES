# ~/.zprofile
export PATH="$HOME/.local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export EDITOR="nvim"
export TERMINAL="st"

# Arranca X si estamos en TTY1
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
