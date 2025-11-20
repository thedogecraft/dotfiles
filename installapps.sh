#!/bin/bash
set -e

read -rp "Enter your Git username: " git_username
read -rp "Enter your Git email: " git_email

# Update system
sudo pacman -Syu --noconfirm

# Install essential build tools and utilities
sudo pacman -S --noconfirm base-devel curl wget git zsh unzip

# Git config
git config --global user.name "$git_username"
git config --global user.email "$git_email"

# Install Node.js (LTS) and npm
sudo pacman -S --noconfirm nodejs npm

# Install Docker and enable service
sudo pacman -S --noconfirm docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Install VSCodium (community edition code OSS)
if ! command -v codium &> /dev/null; then
  sudo pacman -S --noconfirm --needed git base-devel
  if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
  fi
  yay -S --noconfirm codium
fi

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Change default shell to zsh
chsh -s "$(which zsh)" $USER

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
fi

# Set ZSH_THEME="powerlevel10k/powerlevel10k" in .zshrc (replace if exists)
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$HOME/.zshrc"

# Install zsh-autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
fi

# Enable zsh-autosuggestions plugin in .zshrc if not enabled
if ! grep -q "zsh-autosuggestions" "$HOME/.zshrc"; then
  sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-autosuggestions)/' "$HOME/.zshrc"
fi

# Install Astral UV
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install Hack Nerd Font
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"
cd "$FONT_DIR"
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
unzip -q Hack.zip
rm Hack.zip
fc-cache -fv

echo "Setup complete! Please log out and log back in to apply docker group changes."
