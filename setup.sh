#!/usr/bin/env bash
#
# Dotfiles Setup Script
# Automated installation and configuration for dotfiles
#
# Usage:
#   ./setup.sh              Run interactive setup
#   ./setup.sh --dry-run    Show what would be done without making changes
#   ./setup.sh --force      Skip confirmations and force installation
#   ./setup.sh --help       Show this help message

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
DRY_RUN=false
FORCE=false

# Detect platform
detect_platform() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        PLATFORM="macos"
        PACKAGE_MANAGER="brew"
    elif [[ -f /etc/debian_version ]]; then
        PLATFORM="debian"
        PACKAGE_MANAGER="apt"
    elif [[ -f /etc/fedora-release ]]; then
        PLATFORM="fedora"
        PACKAGE_MANAGER="dnf"
    elif [[ -f /etc/arch-release ]]; then
        PLATFORM="arch"
        PACKAGE_MANAGER="pacman"
    else
        PLATFORM="unknown"
        PACKAGE_MANAGER="unknown"
    fi
}

# Print functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
    echo ""
}

# Help message
show_help() {
    cat << EOF
Dotfiles Setup Script

Usage:
    ./setup.sh              Run interactive setup
    ./setup.sh --dry-run    Show what would be done without making changes
    ./setup.sh --force      Skip confirmations and force installation
    ./setup.sh --help       Show this help message

This script will:
    - Detect your operating system and platform
    - Check for required dependencies
    - Offer to install missing dependencies
    - Backup existing configuration files
    - Create symlinks to dotfiles
    - Set up Tmux Plugin Manager
    - Configure directory structure

EOF
}

# Check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Ask for confirmation
confirm() {
    if [[ "$FORCE" == true ]]; then
        return 0
    fi

    local message="$1"
    read -p "$message [y/N] " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]]
}

