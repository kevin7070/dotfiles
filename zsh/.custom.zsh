# load customs
# [ -f ~/.custom.zsh ] && source ~/.custom.zsh

if [[ "$(uname)" == "Darwin" ]]; then
    # macOS 設定
    # 
    # Paths
    export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"  # brew
    export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"  # openjdk
    export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"  #postgresql

    # Searching and File Management
    alias ff="fzf --exit-0 | xargs -r nvim"
    fd() {
    local dir
    dir=$(find . -type d | fzf) && cd "$dir"
    }

    # File & Directory Navigation
    alias h="history"
    alias mv="mv -i"  # Prevent overwriting
    alias cp="cp -i"  # Prevent overwriting
    alias rm="rm -i"  # Confirm before deleting
    alias o="open ."  # Open current directory in Finder (macOS)

    # tree
    alias t="tree -C"
    alias ta="tree -a -C"
    alias ts="tree -shC"
    alias td="tree -d -C"
    alias t2="tree -L 2 -C"
    alias t3="tree -L 3 -C"
    alias t4="tree -L 4 -C"
    alias t5="tree -L 5 -C"
    alias t6="tree -L 6 -C"
    alias t7="tree -L 7 -C"
    alias t8="tree -L 8 -C"

    # lazygit
    alias lg="rm -rf .git/index.lock && lazygit"

    # Pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init - zsh)"

    # fzf
    export FZF_DEFAULT_COMMAND='find . -type f'
    export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

    # Nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    # zoxide
    eval "$(zoxide init zsh)"
    alias ls="eza --icons"

    # Tmux
    export TMUX_COPY_CMD="pbcopy"
elif [[ "$(uname)" == "Linux" ]]; then
    # Linux 設定
    #
    # Arch news
    alias news="curl -s https://archlinux.org/news/ | lynx -stdin"
    
    # Searching and File Management
    alias ff="fzf --exit-0 | xargs -r nvim"  # Use fzf to open files in nvim
    fd() {
        local dir
        dir=$(find . -type d | fzf) && cd "$dir"
    }

    # alias
    alias h="history"
    alias mv="mv -i"
    alias cp="cp -i"
    alias rm="rm -i"
    alias o="xdg-open ."

    # tree
    alias t="tree -C"
    alias ta="tree -a -C"
    alias ts="tree -shC"
    alias td="tree -d -C"
    alias t2="tree -L 2 -C"
    alias t3="tree -L 3 -C"
    alias t4="tree -L 4 -C"
    alias t5="tree -L 5 -C"
    alias t6="tree -L 6 -C"
    alias t7="tree -L 7 -C"
    alias t8="tree -L 8 -C"

    # lazygit
    alias lg="rm -rf .git/index.lock && lazygit"

    # zoxide
    eval "$(zoxide init zsh)"
    alias ls="eza --icons"

    # nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    # fzf
    export FZF_DEFAULT_COMMAND='find . -type f'
    export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border'

    # pyenv
    export PYENV_ROOT="$HOME/.pyenv"
    [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init - zsh)"

    # Tmux (Wayland) wl-clipboard package needed
    if command -v wl-copy &> /dev/null; then
        export TMUX_COPY_CMD="wl-copy"
    fi
fi
