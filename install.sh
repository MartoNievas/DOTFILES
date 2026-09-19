#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

# ─── Colores ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_ok() { echo -e "${GREEN}[OK]${NC}   $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }

# ─── Mapa de dotfiles (Origen = Destino) ──────────────────────────────────────
declare -A LINKS=(
  [zshrc]="$HOME/.zshrc"
  [zprofile]="$HOME/.zprofile"
  [zshenv]="$HOME/.zshenv"
  [bashrc]="$HOME/.bashrc"
  [bash_profile]="$HOME/.bash_profile"
  [tmux.conf]="$HOME/.tmux.conf"
  [nvim]="$HOME/.config/nvim"
  [yazi]="$HOME/.config/yazi"
)

echo "Creando enlaces simbólicos..."

for file in "${!LINKS[@]}"; do
  src="$DOTFILES_DIR/$file"
  dst="${LINKS[$file]}"

  # Quitar posible slash final para no romper tests de symlink
  dst="${dst%/}"

  if [ ! -e "$src" ]; then
    log_warn "No se encontró el origen: $src"
    continue
  fi

  mkdir -p "$(dirname "$dst")"

  # Si ya es un symlink (roto o sano), se borra directamente
  if [ -L "$dst" ]; then
    rm -f "$dst"
  # Si es un directorio o archivo real preexistente, backup preventivo
  elif [ -e "$dst" ]; then
    timestamp=$(date +%Y%m%d%H%M%S)
    mv "$dst" "${dst}.bak.${timestamp}"
    log_warn "Se creó backup: ${dst}.bak.${timestamp}"
  fi

  # -s: simbólico, -f: fuerza, -n / -T: trata el destino como archivo normal si es symlink a directorio
  ln -snf "$src" "$dst"
  log_ok "$file ➔ $dst"
done

echo "¡Dotfiles vinculados con éxito!"
