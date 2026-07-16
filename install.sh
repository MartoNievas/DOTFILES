#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

# ─── Colores ──────────────────────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_ok() { echo -e "${GREEN}[OK]${NC}    $*"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC}  $*"; }

# ─── Mapa de dotfiles (Origen = Destino) ──────────────────────────────────────
declare -A LINKS=(
  [zshrc]="$HOME/.zshrc"
  [zprofile]="$HOME/.zprofile"
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

  # Si el archivo de origen no existe en ~/dotfiles, lo salta
  if [ ! -e "$src" ]; then
    log_warn "No se encontró el origen: $src"
    continue
  fi

  # Asegurar que el directorio de destino exista (ej: ~/.config)
  mkdir -p "$(dirname "$dst")"

  # Si ya es un symlink, lo borra para renovarlo
  if [ -L "$dst" ]; then
    rm "$dst"
  # Si es un archivo o carpeta real, backup preventivo
  elif [ -e "$dst" ]; then
    mv "$dst" "${dst}.bak"
    log_warn "Se creó backup: ${dst}.bak"
  fi

  # Crear el enlace simbólico
  ln -s "$src" "$dst"
  log_ok "$file ➔ $dst"
done

echo "¡Dotfiles vinculados con éxito!"
