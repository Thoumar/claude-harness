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

## Code Quality Principles

These apply to all codebases regardless of language or framework:

### Core

- **Self-documenting code**: No comments. Clear naming and structure speak for themselves.
- **Single responsibility**: Small, focused functions that do one thing well.
- **Predictable patterns**: Conventional naming, established idioms, no clever tricks.
- **Long-term maintainability**: Proper abstractions over quick fixes.

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
