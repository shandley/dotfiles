# Global preferences

## About me
- Bioinformatics researcher, evolutionary biology, professor
- Primary languages: Python, TypeScript, Rust
- macOS on Apple Silicon

## Code style
- Python: use type hints, prefer uv for package management
- TypeScript: ES modules, strict mode
- Prefer concise solutions over verbose ones

## Commands
- Package management: `uv` (Python), `pnpm` (Node), `cargo` (Rust)
- Git: always rebase, never merge commits on pull
- Tests: run relevant tests after changes, don't run full suite unless asked

## Workflow
- IMPORTANT: Do not commit unless explicitly asked
- IMPORTANT: Do not push unless explicitly asked
- Prefer editing existing files over creating new ones
- When creating Python projects, use uv for environment and dependency management
- When creating Node projects, use pnpm

## Python
- Formatter/linter: `ruff` (not black, not flake8)
- Type checker: `pyright` in strict mode
- Testing: `pytest`
- IMPORTANT: Use `uv run` to run commands within project venvs
- When creating new projects: `uv init`, add dev deps with `uv add --dev ruff pyright pytest`

## TypeScript
- Runtime: Node with pnpm
- Linter/formatter: prefer `biome` for new projects, `eslint`+`prettier` for existing
- Testing: `vitest` for new projects
- IMPORTANT: Always enable `strict: true` in tsconfig.json
- When creating new projects: `pnpm init`, `pnpm add -D typescript vitest @biomejs/biome`

## Rust
- Linter: `cargo clippy` (run with `-- -D warnings` to treat warnings as errors)
- Formatter: `rustfmt`
- Testing: `cargo nextest run` (faster than `cargo test`)
- Watcher: `cargo watch -x check` for continuous type checking
- IMPORTANT: Run `cargo clippy` after changes, not just `cargo check`
