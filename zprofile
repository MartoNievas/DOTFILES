# ~/.zprofile
# Arrancar X11 o Wayland automáticamente al loguearse en tty1
if [[ -z "$DISPLAY" ]] && [[ "$XDG_VTNR" -eq 1 ]]; then
    exec startx
fi
