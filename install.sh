#!/usr/bin/env bash

# Dotfiles Installation Script
# Installs and configures personal dotfiles for Hyprland environment

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
CONFIG_DIR="$HOME/.config"

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on supported system
check_system() {
    log_info "Checking system compatibility..."
    
    if [[ "$OSTYPE" != "linux-gnu"* ]]; then
        log_error "This script is designed for Linux systems only."
        exit 1
    fi
    
    # Check if we're in a directory with dotfiles
    if [[ ! -d "$DOTFILES_DIR/hypr" ]] || [[ ! -d "$DOTFILES_DIR/nvim" ]]; then
        log_error "This doesn't appear to be a valid dotfiles directory."
        log_error "Expected directories: hypr/, nvim/, kitty/, zsh/"
        exit 1
    fi
    
    log_success "System check passed"
}

# Create backup of existing configurations
backup_existing_configs() {
    log_info "Creating backup of existing configurations..."
    
    mkdir -p "$BACKUP_DIR"
    
    # List of config directories to backup
    local configs=("hypr" "nvim" "kitty" "rofi" "mako" "ranger" "zathura" "mpv" "gtk-3.0" "gtk-4.0")
    local home_configs=(".zshrc" ".zshenv" ".zprofile")
    
    # Backup .config directories
    for config in "${configs[@]}"; do
        if [[ -d "$CONFIG_DIR/$config" ]]; then
            log_info "Backing up $CONFIG_DIR/$config"
            cp -r "$CONFIG_DIR/$config" "$BACKUP_DIR/"
        fi
    done
    
    # Backup home directory configs
    for config in "${home_configs[@]}"; do
        if [[ -f "$HOME/$config" ]]; then
            log_info "Backing up $HOME/$config"
            cp "$HOME/$config" "$BACKUP_DIR/"
        fi
    done
    
    if [[ -n "$(ls -A "$BACKUP_DIR" 2>/dev/null)" ]]; then
        log_success "Backup created at: $BACKUP_DIR"
    else
        log_info "No existing configurations found to backup"
        rmdir "$BACKUP_DIR"
    fi
}

