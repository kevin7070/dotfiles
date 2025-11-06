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
