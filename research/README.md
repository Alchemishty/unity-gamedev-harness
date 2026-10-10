# Research

Papers and repos that informed harness design decisions. Each entry notes what we adopted and why.

## Papers

### Context Rot in Coding Agents
- **Source:** arXiv:2607.17937 (July 2026)
- **Finding:** Agent performance drops 50 percentage points as context grows from 11K to 299K tokens. External checklists pass 10/10 vs 5/10 for self-checks (p=0.0325). The degradation is attentional, not topical — irrelevant padding hurts equally.
- **What we adopted:** Re-inject enforcement rules at decision points, not just session start. Before writing tests, re-read test-coverage rules. Before designing classes, re-read SOLID rules. Rules loaded once at the top of context degrade.

### ExecCritic: Learn to Test, Test to Improve
- **Source:** arXiv:2609.09133 (September 2026)
- **Finding:** When the same agent writes both patch and test, "their errors can agree and create false confidence." Separating roles raised behavioral test quality from 22.2% to 62.2%.
- **What we adopted:** Ban structural/reflection-based tests in enforcement. Tests must assert observable behavior (return values, exceptions, state changes), not code shape (method existence, attribute presence). This forces the agent to think about what the code does, not how it's written.

### Opera: A Verbal Critic Framework for Long-Horizon Coding Agents
- **Source:** arXiv:2609.33987 (September 2026)
- **Finding:** Treating corrections as persistent notes tracked until resolved (not fire-and-forget) improves resolve rates by up to 15 percentage points. Distinguishes "mere compliance from actual resolution."
- **What we adopted:** Enforcement violations are tracked until verified resolved. Flagging a violation and moving on is not enough — the agent must verify the fix exists in the final code.

### An Empirical Study of Harness Design for Coding Agents
- **Source:** arXiv:2609.20804 (September 2026, 176 configurations)
- **Finding:** Best context strategy is rule-based elision first, then LLM summarization. Making elided content recoverable adds no value. Planning acts as accuracy scaffold for weaker models but cost saver for stronger ones.
- **What we adopted:** Observation masking via scratch/ — verbose output captured to files, only summaries in context. Validated our existing approach.

### Harness Engineering: Anatomy, Architecture, and Evolution of Coding Agents
- **Source:** arXiv:2609.00006 (July 2026, 83 pages)
- **Finding:** Source-code analysis of 11 production harnesses. No agent uses vector embeddings — all use deterministic retrieval. Defines 7 canonical subsystems: Loop, Tools, Context Management, Safety Controls, Orchestration, Extension Surfaces, Behavioral Policy.
- **What we adopted:** Enforcement rules as "locked surfaces" that the agent cannot override or skip. Behavioral policy externalized as structured docs, not inline prompt text.

### AutoSaddler: Automatic Harness Optimization from Execution Traces
- **Source:** arXiv:2608.23041 (August 2026)
- **Finding:** Framing harness improvement as offline learning from failure traces yields +9-10 percentage points. Three ingredients: deep debugging over shallow reflection, targeted modifications over unconstrained editing, generalization-aware selection.
- **What we adopted:** Benchmark-driven iteration — run the benchmark, analyze lost points, generate targeted enforcement changes, validate they generalize across tasks.

### TRIM: Reducing CodeSlop via Trajectory Minimization
- **Source:** arXiv:2607.18161 (July 2026)
- **Finding:** "CodeSlop" — residual unnecessary edits from agent search. Trajectory minimization cuts slop 17.9-32.9% with negligible performance regression.
- **What we adopted:** The deslop skill addresses this post-hoc. Future: constrain search trajectory during generation to prevent slop at source.

### HSI: Hierarchical Self-Improvement
- **Source:** arXiv:2608.08466 (August 2026)
- **Finding:** Task-specific evolvable harnesses with three levels: Task Harness, Evolver, Meta-Evolver. +39.3 on BabyAI, +33.0 on Crafter. Bounded by feedback fidelity.
- **What we adopted:** Not yet — future work. Our benchmark is the feedback signal needed for automated harness evolution.

## Repos

### Agent-Skills-for-Context-Engineering
- **Source:** https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering (18K stars)
- **What it provides:** 16 skills covering context degradation, compression, harness engineering, self-improvement loops, evaluation. Defines four surface classes (locked, editable, append-only, human-controlled) and the optimization ladder.
- **What we adopted:** Enforcement rules as locked surfaces. The optimization ladder for deciding where to fix recurring failures (prompt → context → workflow → harness code). Context degradation failure modes informed our re-injection strategy.

### Alchemishty/agent-harness
- **Source:** https://github.com/Alchemishty/agent-harness
- **What it provides:** The original framework-agnostic harness we forked from. 14 skills, harness.yaml config, context engineering features (observation masking, plan re-reading, compression triggers).
- **What we adopted:** Core structure (harness.yaml, AGENTS.md, docs/, enforcement/, memory/, scratch/), skill workflow patterns, context engineering features. We stripped git/GitHub operations, added Unity-specific domain knowledge, and significantly expanded enforcement rules.
