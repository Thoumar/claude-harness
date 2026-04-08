# Implement Plan

Execute the implementation plan with a focus on code quality and craftsmanship.

## Prerequisites

This command works best after `/plan` has been run. If no plan exists in the conversation context, ask the user to either:

- Run `/plan` first
- Provide the implementation steps manually

For any non-trivial implementation, use local Codex as a read-only second brain before considering the work done.

- Do your own first pass.
- Ask Codex to challenge the approach, implementation, or review.
- If Codex finds gaps, fix them and ask Codex again.
- Exit only when Codex has nothing material left to add.

## Baseline Verification (ALWAYS DO FIRST)

Before implementing anything:
1. Run `git status` -- check for uncommitted changes from previous work
2. If a test suite exists (check for test scripts in package.json, pubspec.yaml, etc.), run it
3. If tests fail, STOP and report to the user before proceeding
4. If there are uncommitted changes, ask the user whether to commit, stash, or discard them

Do not skip this step. Compounding bugs across sessions is the most common failure mode.

## Code Quality Principles

These apply to all codebases regardless of language or framework:

### Core

- **Self-documenting code**: No comments. Clear naming and structure speak for themselves.
- **Single responsibility**: Small, focused functions that do one thing well.
- **Predictable patterns**: Conventional naming, established idioms, no clever tricks.
- **Long-term maintainability**: Proper abstractions over quick fixes.
- **No placeholders**: Every function must be fully implemented. No TODO comments, no stub returns, no "implement later" patterns. If a function exists, it must work.
- **No premature abstractions**: Don't create utilities, helpers, or abstractions for one-time operations. Three similar lines are better than a premature abstraction.

### Type Safety (for typed languages)

- Avoid escape hatches that bypass the type system (`any`, `as`, type assertions, unsafe casts).
- Prefer type guards and generics over type coercion.
- Let the compiler help — don't fight it.

### File Organization

- One primary export per file where conventions allow.
- Direct imports over barrel/re-exports.
- Follow the existing project structure and patterns found in CLAUDE.md.

### Stack-Specific Standards

Refer to the project's CLAUDE.md for language and framework-specific coding standards. Those standards were generated for this specific project by `/install-harness` and take precedence over general principles when they conflict.

## Implementation Checklist

Before marking a task complete, verify:

- [ ] Code is self-documenting (no comments needed)
- [ ] Functions are small and focused
- [ ] Variable names are descriptive
- [ ] Type safety is maintained (no escape hatches)
- [ ] Follows existing project patterns from CLAUDE.md
- [ ] No hardcoded user-facing strings (if i18n is configured)
- [ ] Codex has validated the implementation (for non-trivial work)

## Progress Persistence

After completing each implementation step:
1. Commit with a descriptive message explaining WHAT changed and WHY
2. If multiple steps remain, update the task list or conversation with what's done vs remaining
3. If you discover a bug unrelated to current work, note it immediately (create a TODO or tell the user)
