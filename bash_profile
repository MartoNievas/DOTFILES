# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

startx
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"

. "$HOME/.local/share/../bin/env"
