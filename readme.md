# arch dev setup

This script automates the setup of a basic development environment for Arch Linux. It installs essential tools, configures the shell, and sets up useful utilities for development.

## What It Does

- Updates the system packages.
- Installs essential build tools and utilities: `base-devel`, `curl`, `wget`, `git`, `zsh`, and `unzip`.
- Configures global Git username and email.
- Installs Node.js (LTS) and npm.
- Installs and enables Docker, adding the current user to the Docker group.
- Installs **VSCodium** (the open-source build of VS Code) from the AUR.
- Installs **Oh My Zsh** if not present.
- Sets `zsh` as the default shell.
- Installs the **Powerlevel10k** theme for Zsh.
- Installs and enables the `zsh-autosuggestions` plugin.
- Installs Astral UV CLI tool.
- Installs the **Hack Nerd Font** for improved terminal font rendering.
- Reminds the user to log out and back in for Docker group changes to take effect.

## Usage

Make the script executable and run it:

```bash
chmod +x setup.sh
./setup.sh
