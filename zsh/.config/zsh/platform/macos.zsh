# ============================================================================
# macOS-specific Configuration
# ============================================================================

# Paths
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"  # brew
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"  # openjdk
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"  # postgresql

# Open current directory in Finder
alias o="open ."

# Nvm (Homebrew installation)
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

# Tmux - Use pbcopy for clipboard
export TMUX_COPY_CMD="pbcopy"
