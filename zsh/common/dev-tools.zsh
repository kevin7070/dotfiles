# ============================================================================
# Development Tools Configuration
# ============================================================================

# fzf - Fuzzy finder
export FZF_DEFAULT_COMMAND='find . -type f'
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

# Pyenv - Python version management
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init - zsh)"

# zoxide - Smart directory jumper
eval "$(zoxide init zsh)"

# eza - Modern ls replacement
alias ls="eza --icons"
