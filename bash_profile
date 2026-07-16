# ~/.bash_profile
#
[[ -f ~/.bashrc ]] && . ~/.bashrc

startx
. "$HOME/.cargo/env"

. "$HOME/.local/share/../bin/env"
