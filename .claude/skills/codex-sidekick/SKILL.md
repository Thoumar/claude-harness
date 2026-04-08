---
name: codex-sidekick
description: Invoke Codex as a read-only adversarial reviewer
---

# Codex Sidekick Skill

Trigger this skill when work needs independent validation by Codex.

## Activation

- After any non-trivial implementation
- After writing a spec or plan
- When a code review needs a second opinion
- User explicitly asks for Codex validation

## Execution

1. Determine what needs validation (code, plan, spec, review)
2. Invoke the appropriate helper:
   - `.claude/helpers/codex-challenge.sh` — for challenging approaches
   - `.claude/helpers/codex-review.sh` — for code review
   - `.claude/helpers/codex-web-search.sh` — for research validation
3. Parse the verdict
4. If `NEEDS WORK` or `CHANGES REQUESTED`: fix issues and re-run
5. Loop until `VALIDATED` or `APPROVED`
6. Report results to the user
