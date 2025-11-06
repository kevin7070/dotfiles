# ============================================================================
# Linux-specific Configuration
# ============================================================================

# Arch news (Arch Linux specific)
alias news="curl -s https://archlinux.org/news/ | lynx -stdin"

# Open current directory with default file manager
alias o="xdg-open ."

# Nvm (standard installation)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Tmux - Use wl-copy for clipboard (Wayland)
if command -v wl-copy &> /dev/null; then
    export TMUX_COPY_CMD="wl-copy"
fi

# Launch VSCode with Electron Workarounds
alias code="code --ozone-platform-hint=auto --disable-gpu 2>/dev/null"
