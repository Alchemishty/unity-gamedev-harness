# unity-gamedev-harness

Injectable coding assistant layer for Unity/C# projects. Drop it into any Unity codebase and your AI agent gets enforcement rules, domain-aware docs, and structured skills — without project-specific configuration.

## Benchmark Results

Tested on [unity-gamedev-bench](https://github.com/Alchemishty/unity-gamedev-bench) standard suite (10 tasks, Opus 4.6):

| | Baseline | With Harness | Δ |
|---|---|---|---|
| **Overall** | **60** | **77** | **+17** |
| Test Quality | 2.0/10 | 7.4/10 | +5.4 |
| Domain Correctness | 6.1/10 | 7.9/10 | +1.8 |
| Robustness | 6.4/10 | 7.4/10 | +1.0 |
| Architecture | 6.9/10 | 7.6/10 | +0.7 |
| Readability | 7.2/10 | 7.9/10 | +0.7 |
| Correctness | 7.4/10 | 7.8/10 | +0.4 |

Every task improved or held steady. No regressions.

## Quick Start

```bash
# 1. Clone into your project
cd your-unity-project/
cp -R /path/to/unity-gamedev-harness/{CLAUDE.md,AGENTS.md,harness.yaml,enforcement,skills,memory} .

# 2. Generate project-specific docs
/path/to/unity-gamedev-harness/generate-docs.sh

# 3. Run your agent — it reads the harness automatically
claude
```

## What It Does

**Before:** Your agent reads the code cold. It guesses at conventions, misses framework patterns, skips tests, silently consumes nulls.

**After:** Your agent reads enforcement rules, generated architecture docs, and domain-specific guidance. It writes tests, throws on null, follows the framework's lifecycle, and structures code to match the existing codebase.

### Components

| Component | Purpose |
|---|---|
| `CLAUDE.md` | Project-level rules loaded automatically |
| `AGENTS.md` | Agent guide: rules, docs, enforcement, skills |
| `enforcement/` | 10 non-negotiable rules (null safety, SOLID, naming, tests, etc.) |
| `skills/` | 6 structured workflows (implement, fix-bug, create-tests, etc.) |
| `docs/` | **Generated** architecture, conventions, domain, testing docs |
| `memory/` | Cross-session learning (accumulates over time) |
| `templates/` | Prompts used by `generate-docs.sh` |

### Doc Generation

The docs are not pre-written — they're generated from your actual codebase:

```bash
./generate-docs.sh
```

This analyzes every `.cs` file and produces four docs:
- **architecture.md** — layer model, key types, dependencies (from your code)
- **conventions.md** — existing patterns + mandatory quality gates (SOLID, null safety, etc.)
- **domain.md** — glossary, state model, networking rules (if applicable)
- **testing.md** — test infrastructure, coverage priorities, patterns

For codebases with sloppy conventions, the generated docs assert quality standards on top — they don't mirror slop back.

Adapts to codebase size: full source for small projects, signatures for medium, key files for large (900+ file repos work fine).

## Benchmark Integration

Use with [unity-gamedev-bench](https://github.com/Alchemishty/unity-gamedev-bench):

```bash
./scripts/run-all.sh \
    --agent "claude -p --dangerously-skip-permissions" \
    --label harness-run \
    --suite standard \
    --model claude-opus-4-6 \
    --setup /path/to/unity-gamedev-harness/bench-setup.sh
```

`bench-setup.sh` copies the harness into each task's working directory, generates and caches docs per repository, and appends a benchmark-mode override so the agent implements directly instead of asking for approval.

## Research

The harness design is informed by 8 papers and 2 repositories. See [research/README.md](research/README.md) for the full bibliography with what was adopted from each source.

Key influences:
- **Context rot** (arXiv:2607.17937): re-inject enforcement rules at decision points, not just session start
- **ExecCritic** (arXiv:2609.09133): tests must assert observable behavior, not code shape
- **Opera** (arXiv:2609.33987): enforcement violations tracked until verified resolved
- **Harness Engineering** (arXiv:2609.00006): enforcement rules as locked surfaces the agent cannot override

## License

MIT
