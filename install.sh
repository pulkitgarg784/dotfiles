#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
  local src="$1" dest="$2"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$dest.bak.$(date +%s)"
    echo "backed up existing $dest"
  fi
  ln -sfn "$src" "$dest"
  echo "linked $dest -> $src"
}

# --- oh-my-zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# --- zsh plugins ---
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# --- symlinks ---
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.config"
if [ -d "$HOME/.config/nvim" ] && [ ! -L "$HOME/.config/nvim" ]; then
  # Keep an existing Neovim installation and share the files managed here.
  mkdir -p "$HOME/.config/nvim/lua/plugins"
  link "$DOTFILES/nvim/lua/mappings.lua" "$HOME/.config/nvim/lua/mappings.lua"
  link "$DOTFILES/nvim/lua/plugins/init.lua" "$HOME/.config/nvim/lua/plugins/init.lua"
else
  link "$DOTFILES/nvim" "$HOME/.config/nvim"
fi
link "$DOTFILES/neovide" "$HOME/.config/neovide"

echo "Done. Start a new shell (or 'exec zsh') to pick everything up."
