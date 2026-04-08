#!/usr/bin/env bash
# Invoke Codex to review code changes (staged diff or specific files).
# Usage: bash .claude/helpers/codex-review.sh [file_or_description]
#
# If no argument given, reviews the current staged diff.
# Codex runs in read-only mode — advisory only.

set -euo pipefail

REVIEW_TARGET="${1:-}"

PREAMBLE=$(cat "$(dirname "$0")/../context/codex-sidekick-preamble.md" 2>/dev/null || echo "You are a read-only code reviewer.")

if [ -z "$REVIEW_TARGET" ]; then
  DIFF=$(git diff --cached 2>/dev/null || git diff 2>/dev/null || echo "No diff available")
  CONTEXT="## Code to Review (staged diff)\n\n\`\`\`diff\n${DIFF}\n\`\`\`"
else
  CONTEXT="## Code to Review\n\n**Target:** ${REVIEW_TARGET}\n\nRead the relevant files and review the implementation."
fi

PROMPT=$(cat <<EOF
${PREAMBLE}

## Your Task

Perform a thorough code review.

${CONTEXT}

## Review Checklist

1. **Correctness**: Does the code do what it's supposed to? Are there logic errors?
2. **Type safety**: Are there type escape hatches (any, as, unsafe casts)?
3. **Edge cases**: Are boundary conditions handled?
4. **Security**: Any injection, XSS, or data exposure risks?
5. **Performance**: Any N+1 queries, unnecessary allocations, or missing memoization?
6. **Standards compliance**: Does it follow the project's CLAUDE.md coding standards?
7. **Naming**: Are names clear and descriptive?
8. **Structure**: Are functions focused? Is there unnecessary complexity?

## Output Format

For each finding:
- **[SEVERITY]** (critical / warning / suggestion) — file:line — description

End with:
- **VERDICT: APPROVED** — Code is ready to merge.
- **VERDICT: CHANGES REQUESTED** — Issues listed above need addressing.
EOF
)

echo "$PROMPT" | codex --quiet --approval-mode full-auto 2>/dev/null || \
echo "$PROMPT" | codex -q -a full-auto 2>/dev/null || \
echo "ERROR: Could not invoke Codex. Ensure 'codex' CLI is installed and available in PATH."
