# ============================================================================
# File Navigation and Management
# ============================================================================

# Searching and File Management
alias ffile="fzf --exit-0 | xargs -r nvim"

fdir() {
    local dir
    dir=$(find . -type d | fzf) && cd "$dir"
}

# File & Directory Navigation
alias h="history"
alias mv="mv -i"  # Prevent overwriting
alias cp="cp -i"  # Prevent overwriting
alias rm="rm -i"  # Confirm before deleting
