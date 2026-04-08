# CLAUDE.md

This is the claude-harness template repository. Run `/install-harness` in your target project after copying `.claude/` to generate a project-specific CLAUDE.md.

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
