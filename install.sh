#!/usr/bin/env bash
#
# install.sh — bootstrap macOS dev environment
#
# Usage:
#   ./install.sh          # interactive — prompts for each section
#   ./install.sh --all    # run everything
#   ./install.sh --link   # symlink dotfiles only
#   ./install.sh --brew   # install Homebrew packages only
#   ./install.sh --macos  # apply macOS defaults only
#
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

info()  { echo -e "${GREEN}[info]${NC} $1"; }
warn()  { echo -e "${YELLOW}[warn]${NC} $1"; }
error() { echo -e "${RED}[error]${NC} $1"; }

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

link_file() {
    local src="$1" dst="$2"

    if [ -L "$dst" ]; then
        local current
        current="$(readlink "$dst")"
        if [ "$current" = "$src" ]; then
            info "already linked: $dst"
            return
        fi
        rm "$dst"
    elif [ -f "$dst" ] || [ -d "$dst" ]; then
        local backup="${dst}.backup.$(date +%Y%m%d%H%M%S)"
        warn "backing up $dst → $backup"
        mv "$dst" "$backup"
    fi

    ln -s "$src" "$dst"
    info "linked: $dst → $src"
}

confirm() {
    local prompt="$1"
    read -rp "$prompt [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]]
}

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------

install_homebrew() {
    info "Checking Homebrew..."
    if ! command -v brew &>/dev/null; then
        info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        info "Homebrew already installed"
    fi

    info "Installing packages from Brewfile..."
    brew bundle --file="$DOTFILES/Brewfile" --no-lock
    info "Homebrew packages installed"
}

# ---------------------------------------------------------------------------
# Symlinks
# ---------------------------------------------------------------------------

link_dotfiles() {
    info "Linking dotfiles..."

    # Create required directories
    mkdir -p "$HOME/.ssh/sockets"
    mkdir -p "$HOME/.claude/commands"
    mkdir -p "$HOME/.config/git"
    mkdir -p "$HOME/Screenshots"

    # Set permissions
    chmod 700 "$HOME/.ssh"

    # Shell
    link_file "$DOTFILES/shell/zshrc"    "$HOME/.zshrc"
    link_file "$DOTFILES/shell/zprofile" "$HOME/.zprofile"

    # Git
    link_file "$DOTFILES/git/gitconfig"        "$HOME/.gitconfig"
    link_file "$DOTFILES/git/gitignore_global" "$HOME/.config/git/ignore"

    # SSH
    link_file "$DOTFILES/ssh/config" "$HOME/.ssh/config"
    chmod 600 "$DOTFILES/ssh/config"

    # Claude Code
    link_file "$DOTFILES/claude/CLAUDE.md"     "$HOME/.claude/CLAUDE.md"
    link_file "$DOTFILES/claude/settings.json" "$HOME/.claude/settings.json"
    for cmd in "$DOTFILES"/claude/commands/*.md; do
        link_file "$cmd" "$HOME/.claude/commands/$(basename "$cmd")"
    done

    info "Dotfiles linked"
}

# ---------------------------------------------------------------------------
# macOS defaults
# ---------------------------------------------------------------------------

apply_macos_defaults() {
    info "Applying macOS defaults..."
    bash "$DOTFILES/macos/defaults.sh"
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
    echo ""
    echo "  dotfiles — macOS dev environment"
    echo "  ================================"
    echo ""

    case "${1:-}" in
        --all)
            install_homebrew
            link_dotfiles
            apply_macos_defaults
            ;;
        --brew)
            install_homebrew
            ;;
        --link)
            link_dotfiles
            ;;
        --macos)
            apply_macos_defaults
            ;;
        *)
            # Interactive mode
            if confirm "Install Homebrew packages?"; then
                install_homebrew
            fi
            echo ""
            if confirm "Symlink dotfiles?"; then
                link_dotfiles
            fi
            echo ""
            if confirm "Apply macOS defaults?"; then
                apply_macos_defaults
            fi
            ;;
    esac

    echo ""
    info "Done! Open a new terminal to pick up changes."
}

main "$@"
