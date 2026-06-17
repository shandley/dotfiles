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

## Documentation writing
- Do not use em-dashes (—) in any written documents, emails, READMEs, or policy files
- Avoid other common LLM writing patterns: "cutting-edge", "robust", "leverage", "utilize", "streamline", "seamless", "low-friction", "pathway" as metaphor, bold lead-in summary sentences, "The core idea:", "dramatically" and similar intensifiers
- Write documentation in plain, direct prose that reads like a human wrote it

## Workflow
- IMPORTANT: Do not commit unless explicitly asked
- IMPORTANT: Do not push unless explicitly asked
- IMPORTANT: Never use /tmp for output files. Always write outputs, test results, reports, and artifacts to the project's working directory (e.g., benchmark_data/results/ or similar). Outputs in /tmp are lost on reboot and disconnected from the project.
- Prefer editing existing files over creating new ones
- When creating Python projects, use uv for environment and dependency management
- When creating Node projects, use pnpm

## Reference data and identifiers

CRITICAL: do not generate scientific or technical identifiers from memory. This includes:
- Biological: UniProt accessions, NCBI gene/protein/genome accessions, Pfam IDs, GO terms, taxonomy IDs, EC numbers
- Bibliographic: DOIs, PMIDs, ArXiv IDs, citation keys
- Chemical: CAS numbers, PubChem CIDs, ChEBI IDs
- Technical: package versions, API endpoints, exact tool flags I am not 100% certain about

Famous entries (e.g., GFP P42212, GroEL P0A6F5, the original ESM2 paper) are in training data and may be recalled correctly. Less-famous entries follow a hallucination pattern: the format is right, the specific value is wrong, and famous-vs-not is not distinguishable from output alone.

Required behavior:
1. Before writing any such identifier to a file, verify it via the authoritative source (UniProt REST, NCBI E-utilities, CrossRef, InterPro). Use WebFetch or a local API call.
2. Cross-check the returned record against expected fields: protein name keywords match, organism matches, length range plausible, paper title matches.
3. If verification is not possible in the current environment, surface the uncertainty explicitly ("I do not have this verified; you will need to look it up before committing it") rather than producing confident-looking output.
4. When auditing existing project data containing identifiers, prefer the `/verify-references` skill over manual eyeballing.

Why: in the detergents project on 2026-06-12, an earlier session's hardcoded `POSITIVE_CONTROLS` and seed lists contained 6 wrong accessions for less-famous proteins. Famous proteins (GFP, GroEL, MBP) were right; less-famous ones (Manduca apolipophorin, Galleria apolipophorin, ScSUMO, EcGST, GpLuc, WbHSP16) were confabulated. The errors corrupted three days of downstream pipeline work because no code path ever cross-checked identity against accession.

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

## Scientific figures

### Classification (apply before any figure work)
Three categories from Claus Wilke -- every figure defect falls into one:
- **Ugly**: aesthetic problem only; data is readable. Fix design, not data.
- **Bad**: perceptually misleading; reader draws wrong conclusions. Must fix before publication.
- **Wrong**: factually incorrect; numbers cannot be correctly read. Blocks publication.

### Data-ink (Tufte)
- Maximize data-ink ratio: every mark should encode data or be removed
- Eliminate: heavy gridlines, filled backgrounds, redundant axis ticks, 3D effects, decorative shading, chartjunk

### Color -- Okabe-Ito palette (default for all categorical data)
Safe for all forms of color blindness; prints in grayscale:

| Name | Hex |
|---|---|
| Black | `#000000` |
| Orange | `#E69F00` |
| Sky blue | `#56B4E9` |
| Bluish green | `#009E73` |
| Yellow | `#F0E442` |
| Blue | `#0072B2` |
| Vermillion | `#D55E00` |
| Reddish purple | `#CC79A7` |

- Sequential quantitative: viridis, plasma, or cividis. Never rainbow/jet.
- Diverging: two sequential scales meeting at a neutral midpoint.
- Never encode information in color alone -- pair with shape or position.
- Verify the palette works in grayscale before submission.

### Multi-panel figures
- Same category = same color/shape/symbol across all panels. No exceptions.
- Panel labels: uppercase bold (A, B, C), 11-12pt, top-left of each panel.
- Panels align on a grid; adjacent axes share baselines where possible.
- Reading order: left-to-right, top-to-bottom.

### Axes and typography
- Every axis: `[measurement name] (unit)` -- e.g., "Distance (L2)" not just "Distance"
- Font: sans-serif only (Arial, Helvetica, DejaVu Sans)
- Axis labels: 8-9pt. Tick labels: 7-8pt. Panel labels: 11-12pt bold.
- Bar charts: y-axis starts at 0 unless scientifically justified and explicitly labeled.

### Claim accuracy (verify before finalizing any figure)
- All n values match the actual filtered dataset used
- All statistics (AUC, p-values, r, R²) are computed from the same data shown
- Threshold lines correspond to values derived in the analysis, not eyeballed
- Caption states exactly what is shown, including what was excluded and why
- No axis truncation that exaggerates differences without explicit labeling

### Interpretability test
Ask: "Can a reader extract the main message in under 5 seconds without reading the caption?" If no, the visual hierarchy is wrong. The most important element must be the most visually prominent (largest, most saturated, highest contrast).

### Output formats
- Review: PNG at 150 DPI
- Submission: PDF (vector) + TIFF at 300 DPI minimum (600 for line art)
- Target journal column widths: Nature Microbiology single = 89mm, full = 183mm; mSystems full = ~180mm
