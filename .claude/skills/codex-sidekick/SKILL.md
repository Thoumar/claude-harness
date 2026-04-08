---
name: codex-sidekick
description: Invoke Codex as a read-only adversarial reviewer. This skill MUST be used for any non-trivial task. It is not optional.
---

# Codex Sidekick Skill

Trigger this skill when work needs independent validation by Codex.

## When to Trigger (MANDATORY)

Codex validation is REQUIRED, not optional, for:
- Any plan or spec before presenting to user
- Any code change before marking complete
- Any research synthesis before presenting conclusions
- Any architectural recommendation

The only exception is trivial work: reading files, answering simple questions, small config changes.

## Execution

1. Determine what needs validation (code, plan, spec, review)
2. Invoke the appropriate helper:
   - `.claude/helpers/codex-challenge.sh` -- for challenging approaches
   - `.claude/helpers/codex-review.sh` -- for code review
   - `.claude/helpers/codex-web-search.sh` -- for research validation
3. Parse the verdict
4. If `NEEDS WORK` or `CHANGES REQUESTED`: fix issues and re-run
5. Loop until `VALIDATED` or `APPROVED`
6. Report results to the user
