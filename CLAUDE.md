# Unity Game Dev Agent Harness

Injectable coding assistant layer for Unity/C# projects. Provides enforcement rules, skills, and project-specific docs generated from the actual codebase.

## Quick Reference

- **Agent guide:** `AGENTS.md` — read this first every session
- **Architecture:** `docs/architecture.md` — layers, bootstrap ordering, singletons
- **Conventions:** `docs/conventions.md` — the authority on coding standards
- **Domain:** `docs/domain.md` — domain model, networking rules, API contracts
- **Testing:** `docs/testing.md` — test strategy, patterns, coverage priorities
- **Enforcement:** `enforcement/` — non-negotiable rules checked after writing code
- **Memory:** `memory/` — cross-session learning, read at session start

## Non-Negotiable Rules

1. Never silently consume null — throw when non-null is required
2. SOLID principles are mandatory — enforced, not aspirational
3. Fully descriptive variable names — no abbreviations
4. Every code change must include tests — bug fix, feature, or refactor
5. Fix adjacent enforcement violations when working nearby
6. All work is local — no git operations, no commits, no PRs
7. Read `docs/` before making changes — understand the project's architecture first

## Commands

- `/implement-feature` — plan → TDD → verify → cleanup → retrospective
- `/fix-bug` — reproduce → root cause → test → fix → verify
- `/create-tests` — generate EditMode/PlayMode tests for existing code
- `/deslop` — code cleanup
- `/garden` — entropy scan and maintenance
- `/retrospective` — capture learnings to memory

## Setup

If `docs/` is empty, generate project-specific docs first:
```
./generate-docs.sh
```
