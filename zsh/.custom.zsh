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
    alias o="open ."  # Open current directory in Finder (macOS)

    # ============================================================================
    # Docker Compose - Basic Operations
    # ============================================================================
    alias dcdown="docker compose -f docker-compose.dev.yml down -v"
    alias dcup="docker compose -f docker-compose.dev.yml up -d"
    alias dcrestart="docker compose -f docker-compose.dev.yml restart"
    alias dcstop="docker compose -f docker-compose.dev.yml stop"
    alias dcstart="docker compose -f docker-compose.dev.yml start"

    # Build operations
    alias dcbuild="docker compose -f docker-compose.dev.yml build"
    alias dcrebuild="docker compose -f docker-compose.dev.yml build --no-cache"
    alias dcupbuild="docker compose -f docker-compose.dev.yml up -d --build"

    # View operations
    alias dcps="docker compose -f docker-compose.dev.yml ps"
    alias dclogs="docker compose -f docker-compose.dev.yml logs -f"
    alias dclogsdj="docker compose -f docker-compose.dev.yml logs -f django"
    alias dclogsnuxt="docker compose -f docker-compose.dev.yml logs -f nuxt"
    alias dclogsdb="docker compose -f docker-compose.dev.yml logs -f postgres"

    # Execute commands in containers
    alias dcexec="docker compose -f docker-compose.dev.yml exec"
    alias dcdjango="docker compose -f docker-compose.dev.yml exec django"
    alias dcnuxt="docker compose -f docker-compose.dev.yml exec nuxt"
    alias dcdb="docker compose -f docker-compose.dev.yml exec postgres"

    # ============================================================================
    # Django-specific shortcuts
    # ============================================================================
    alias dcdjshell="docker compose -f docker-compose.dev.yml exec django python manage.py shell"
    alias dcdjmigrate="docker compose -f docker-compose.dev.yml exec django python manage.py migrate"
    alias dcdjmakemigrations="docker compose -f docker-compose.dev.yml exec django python manage.py makemigrations"
    alias dcdjtest="docker compose -f docker-compose.dev.yml exec django pytest"
    alias dcdjcollectstatic="docker compose -f docker-compose.dev.yml exec django python manage.py collectstatic --noinput"

    # ============================================================================
    # Database operations
    # ============================================================================
    alias dcdbshell="docker compose -f docker-compose.dev.yml exec postgres psql -U \${POSTGRES_USER:-postgres} -d \${POSTGRES_DB:-postgres}"
    alias dcdbbackup="docker compose -f docker-compose.dev.yml exec postgres pg_dump -U \${POSTGRES_USER:-postgres} \${POSTGRES_DB:-postgres} > backup_\$(date +%Y%m%d_%H%M%S).sql"

    # ============================================================================
    # Docker system management
    # ============================================================================
    alias dps="docker ps"
    alias dpsa="docker ps -a"
    alias dimg="docker images"
    alias dsystem="docker system df"

    # ============================================================================
    # Quick actions
    # ============================================================================
    alias dcfresh="docker compose -f docker-compose.dev.yml down -v && docker compose -f docker-compose.dev.yml up -d --build"
    alias dcreload="docker compose -f docker-compose.dev.yml restart django nuxt"

    # ============================================================================
    # Smart function - Auto-detect compose file
    # ============================================================================
    dc() {
        local compose_file="docker-compose.dev.yml"
        if [ ! -f "$compose_file" ]; then
            compose_file="docker-compose.yml"
        fi
        docker compose -f "$compose_file" "$@"
    }

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
    alias trepo="git ls-files --cached --others --exclude-standard | tree --fromfile"

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
    alias ffile="fzf --exit-0 | xargs -r nvim"  # Use fzf to open files in nvim
    fdir() {
        local dir
        dir=$(find . -type d | fzf) && cd "$dir"
    }

    # alias
    alias h="history"
    alias mv="mv -i"
    alias cp="cp -i"
    alias rm="rm -i"
    alias o="xdg-open ."

    # ============================================================================
    # Docker Compose - Basic Operations
    # ============================================================================
    alias dcdown="docker compose -f docker-compose.dev.yml down -v"
    alias dcup="docker compose -f docker-compose.dev.yml up -d"
    alias dcrestart="docker compose -f docker-compose.dev.yml restart"
    alias dcstop="docker compose -f docker-compose.dev.yml stop"
    alias dcstart="docker compose -f docker-compose.dev.yml start"

    # Build operations
    alias dcbuild="docker compose -f docker-compose.dev.yml build"
    alias dcrebuild="docker compose -f docker-compose.dev.yml build --no-cache"
    alias dcupbuild="docker compose -f docker-compose.dev.yml up -d --build"

    # View operations
    alias dcps="docker compose -f docker-compose.dev.yml ps"
    alias dclogs="docker compose -f docker-compose.dev.yml logs -f"
    alias dclogsdj="docker compose -f docker-compose.dev.yml logs -f django"
    alias dclogsnuxt="docker compose -f docker-compose.dev.yml logs -f nuxt"
    alias dclogsdb="docker compose -f docker-compose.dev.yml logs -f postgres"

    # Execute commands in containers
    alias dcexec="docker compose -f docker-compose.dev.yml exec"
    alias dcdjango="docker compose -f docker-compose.dev.yml exec django"
    alias dcnuxt="docker compose -f docker-compose.dev.yml exec nuxt"
    alias dcdb="docker compose -f docker-compose.dev.yml exec postgres"

    # ============================================================================
    # Django-specific shortcuts
    # ============================================================================
    alias dcdjshell="docker compose -f docker-compose.dev.yml exec django python manage.py shell"
    alias dcdjmigrate="docker compose -f docker-compose.dev.yml exec django python manage.py migrate"
    alias dcdjmakemigrations="docker compose -f docker-compose.dev.yml exec django python manage.py makemigrations"
    alias dcdjtest="docker compose -f docker-compose.dev.yml exec django pytest"
    alias dcdjcollectstatic="docker compose -f docker-compose.dev.yml exec django python manage.py collectstatic --noinput"

    # ============================================================================
    # Database operations
    # ============================================================================
    alias dcdbshell="docker compose -f docker-compose.dev.yml exec postgres psql -U \${POSTGRES_USER:-postgres} -d \${POSTGRES_DB:-postgres}"
    alias dcdbbackup="docker compose -f docker-compose.dev.yml exec postgres pg_dump -U \${POSTGRES_USER:-postgres} \${POSTGRES_DB:-postgres} > backup_\$(date +%Y%m%d_%H%M%S).sql"

    # ============================================================================
    # Docker system management
    # ============================================================================
    alias dps="docker ps"
    alias dpsa="docker ps -a"
    alias dimg="docker images"
    alias dsystem="docker system df"

    # ============================================================================
    # Quick actions
    # ============================================================================
    alias dcfresh="docker compose -f docker-compose.dev.yml down -v && docker compose -f docker-compose.dev.yml up -d --build"
    alias dcreload="docker compose -f docker-compose.dev.yml restart django nuxt"

    # ============================================================================
    # Smart function - Auto-detect compose file
    # ============================================================================
    dc() {
        local compose_file="docker-compose.dev.yml"
        if [ ! -f "$compose_file" ]; then
            compose_file="docker-compose.yml"
        fi
        docker compose -f "$compose_file" "$@"
    }

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
    alias trepo="git ls-files --cached --others --exclude-standard | tree --fromfile"

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

    # Launch VSCode with Electron Workarounds
    alias code="code --ozone-platform-hint=auto --disable-gpu 2>/dev/null"
fi
