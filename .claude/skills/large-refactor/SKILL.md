---
name: large-refactor
description: High-blast-radius refactoring in bounded, validated slices
---

# Large Refactor Skill

Trigger this skill when the user needs to refactor code across 3+ files.

## Activation

- Renaming across the codebase
- Moving or restructuring directories
- Changing widely-used interfaces
- Migrating between patterns or libraries
- Extracting or consolidating modules

## Execution

Follow the process defined in `.claude/commands/large-refactor.md`:

1. Define the refactor scope with user
2. Impact assessment (files, blast radius, test coverage)
3. Break into bounded slices
4. Codex pre-review of the plan
5. Execute slices one at a time (verify each before proceeding)
6. Final validation with full test suite + Codex
7. Summary of all changes
