# ~/.zshenv
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

export EDITOR="nvim"
export TERMINAL="ghostty"
export DEBUGINFOD_URLS="https://debuginfod.archlinux.org"

# Socket del agente SSH
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR:-/run/user/$UID}/ssh-agent.socket"

# PATH sin duplicados
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.npm-global/bin"
  $path
)
export PATH

