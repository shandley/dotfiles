# Brewfile — Homebrew dependencies for macOS dev environment
# Install: brew bundle --file=Brewfile

# =============================================================================
# Taps
# =============================================================================
tap "mongodb/brew"
tap "ngrok/ngrok"
tap "supabase/tap"

# =============================================================================
# Core CLI — GNU replacements for BSD tools
# =============================================================================
brew "bash"
brew "coreutils"
brew "findutils"
brew "gawk"
brew "gnu-sed"
brew "gnu-tar"
brew "grep"

# =============================================================================
# Modern CLI — better defaults
# =============================================================================
brew "bat"          # cat with syntax highlighting
brew "eza"          # modern ls
brew "fd"           # modern find
brew "fzf"          # fuzzy finder
brew "htop"         # better top
brew "hyperfine"    # benchmarking
brew "ripgrep"      # fast grep
brew "tree"         # directory tree
brew "tree-sitter"  # syntax parsing

# =============================================================================
# Development — languages, tools, version managers
# =============================================================================
brew "cmake"
brew "docker"
brew "docker-compose"
brew "gh"
brew "git"
brew "git-filter-repo"
brew "node"
brew "openjdk"
brew "php"
brew "pipx"
brew "pnpm"
brew "rust"
brew "uv"

# Rust dev tools
brew "cargo-nextest"

# Python versions
brew "python@3.11"
brew "python@3.13"
brew "python-matplotlib"

# Python package managers
brew "poetry"

# =============================================================================
# Databases
# =============================================================================
brew "postgresql@16", restart_service: :changed
brew "mongodb/brew/mongodb-community"
brew "supabase/tap/supabase"

# =============================================================================
# Bioinformatics
# =============================================================================
brew "bcftools"
brew "blast"
brew "bowtie2"
brew "bwa"
brew "diamond"
brew "highs"
brew "isa-l"
brew "jellyfish"
brew "libdeflate"
brew "mafft"
brew "minimap2"
brew "mmseqs2"
brew "picard-tools"
brew "pymol"
brew "samtools"
brew "seqkit"
brew "seqtk"
brew "sratoolkit"
brew "veryfasttree"
brew "vsearch"
brew "zlib"

# =============================================================================
# Networking & utilities
# =============================================================================
brew "autoconf"
brew "automake"
brew "awscli"
brew "nextflow"
brew "pandoc"
brew "rclone"
brew "rsync"
brew "slackdump"
brew "ttyd"
brew "wget"

# =============================================================================
# Casks — GUI applications
# =============================================================================
cask "claude-code"
cask "dropbox"
cask "ghostty"
cask "google-chrome"
cask "kitty"
cask "mambaforge"
cask "ngrok/ngrok/ngrok"
cask "positron"
cask "wave"
cask "xquartz"
