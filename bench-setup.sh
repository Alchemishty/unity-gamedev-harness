#!/bin/bash
set -euo pipefail

# Injects the harness into a benchmark task's working directory.
# Uses a per-repo doc cache to avoid regenerating docs for every task.
#
# Usage with unity-gamedev-bench:
#   ./scripts/run-all.sh --agent "claude -p --dangerously-skip-permissions" \
#       --label my-run \
#       --setup "/path/to/unity-gamedev-harness/bench-setup.sh" \
#       s01 m01 b04

HARNESS_DIR="$(cd "$(dirname "$0")" && pwd)"
CACHE_DIR="${HARNESS_DIR}/.doc-cache"

# Copy universal harness files
cp "$HARNESS_DIR/CLAUDE.md" "$HARNESS_DIR/AGENTS.md" "$HARNESS_DIR/harness.yaml" .
cp -R "$HARNESS_DIR/enforcement" "$HARNESS_DIR/skills" .
mkdir -p memory
cp -R "$HARNESS_DIR/memory/." memory/

# Cache key: hash of the C# file listing (stable per repo+SHA)
CACHE_KEY=$(find . -name "*.cs" -not -path "*/Library/*" -not -path "*/Temp/*" | sort | md5 -q 2>/dev/null || find . -name "*.cs" -not -path "*/Library/*" -not -path "*/Temp/*" | sort | md5sum | cut -c1-12)

CACHED_DOCS="${CACHE_DIR}/${CACHE_KEY}"

if [[ -d "$CACHED_DOCS" && -f "$CACHED_DOCS/architecture.md" ]]; then
    mkdir -p docs
    cp "$CACHED_DOCS"/*.md docs/
    echo "Harness installed with cached docs (${CACHE_KEY:0:12})."
else
    "$HARNESS_DIR/generate-docs.sh"
    mkdir -p "$CACHED_DOCS"
    cp docs/*.md "$CACHED_DOCS/"
    echo "Harness installed — docs generated and cached (${CACHE_KEY:0:12})."
fi

# Benchmark override: single-turn mode, implement directly
cat >> CLAUDE.md << 'BENCHEOF'

## Benchmark Mode

This is a single-turn benchmark evaluation. You will receive one prompt and must produce a complete implementation in your response. Do NOT:
- Ask for confirmation or approval
- Present a design and wait for feedback
- Say "I'll implement once you approve"
- Output only a plan without code

Instead: read the codebase, understand the task, and write all the code changes directly. Include tests as required by the rules above.
BENCHEOF