# Create backup of existing file
backup_file() {
    local file="$1"
    if [[ -e "$file" ]] && [[ ! -L "$file" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            print_info "Would backup: $file"
        else
            mkdir -p "$BACKUP_DIR"
            cp -r "$file" "$BACKUP_DIR/"
            print_success "Backed up: $file"
        fi
    fi
}

# Create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    if [[ "$DRY_RUN" == true ]]; then
        print_info "Would create symlink: $target -> $source"
        return
    fi

    # Backup existing file/directory
    if [[ -e "$target" ]] && [[ ! -L "$target" ]]; then
        backup_file "$target"
        rm -rf "$target"
    elif [[ -L "$target" ]]; then
        # Remove existing symlink
        rm "$target"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"

    # Create symlink
    ln -sf "$source" "$target"
    print_success "Created symlink: $target -> $source"
}

# Check dependencies
check_dependencies() {
    print_header "Checking Dependencies"

    local missing_deps=()

    # Required dependencies
    local required=("git" "zsh" "kitty" "tmux")

    for dep in "${required[@]}"; do
        if command_exists "$dep"; then
            print_success "$dep is installed"
        else
            print_warning "$dep is NOT installed"
            missing_deps+=("$dep")
        fi
    done

    # Check for font (best effort)
    if [[ "$PLATFORM" == "macos" ]]; then
        if ls ~/Library/Fonts/NerdFonts/*FiraCode* >/dev/null 2>&1 || \
           ls ~/Library/Fonts/*FiraCode*Nerd* >/dev/null 2>&1; then
            print_success "FiraCode Nerd Font is installed"
        else
            print_warning "FiraCode Nerd Font is NOT installed"
            missing_deps+=("font-fira-code-nerd-font")
        fi
    else
        if fc-list | grep -i "fira.*nerd" >/dev/null 2>&1; then
            print_success "FiraCode Nerd Font is installed"
        else
            print_warning "FiraCode Nerd Font is NOT installed"
            missing_deps+=("firacode-nerd-font")
        fi
    fi

    # Return list of missing dependencies
    echo "${missing_deps[@]}"
}

# Install dependencies
install_dependencies() {
    local deps=("$@")

    if [[ ${#deps[@]} -eq 0 ]]; then
        print_info "No missing dependencies to install"
        return
    fi

    print_header "Installing Missing Dependencies"

    if [[ "$DRY_RUN" == true ]]; then
        print_info "Would install: ${deps[*]}"
        return
    fi

    if ! confirm "Install missing dependencies: ${deps[*]}?"; then
        print_warning "Skipping dependency installation"
        return
    fi

    case "$PLATFORM" in
        macos)
            if ! command_exists brew; then
                print_error "Homebrew not found. Please install: https://brew.sh"
                exit 1
            fi

            for dep in "${deps[@]}"; do
                if [[ "$dep" == "font-fira-code-nerd-font" ]]; then
                    brew tap homebrew/cask-fonts 2>/dev/null || true
                    brew install --cask font-fira-code-nerd-font
                else
                    brew install "$dep"
                fi
            done
            ;;

        debian)
            for dep in "${deps[@]}"; do
                if [[ "$dep" == "firacode-nerd-font" ]]; then
                    print_info "Installing FiraCode Nerd Font manually..."
                    mkdir -p ~/.local/share/fonts
                    cd ~/.local/share/fonts
                    curl -fLo "FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
                    unzip -o FiraCode.zip
                    rm FiraCode.zip
                    fc-cache -fv
                else
                    sudo apt update
                    sudo apt install -y "$dep"
                fi
            done
            ;;

        fedora)
            for dep in "${deps[@]}"; do
                if [[ "$dep" == "firacode-nerd-font" ]]; then
                    print_info "Installing FiraCode Nerd Font manually..."
                    mkdir -p ~/.local/share/fonts
                    cd ~/.local/share/fonts
                    curl -fLo "FiraCode.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
                    unzip -o FiraCode.zip
                    rm FiraCode.zip
                    fc-cache -fv
                else
                    sudo dnf install -y "$dep"
                fi
            done
            ;;

        arch)
            for dep in "${deps[@]}"; do
                if [[ "$dep" == "firacode-nerd-font" ]]; then
                    if command_exists yay; then
                        yay -S --noconfirm ttf-firacode-nerd
                    elif command_exists paru; then
                        paru -S --noconfirm ttf-firacode-nerd
                    else
                        print_warning "Install AUR helper (yay/paru) or manually install ttf-firacode-nerd"
                    fi
                else
                    sudo pacman -S --noconfirm "$dep"
                fi
            done
            ;;

        *)
            print_error "Unknown platform. Please install dependencies manually:"
            echo "${deps[*]}"
            ;;
    esac

    print_success "Dependencies installed"
}

# Setup kitty configuration
setup_kitty() {
    print_header "Setting Up Kitty Configuration"

    local kitty_config_dir="$HOME/.config/kitty"
    local source_dir="$DOTFILES_DIR/kitty/.config/kitty"

    # Create kitty config directory
    if [[ "$DRY_RUN" == false ]]; then
        mkdir -p "$kitty_config_dir"
    fi

    # Symlink main config
    create_symlink "$source_dir/kitty.conf" "$kitty_config_dir/kitty.conf"

    # Copy or symlink themes directory
    if [[ -d "$source_dir/themes" ]]; then
        if [[ -d "$kitty_config_dir/themes" ]] && [[ ! -L "$kitty_config_dir/themes" ]]; then
            backup_file "$kitty_config_dir/themes"
        fi
        create_symlink "$source_dir/themes" "$kitty_config_dir/themes"
    fi

    # Copy scripts
    if [[ -f "$source_dir/switch-theme.sh" ]]; then
        create_symlink "$source_dir/switch-theme.sh" "$kitty_config_dir/switch-theme.sh"
        if [[ "$DRY_RUN" == false ]]; then
            chmod +x "$kitty_config_dir/switch-theme.sh"
        fi
    fi

    print_success "Kitty configuration set up"
}

# Setup tmux configuration
setup_tmux() {
    print_header "Setting Up Tmux Configuration"

    local source_file="$DOTFILES_DIR/tmux/.tmux.conf"
    local target_file="$HOME/.tmux.conf"

    create_symlink "$source_file" "$target_file"

    # Setup TPM (Tmux Plugin Manager)
    local tpm_dir="$HOME/.tmux/plugins/tpm"

    if [[ ! -d "$tpm_dir" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            print_info "Would clone TPM to $tpm_dir"
        else
            if confirm "Clone Tmux Plugin Manager (TPM)?"; then
                git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
                print_success "TPM installed to $tpm_dir"
                print_info "Run 'prefix + I' in tmux to install plugins"
            fi
        fi
    else
        print_info "TPM already installed"
    fi

    print_success "Tmux configuration set up"
}

# Setup zsh configuration
setup_zsh() {
    print_header "Setting Up Zsh Configuration"

    local source_file="$DOTFILES_DIR/zsh/.custom.zsh"
    local target_file="$HOME/.custom.zsh"
    local source_config_dir="$DOTFILES_DIR/zsh/.config/zsh"
    local target_config_dir="$HOME/.config/zsh"

    # Symlink .custom.zsh
    create_symlink "$source_file" "$target_file"

    # Symlink entire .config/zsh directory
    if [[ -d "$source_config_dir" ]]; then
        if [[ -d "$target_config_dir" ]] && [[ ! -L "$target_config_dir" ]]; then
            backup_file "$target_config_dir"
        fi
        create_symlink "$source_config_dir" "$target_config_dir"
    fi

    # Check if .zshrc sources .custom.zsh
    local zshrc="$HOME/.zshrc"
    if [[ -f "$zshrc" ]]; then
        if grep -q "custom.zsh" "$zshrc"; then
            print_info ".zshrc already sources .custom.zsh"
        else
            if [[ "$DRY_RUN" == false ]]; then
                if confirm "Add .custom.zsh to .zshrc?"; then
                    echo "" >> "$zshrc"
                    echo "# Load custom zsh configuration" >> "$zshrc"
                    echo '[ -f ~/.custom.zsh ] && source ~/.custom.zsh' >> "$zshrc"
                    print_success "Added .custom.zsh to .zshrc"
                fi
            else
                print_info "Would add .custom.zsh to .zshrc"
            fi
        fi
    else
        print_warning ".zshrc not found. Create it and add:"
        echo '[ -f ~/.custom.zsh ] && source ~/.custom.zsh'
    fi

    print_success "Zsh configuration set up"
}

# Post-installation summary
print_summary() {
    print_header "Setup Complete!"

    echo "Dotfiles have been successfully set up."
    echo ""
    echo "Next steps:"
    echo ""
    echo "1. Restart your terminal or source zsh config:"
    echo "   source ~/.zshrc"
    echo ""
    echo "2. Install tmux plugins (if using tmux):"
    echo "   - Start tmux: tmux"
    echo "   - Press: Ctrl+s then Shift+I"
    echo "   - Or run: ~/.tmux/plugins/tpm/bin/install_plugins"
    echo ""
    echo "3. Try switching kitty themes:"
    echo "   ~/.config/kitty/switch-theme.sh"
    echo "   OR press: Cmd+Shift+T (macOS) / Ctrl+Shift+T (Linux)"
    echo ""
    echo "4. Verify kitty configuration:"
    echo "   kitty --debug-config"
    echo ""
    echo "5. Read the documentation:"
    echo "   - Main guide: $DOTFILES_DIR/INSTALL.md"
    echo "   - Kitty setup: $DOTFILES_DIR/kitty/.config/kitty/SETUP.md"
    echo "   - Kitty usage: $DOTFILES_DIR/kitty/.config/kitty/README.md"
    echo ""

    if [[ -d "$BACKUP_DIR" ]]; then
        echo "Backups saved to: $BACKUP_DIR"
        echo ""
    fi

    print_success "Enjoy your new dotfiles!"
}

# Main setup function
main() {
    # Parse arguments
    for arg in "$@"; do
        case $arg in
            --dry-run)
                DRY_RUN=true
                print_warning "DRY RUN MODE - No changes will be made"
                ;;
            --force)
                FORCE=true
                print_warning "FORCE MODE - Skipping confirmations"
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                print_error "Unknown option: $arg"
                show_help
                exit 1
                ;;
        esac
    done

    # Detect platform
    detect_platform
    print_info "Platform: $PLATFORM"
    print_info "Package Manager: $PACKAGE_MANAGER"
    echo ""

    # Check if running from dotfiles directory
    if [[ ! -d "$DOTFILES_DIR" ]]; then
        print_error "Dotfiles directory not found at $DOTFILES_DIR"
        print_error "Please clone the repository first:"
        echo "  git clone git@github.com:kevin7070/dotfiles.git ~/dotfiles"
        exit 1
    fi

    # Check dependencies
    local missing_deps=($(check_dependencies))

    # Install missing dependencies
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        install_dependencies "${missing_deps[@]}"
    fi

    # Setup configurations
    setup_kitty
    setup_tmux
    setup_zsh

    # Print summary
    if [[ "$DRY_RUN" == false ]]; then
        print_summary
    else
        print_info "Dry run complete. Run without --dry-run to apply changes."
    fi
}

# Run main function
main "$@"
