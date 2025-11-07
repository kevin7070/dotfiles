# ============================================================================
# Docker Compose - Basic Operations
# ============================================================================
alias ddown="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml down -v"
alias dup="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml up -d"
alias drestart="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml restart"
alias dstop="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml stop"
alias dstart="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml start"

# Build operations
alias dbuild="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml build"
alias drebuild="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml build --no-cache"
alias dupbuild="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml up -d --build"

# View operations
alias dps="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml ps"
alias dlogs="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml logs -f"
alias dlogsdj="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml logs -f django"
alias dlogsnuxt="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml logs -f nuxt"
alias dlogsdb="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml logs -f postgres"

# Execute commands in containers
alias dexec="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec"
alias ddjango="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec django"
alias dnuxt="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec nuxt"
alias ddb="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec postgres"

# ============================================================================
# Django-specific shortcuts
# ============================================================================
alias ddjshell="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec django python manage.py shell"
alias ddjmigrate="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec django python manage.py migrate"
alias ddjmakemigrations="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec django python manage.py makemigrations"
alias ddjtest="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec django pytest"
alias ddjcollectstatic="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec django python manage.py collectstatic --noinput"

# ============================================================================
# Database operations
# ============================================================================
alias ddbshell="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec postgres psql -U \${POSTGRES_USER:-postgres} -d \${POSTGRES_DB:-postgres}"
alias ddbbackup="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml exec postgres pg_dump -U \${POSTGRES_USER:-postgres} \${POSTGRES_DB:-postgres} > backup_\$(date +%Y%m%d_%H%M%S).sql"

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
alias dfresh="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml down -v && docker compose --env-file .env.docker.dev -f docker-compose.dev.yml up -d --build"
alias dreload="docker compose --env-file .env.docker.dev -f docker-compose.dev.yml restart django nuxt"

# ============================================================================
# Smart function - Auto-detect compose file
# ============================================================================
dc() {
    local compose_file="docker-compose.dev.yml"
    if [ ! -f "$compose_file" ]; then
        compose_file="docker-compose.yml"
    fi
    docker compose --env-file .env.docker.dev -f "$compose_file" "$@"
}
