# Dotfiles Installation Guide

Complete setup guide for installing and configuring this dotfiles repository on a new computer.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Detailed Installation](#detailed-installation)
- [Font Installation](#font-installation)
- [Post-Installation](#post-installation)
- [Platform-Specific Notes](#platform-specific-notes)
- [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Tools
- **Git** - For cloning the repository
- **Zsh** - Shell (usually pre-installed on macOS/Linux)
- **Kitty Terminal** - Modern GPU-accelerated terminal
- **Tmux** - Terminal multiplexer

### Recommended Tools
- **FiraCode Nerd Font** - Required for proper icon and ligature display
- **Homebrew** (macOS) or package manager (Linux)
- **NVM** - Node Version Manager (optional)
- **Docker** - For Docker Compose shortcuts (optional)

### GitHub Access
Ensure you have SSH keys set up for GitHub access:
```bash
# Generate SSH key if you don't have one
ssh-keygen -t ed25519 -C "your_email@example.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard (macOS)
pbcopy < ~/.ssh/id_ed25519.pub

# Copy public key to clipboard (Linux with xclip)
xclip -selection clipboard < ~/.ssh/id_ed25519.pub

# Then add to GitHub: https://github.com/settings/keys
```

---

## Quick Start

For experienced users who want to get up and running quickly:

```bash
# Install dependencies (choose your platform)
# macOS
brew install kitty tmux git

# Debian/Ubuntu
sudo apt install kitty tmux git

# Fedora
sudo dnf install kitty tmux git

# Arch Linux
sudo pacman -S kitty tmux git

# Install FiraCode Nerd Font (see Font Installation section)

# Clone dotfiles
git clone git@github.com:kevin7070/dotfiles.git ~/dotfiles

# Run automated setup
cd ~/dotfiles
chmod +x setup.sh
./setup.sh

# Restart terminal or source zsh config
source ~/.zshrc
```

---

## Detailed Installation

### Step 1: Install Dependencies

#### macOS
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install kitty tmux git

# Install optional tools
brew install nvm docker
```

#### Debian/Ubuntu
```bash
# Update package list
sudo apt update

# Install required tools
sudo apt install kitty tmux git zsh

# Install optional tools
sudo apt install curl wget
```

#### Fedora
```bash
# Install required tools
sudo dnf install kitty tmux git zsh

# Install optional tools
sudo dnf install curl wget
```

#### Arch Linux
```bash
# Install required tools
sudo pacman -S kitty tmux git zsh

# Install optional tools (AUR)
yay -S nvm
```

### Step 2: Clone Dotfiles Repository

```bash
# Clone to home directory
git clone git@github.com:kevin7070/dotfiles.git ~/dotfiles

# Navigate to dotfiles
cd ~/dotfiles
```

### Step 3: Run Automated Setup

The setup script will:
- Check for required dependencies
- Offer to install missing tools
- Backup existing configuration files
- Create necessary symlinks
- Set up Tmux Plugin Manager
- Configure directory structure

```bash
# Make script executable
chmod +x setup.sh

# Run setup (interactive)
./setup.sh

# Or run with dry-run to see what it would do
./setup.sh --dry-run
```

### Step 4: Manual Setup (Alternative)

If you prefer manual setup:

```bash
# Create necessary directories
mkdir -p ~/.config/kitty
mkdir -p ~/.config/zsh

# Create symlinks
ln -sf ~/dotfiles/kitty/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/zsh/.custom.zsh ~/.custom.zsh

# Copy entire zsh config directory (or symlink the directory)
cp -r ~/dotfiles/zsh/.config/zsh/* ~/.config/zsh/
# OR
ln -sf ~/dotfiles/zsh/.config/zsh ~/.config/zsh

# Clone TPM (Tmux Plugin Manager)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

---

## Font Installation

### Why FiraCode Nerd Font?
- Programming ligatures (->  ==  >=)
- Rich icon set for terminal applications
- Excellent readability
- Required by the kitty configuration

### macOS Installation

#### Method 1: Homebrew Cask
```bash
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
```

#### Method 2: Manual
```bash
# Download from Nerd Fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip

# Create fonts directory
mkdir -p ~/Library/Fonts/NerdFonts

# Unzip and move
unzip FiraCode.zip -d ~/Library/Fonts/NerdFonts/
rm FiraCode.zip

# Fonts are automatically available after installation
```

### Linux Installation

#### Debian/Ubuntu
```bash
# Download font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip
rm FiraCode.zip

# Refresh font cache
fc-cache -fv
```

#### Fedora
```bash
# Using COPR repository
sudo dnf copr enable peterwu/iosevka
sudo dnf install fira-code-fonts

# Or manual installation (same as Debian method above)
```

#### Arch Linux
```bash
# Using pacman (community repo)
sudo pacman -S ttf-firacode-nerd

# Or using AUR
yay -S nerd-fonts-fira-code
```

### Verify Font Installation
```bash
# List installed Nerd Fonts
fc-list | grep -i "fira.*nerd"

# Should show multiple weights of FiraCode Nerd Font
```

---

## Post-Installation

### 1. Configure Zsh to Load Custom Config

Add this to your `~/.zshrc` if not already present:

```bash
# Load custom zsh configuration
[ -f ~/.custom.zsh ] && source ~/.custom.zsh
```

### 2. Install Tmux Plugins

```bash
# Start tmux
tmux

# Press prefix + I (that's Ctrl+s then Shift+I by default)
# Wait for plugins to install

# Or run manually
~/.tmux/plugins/tpm/bin/install_plugins
```

### 3. Restart Terminal

```bash
# Restart kitty or source config
source ~/.zshrc

# Or quit and restart terminal application
```

### 4. Verify Kitty Configuration

```bash
# Check if kitty config is loaded
kitty --debug-config

# Test theme switching
~/.config/kitty/switch-theme.sh

# Try keyboard shortcut: Cmd+Shift+T (macOS)
```

### 5. Test Tmux

```bash
# Start tmux
tmux

# Test prefix (should be Ctrl+s, not default Ctrl+b)
# Create new window: Ctrl+s then c
# Split pane: Ctrl+s then | or -

# Exit tmux
exit
```

---

## Platform-Specific Notes

### macOS

**Keybindings:**
- Kitty uses `Cmd` key for all shortcuts
- No conflicts with tmux (`Ctrl+s` prefix)

**Clipboard:**
- Uses `pbcopy`/`pbpaste` automatically
- Copy-on-select enabled in kitty

**Paths:**
- Homebrew: `/opt/homebrew/bin` (Apple Silicon) or `/usr/local/bin` (Intel)
- NVM: Installed via Homebrew formula

**Additional Setup:**
```bash
# Add Homebrew to PATH (Apple Silicon)
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Linux (Debian/Ubuntu)

**Keybindings:**
- May need to adjust kitty shortcuts from `Cmd` to `Alt` or `Ctrl`
- Edit `~/.config/kitty/kitty.conf` and replace `cmd+` with `alt+` or `ctrl+shift+`

**Clipboard:**
- X11: Uses `xclip` or `xsel`
- Wayland: Uses `wl-copy`/`wl-paste`

**Install clipboard tools:**
```bash
# For X11
sudo apt install xclip

# For Wayland
sudo apt install wl-clipboard
```

### Linux (Fedora)

**Similar to Debian** with some differences:

```bash
# SELinux may interfere with some operations
# Check SELinux status
sestatus

# If issues occur, check audit logs
sudo ausearch -m avc -ts recent
```

### Linux (Arch)

**Rolling release considerations:**
- Packages are usually very up-to-date
- May encounter bleeding-edge bugs
- AUR packages available for most tools

---

## Troubleshooting

### Kitty Not Finding Font

**Problem:** Kitty shows wrong font or icons don't display

**Solution:**
```bash
# Verify font installation
fc-list | grep -i "fira.*nerd"

# Check kitty font configuration
kitty --debug-font-fallback

# Manually specify font in kitty.conf
font_family FiraCode Nerd Font Mono
```

### Tmux Prefix Not Working

**Problem:** Tmux not responding to `Ctrl+s`

**Solution:**
```bash
# Check if config is loaded
tmux show-options -g | grep prefix

# Manually reload config in tmux
# Press: Ctrl+s then :
# Type: source-file ~/.tmux.conf

# Or restart tmux server
tmux kill-server
tmux
```

### Zsh Custom Config Not Loading

**Problem:** Aliases and functions not available

**Solution:**
```bash
# Check if .custom.zsh is sourced in .zshrc
grep "custom.zsh" ~/.zshrc

# Add if missing
echo '[ -f ~/.custom.zsh ] && source ~/.custom.zsh' >> ~/.zshrc

# Verify symlink
ls -la ~/.custom.zsh

# Check zsh config directory
ls -la ~/.config/zsh/
```

### Permission Denied Errors

**Problem:** Cannot create symlinks or write to directories

**Solution:**
```bash
# Ensure proper ownership of home directory
sudo chown -R $USER:$USER ~/dotfiles

# Check directory permissions
ls -la ~/
ls -la ~/.config/

# Create config directory if missing
mkdir -p ~/.config
```

### Kitty Theme Not Loading

**Problem:** Theme colors not appearing correctly

**Solution:**
```bash
# Check if theme file exists
ls ~/.config/kitty/themes/

# Verify include statement in kitty.conf
grep "include" ~/.config/kitty/kitty.conf

# Reload kitty config
# Press: Cmd+Shift+R (macOS) or Ctrl+Shift+F5 (Linux)

# Or restart kitty
```

### NVM Not Found

**Problem:** `nvm` command not available after installation

**Solution:**
```bash
# macOS (Homebrew)
# Add to .zshrc
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Linux (manual install)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Reload shell
source ~/.zshrc
```

---

## Additional Resources

- **Kitty Terminal:** https://sw.kovidgoyal.net/kitty/
- **Tmux:** https://github.com/tmux/tmux/wiki
- **Nerd Fonts:** https://www.nerdfonts.com/
- **Kitty Setup Guide:** See `kitty/.config/kitty/SETUP.md`
- **Kitty Usage:** See `kitty/.config/kitty/README.md`

---

## Updating Dotfiles

To pull the latest changes:

```bash
cd ~/dotfiles
git pull origin main

# If configs changed, reload them
source ~/.zshrc  # For zsh
tmux source-file ~/.tmux.conf  # For tmux (inside tmux)
# Press Cmd+Shift+R in kitty to reload
```

---

## Uninstallation

To remove dotfiles configuration:

```bash
# Remove symlinks
rm ~/.config/kitty/kitty.conf
rm ~/.tmux.conf
rm ~/.custom.zsh

# Remove cloned repository
rm -rf ~/dotfiles

# Remove TPM
rm -rf ~/.tmux/plugins

# Remove zsh config (if copied)
rm -rf ~/.config/zsh
```

---

**Last Updated:** 2025-11-06
**Repository:** https://github.com/kevin7070/dotfiles