# Check for required dependencies
check_dependencies() {
    log_info "Checking for required dependencies..."
    
    local required_packages=(
        "hyprland"
        "kitty" 
        "neovim"
        "zsh"
        "rofi"
        "mako"
        "brightnessctl"
        "wpctl"
    )
    
    local missing_packages=()
    
    for package in "${required_packages[@]}"; do
        if ! command -v "$package" &> /dev/null; then
            missing_packages+=("$package")
        fi
    done
    
    if [[ ${#missing_packages[@]} -gt 0 ]]; then
        log_warning "Missing packages: ${missing_packages[*]}"
        log_info "Please install them with your package manager:"
        log_info "  Arch/Manjaro: sudo pacman -S ${missing_packages[*]}"
        log_info "  Ubuntu/Debian: sudo apt install ${missing_packages[*]}"
        
        read -p "Continue anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Installation cancelled"
            exit 1
        fi
    else
        log_success "All required dependencies found"
    fi
}

# Create symbolic links
create_symlinks() {
    log_info "Creating symbolic links..."
    
    # Ensure .config directory exists
    mkdir -p "$CONFIG_DIR"
    
    # Config directory symlinks
    local config_links=(
        "hypr:$CONFIG_DIR/hypr"
        "nvim:$CONFIG_DIR/nvim"
        "kitty:$CONFIG_DIR/kitty"
        "rofi:$CONFIG_DIR/rofi"
        "mako:$CONFIG_DIR/mako"
        "ranger:$CONFIG_DIR/ranger"
        "zathura:$CONFIG_DIR/zathura"
        "mpv:$CONFIG_DIR/mpv"
        "gtk-3.0:$CONFIG_DIR/gtk-3.0"
        "gtk-4.0:$CONFIG_DIR/gtk-4.0"
    )
    
    # Home directory symlinks
    local home_links=(
        "zsh/zshrc:$HOME/.zshrc"
        "zsh/zshenv:$HOME/.zshenv"
        "zsh/zprofile:$HOME/.zprofile"
    )
    
    # Create config directory links
    for link in "${config_links[@]}"; do
        local source="${link%:*}"
        local target="${link#*:}"
        
        if [[ -d "$DOTFILES_DIR/$source" ]]; then
            # Remove existing file/directory if it exists
            [[ -e "$target" ]] && rm -rf "$target"
            
            ln -sf "$DOTFILES_DIR/$source" "$target"
            log_success "Linked $source -> $target"
        else
            log_warning "Source directory $source not found, skipping"
        fi
    done
    
    # Create home directory links
    for link in "${home_links[@]}"; do
        local source="${link%:*}"
        local target="${link#*:}"
        
        if [[ -f "$DOTFILES_DIR/$source" ]]; then
            # Remove existing file if it exists
            [[ -f "$target" ]] && rm -f "$target"
            
            ln -sf "$DOTFILES_DIR/$source" "$target"
            log_success "Linked $source -> $target"
        else
            log_warning "Source file $source not found, skipping"
        fi
    done
}

# Make scripts executable
setup_scripts() {
    log_info "Setting up scripts..."
    
    if [[ -d "$DOTFILES_DIR/hypr/scripts" ]]; then
        chmod +x "$DOTFILES_DIR/hypr/scripts"/*.sh
        log_success "Made Hyprland scripts executable"
    else
        log_warning "Hyprland scripts directory not found"
    fi
}

# Install optional enhancements
install_enhancements() {
    log_info "Setting up optional enhancements..."
    
    # Set Zsh as default shell if not already
    if [[ "$SHELL" != *"zsh" ]]; then
        log_info "Setting Zsh as default shell..."
        chsh -s "$(which zsh)"
        log_success "Zsh set as default shell (restart required)"
    fi
    
    # Install oh-my-zsh or powerlevel10k if not present
    if [[ ! -d "$HOME/.oh-my-zsh" ]] && [[ ! -f "/usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme" ]]; then
        log_info "Consider installing PowerLevel10k theme:"
        log_info "  Arch: sudo pacman -S zsh-theme-powerlevel10k"
        log_info "  Manual: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k"
    fi
}

# Validate installation
validate_installation() {
    log_info "Validating installation..."
    
    local errors=0
    
    # Check if symlinks were created correctly
    local check_paths=(
        "$CONFIG_DIR/hypr"
        "$CONFIG_DIR/nvim"
        "$CONFIG_DIR/kitty"
        "$HOME/.zshrc"
    )
    
    for path in "${check_paths[@]}"; do
        if [[ ! -e "$path" ]]; then
            log_error "Missing: $path"
            ((errors++))
        fi
    done
    
    # Check if scripts are executable
    if [[ -d "$CONFIG_DIR/hypr/scripts" ]]; then
        for script in "$CONFIG_DIR/hypr/scripts"/*.sh; do
            if [[ ! -x "$script" ]]; then
                log_error "Script not executable: $script"
                ((errors++))
            fi
        done
    fi
    
    if [[ $errors -eq 0 ]]; then
        log_success "Installation validation passed"
        return 0
    else
        log_error "Installation validation failed with $errors errors"
        return 1
    fi
}

# Main installation function
main() {
    echo -e "${BLUE}"
    cat << "EOF"
╔══════════════════════════════════════╗
║           DOTFILES INSTALLER         ║
║                                      ║
║  Installing Hyprland configuration   ║
║  and associated dotfiles             ║
╚══════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    log_info "Starting dotfiles installation..."
    log_info "Installation directory: $DOTFILES_DIR"
    
    # Confirmation prompt
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_info "Installation cancelled by user"
        exit 0
    fi
    
    # Run installation steps
    check_system
    backup_existing_configs
    check_dependencies
    create_symlinks
    setup_scripts
    install_enhancements
    
    if validate_installation; then
        echo
        log_success "🎉 Dotfiles installation completed successfully!"
        echo
        log_info "Next steps:"
        log_info "1. Restart your terminal or run: source ~/.zshrc"
        log_info "2. Start Hyprland session"
        log_info "3. Configure PowerLevel10k theme if not already done"
        log_info "4. Review README.md for usage instructions"
        echo
        
        if [[ -d "$BACKUP_DIR" ]]; then
            log_info "💾 Your original configs are backed up at: $BACKUP_DIR"
        fi
    else
        log_error "Installation completed with errors. Please check the output above."
        exit 1
    fi
}

# Run main function
main "$@"