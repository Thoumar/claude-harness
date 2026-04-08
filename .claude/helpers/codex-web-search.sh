#!/usr/bin/env bash
# Invoke Codex to perform web research on a topic.
# Usage: bash .claude/helpers/codex-web-search.sh "topic to research"
#
# Codex uses its web search capabilities to find current information.
# Returns a structured research summary.

set -euo pipefail

SEARCH_TOPIC="${1:?Usage: codex-web-search.sh \"topic to research\"}"

PREAMBLE=$(cat "$(dirname "$0")/../context/codex-sidekick-preamble.md" 2>/dev/null || echo "You are a research assistant.")

PROMPT=$(cat <<EOF
${PREAMBLE}

## Your Task

Research the following topic using web search. Provide current, accurate information.

**Topic:** ${SEARCH_TOPIC}

## Instructions

1. Search for the most current and authoritative sources on this topic.
2. Cross-reference multiple sources to verify accuracy.
3. Focus on practical, actionable information relevant to software development.
4. Note any conflicting information or caveats.

## Output Format

### Summary
[2-3 sentence overview]

### Key Findings
- [Bullet points of important discoveries]

### Sources
- [List URLs or references used]

### Relevance to Project
[How this information applies to the current codebase or task]

### Confidence Level
[High / Medium / Low] — [Explanation of confidence]
EOF
)

echo "$PROMPT" | codex --quiet --approval-mode full-auto 2>/dev/null || \
echo "$PROMPT" | codex -q -a full-auto 2>/dev/null || \
echo "ERROR: Could not invoke Codex. Ensure 'codex' CLI is installed and available in PATH."
