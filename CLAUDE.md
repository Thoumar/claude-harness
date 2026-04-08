# CLAUDE.md

This is the claude-harness template. Run `/install-harness` in your target project after copying `.claude/` to generate a project-specific CLAUDE.md.

## Behavioral Directives (ALWAYS FOLLOW)

1. **Never implement without user approval.** Before writing any code, present your approach and get explicit confirmation via AskUserQuestion. "I'm going to do X" is not approval — the user must say yes.
2. **Never assume requirements.** If the user's request is ambiguous, vague, or could be interpreted multiple ways, use AskUserQuestion to clarify BEFORE proceeding. Do not guess.
3. **Never skip Codex validation.** For any non-trivial work (features, refactors, specs, plans), invoke the codex-challenger agent before presenting results as final.
4. **Never produce placeholder implementations.** Every function must be fully implemented. No TODO comments, no stub returns, no "implement later" patterns.
5. **Verify before building.** At the start of any implementation session, check that the codebase is in a clean state: tests pass, no uncommitted changes from previous work, no regressions.
6. **One task at a time.** Complete and validate one feature/fix before starting the next. Do not batch unrelated changes.
7. **Persist decisions to disk.** When the user makes an architectural or design decision, capture it in CLAUDE.md or a spec file — not just conversation context.

## Agent Auto-Delegation (IMPORTANT)

For the following task types, proactively delegate to the named agent without waiting for the user to ask:

| Task type | Agent |
|-----------|-------|
| New features, vague requests, specs, requirements gathering | `requirements-interviewer` |
| Understanding codebase, architecture questions, code exploration | `codebase-researcher` |
| External research, library comparison, ecosystem questions | `deep-research-analyst` |
| Refactors touching 3+ files, migrations, architecture changes | `refactor-orchestrator` |
| Validating any non-trivial plan, spec, review, or implementation | `codex-challenger` |

## Codex Sidekick

- For any task that is not trivial, do your own first pass then challenge it with Codex.
- Codex is advisory only: read, review, and search only. Never let Codex edit files or commit.
- Keep looping until Codex returns `VERDICT: VALIDATED`.
- Helper scripts: `.claude/helpers/codex-challenge.sh`, `.claude/helpers/codex-review.sh`, `.claude/helpers/codex-web-search.sh`

## Session Start Protocol

At the beginning of every session:
1. Read CLAUDE.md and any linked PRD/spec files
2. Check git status for uncommitted changes
3. Review last 5 commits to understand recent work
4. If a task list exists, review current progress
5. Run baseline verification if tests exist (check existing test suite passes)
