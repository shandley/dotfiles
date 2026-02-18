# dotfiles

macOS dev environment for bioinformatics on Apple Silicon — zsh, Homebrew, Claude Code, modern CLI tools.

## What's included

| Directory | Contents |
|-----------|----------|
| `shell/` | zshrc (GNU tools, fzf, history, completion, aliases), zprofile |
| `git/` | gitconfig (rebase, rerere, histogram diff), global gitignore |
| `ssh/` | SSH config (ControlMaster multiplexing, keychain, GitHub) |
| `claude/` | CLAUDE.md, settings.json (hooks, plugins), custom commands |
| `macos/` | `defaults.sh` — 50+ macOS developer productivity settings |
| `Brewfile` | Declarative Homebrew packages (CLI, dev tools, bioinformatics) |

## Quick start

```bash
git clone https://github.com/shandley/dotfiles.git ~/Code/tools/dotfiles
cd ~/Code/tools/dotfiles
chmod +x install.sh
./install.sh
```

The installer runs interactively by default, prompting for each section.

## Selective install

```bash
./install.sh --link   # symlink dotfiles only
./install.sh --brew   # install Homebrew packages only
./install.sh --macos  # apply macOS defaults only
./install.sh --all    # everything
```

## Prerequisites

- Apple Silicon Mac (M1/M2/M3/M4)
- Xcode Command Line Tools (`xcode-select --install`)

## Key decisions

- **GNU over BSD**: GNU coreutils, findutils, sed, tar, grep, and gawk replace BSD defaults on PATH for Linux compatibility
- **Symlinks, not copies**: `install.sh` symlinks files from this repo into `$HOME`, so edits in either location stay in sync
- **No secrets**: No tokens, keys, or credentials are stored in this repo
- **Rebase workflow**: Git is configured to rebase on pull, with rerere enabled for conflict memory
- **Modern CLI**: fd (find), bat (cat), eza (ls), fzf (fuzzy finder), ripgrep (grep) are installed and aliased

## Customization

- **Brewfile**: Add/remove packages, then run `brew bundle --file=Brewfile`
- **macOS defaults**: Review `macos/defaults.sh` and comment out settings you don't want before running
- **Git identity**: `git/gitconfig` contains name and email — update for your own use
- **SSH keys**: Update `ssh/config` with your own IdentityFile path

## Credits

Inspired by [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles) and [holman/dotfiles](https://github.com/holman/dotfiles).

## License

MIT
