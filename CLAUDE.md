# Unity Game Dev Agent Harness

Injectable coding assistant layer for Unity/C# projects. Provides enforcement rules and project-specific docs generated from the actual codebase.

## Quick Reference

- **Agent guide:** `AGENTS.md` — read this first every session
- **Architecture:** `docs/architecture.md` — layers, bootstrap ordering, singletons
- **Conventions:** `docs/conventions.md` — the authority on coding standards
- **Domain:** `docs/domain.md` — domain model, networking rules, API contracts
- **Testing:** `docs/testing.md` — test strategy, patterns, coverage priorities
- **Enforcement:** `enforcement/` — non-negotiable rules checked after writing code

## Non-Negotiable Rules

1. Never silently consume null — throw when non-null is required
2. SOLID principles are mandatory — enforced, not aspirational
3. Fully descriptive variable names — no abbreviations
4. Every code change must include tests — bug fix, feature, or refactor
5. Fix adjacent enforcement violations when working nearby
6. All work is local — no git operations, no commits, no PRs
7. Read `docs/` before making changes — understand the project's architecture first

## Unity MCP Tools

You have access to a live Unity editor via MCP tools. Use them:
- After writing/modifying .cs files, use `refresh_unity` to trigger recompilation
- Use `read_console` to check for compilation errors — fix all errors before proceeding
- Use `run_tests` to run EditMode and PlayMode tests
- If MCP tools fail after a domain reload, wait 10 seconds and retry — the bridge reconnects automatically

## Code Review

When reviewing code (or when `/code-review` is invoked), check the diff against every file in `enforcement/`. Each rule is a hard gate — violations must be fixed before the change is complete.

## Setup

If `docs/` is empty, generate project-specific docs first:
```
./generate-docs.sh
```
