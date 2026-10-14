# Agent Guide

Injectable coding assistant layer for Unity/C# projects. Provides enforcement rules and auto-generated project-specific docs.

## Agent Rules

1. **Never silently consume null.** If a value must be non-null for the mechanism to work, throw with a message identifying what's missing and where. `if (x == null) return;` is forbidden when x being null means the system is broken.
2. **SOLID principles are mandatory, not aspirational.** One class = one responsibility. Depend on abstractions. Prefer small interfaces over fat base classes.
3. **Variable names must immediately tell the reader what they represent.** No abbreviations except universally understood ones (`id`, `url`, `api`).
4. **Use appropriate data structures** (object pools, dictionary lookups, component caches) where they increase efficiency over naive implementations.
5. **Read `docs/` before writing code.** Architecture, conventions, domain, and testing docs describe this specific project.
6. **Every code change must include tests.** Bug fix? Reproduce with a test first. Refactor? Prove behavior is preserved. Feature? TDD. EditMode for pure logic, PlayMode for MonoBehaviour/NetworkBehaviour.
7. **Fix adjacent enforcement violations.** When working near code that violates enforcement rules, fix the violations if safe and obvious.
8. **No git operations.** All work is local. No commits, no branches, no PRs.
9. **When in doubt, throw an error** rather than degrade silently.
10. **Bug fixes are not refactoring opportunities.** Fix the root cause with minimal changes. No new classes, file renames, or architectural restructuring during a bug fix. Enforcement violation fixes near the bug are the only exception.

## Docs

Generated from the actual codebase by `generate-docs.sh`:
- [docs/architecture.md](docs/architecture.md) — layers, dependencies, key types
- [docs/conventions.md](docs/conventions.md) — coding standards: existing patterns + mandatory quality gates
- [docs/domain.md](docs/domain.md) — domain model, networking rules, API contracts
- [docs/testing.md](docs/testing.md) — test strategy, coverage priorities

## Enforcement

Non-negotiable rules checked after code is written. Violations must be fixed before proceeding:
- [null-safety.md](enforcement/null-safety.md)
- [layer-imports.md](enforcement/layer-imports.md)
- [naming.md](enforcement/naming.md)
- [serialization-safety.md](enforcement/serialization-safety.md)
- [netcode-lifecycle.md](enforcement/netcode-lifecycle.md)
- [event-cleanup.md](enforcement/event-cleanup.md)
- [editor-runtime.md](enforcement/editor-runtime.md)
- [solid.md](enforcement/solid.md)
- [serialized-field-rename.md](enforcement/serialized-field-rename.md)
- [test-coverage.md](enforcement/test-coverage.md)
- [scope-discipline.md](enforcement/scope-discipline.md)
- [state-safety.md](enforcement/state-safety.md)

## Code Review

Use `/code-review` after implementation to get a fresh-context review against all enforcement rules. Every rule in `enforcement/` is a hard gate — violations must be fixed.
