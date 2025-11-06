# ============================================================================
# Modular ZSH Configuration
# ============================================================================
# This is the main entry point that loads platform-specific and common configs
#
# Structure:
# - common/    : Shared configurations for all platforms
# - platform/  : Platform-specific configurations (macOS/Linux)
# ============================================================================

# Determine the config directory
ZSH_CUSTOM_DIR="${0:a:h}"

# Load common configurations (shared across all platforms)
source "${ZSH_CUSTOM_DIR}/common/docker.zsh"
source "${ZSH_CUSTOM_DIR}/common/dev-tools.zsh"
source "${ZSH_CUSTOM_DIR}/common/file-nav.zsh"
source "${ZSH_CUSTOM_DIR}/common/tree.zsh"

# Load platform-specific configurations
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS configuration
    source "${ZSH_CUSTOM_DIR}/platform/macos.zsh"
elif [[ "$(uname)" == "Linux" ]]; then
    # Linux configuration
    source "${ZSH_CUSTOM_DIR}/platform/linux.zsh"
fi
