#!/usr/bin/env bash
# Invoke Codex to challenge an approach, plan, or implementation.
# Usage: bash .claude/helpers/codex-challenge.sh "description of what to challenge"
#
# Codex runs in read-only mode — it can read files and search but never edit.
# The output is advisory: review its feedback, fix gaps, then re-run until validated.

set -euo pipefail

CHALLENGE_TARGET="${1:?Usage: codex-challenge.sh \"description of what to challenge\"}"

PREAMBLE=$(cat "$(dirname "$0")/../context/codex-sidekick-preamble.md" 2>/dev/null || echo "You are a read-only code reviewer.")

PROMPT=$(cat <<EOF
${PREAMBLE}

## Your Task

Challenge the following approach or implementation. Be rigorous and adversarial.

**Target:** ${CHALLENGE_TARGET}

## Instructions

1. Read and understand the relevant code, plan, or spec.
2. Look for:
   - Logic errors, edge cases, off-by-one mistakes
   - Missing error handling at system boundaries
   - Security vulnerabilities (OWASP top 10)
   - Performance issues (N+1 queries, unnecessary re-renders, memory leaks)
   - Violations of the project's coding standards (check CLAUDE.md)
   - Incomplete implementations or missing requirements
   - Architectural concerns (tight coupling, wrong abstraction level)
3. For each issue found, provide:
   - File and line number
   - What's wrong
   - Why it matters
   - Suggested fix (conceptual, not code)
4. End with a verdict:
   - **VERDICT: VALIDATED** — No material issues found.
   - **VERDICT: NEEDS WORK** — Issues found, listed above.

Be thorough but fair. Don't nitpick style — focus on correctness, security, and maintainability.
EOF
)

echo "$PROMPT" | codex --quiet --approval-mode full-auto 2>/dev/null || \
echo "$PROMPT" | codex -q -a full-auto 2>/dev/null || \
echo "ERROR: Could not invoke Codex. Ensure 'codex' CLI is installed and available in PATH."
