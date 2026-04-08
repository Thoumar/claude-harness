#!/usr/bin/env bash
# Guard hook: ensures Codex CLI is only invoked in read-only mode.
# Attached to PreToolUse (Bash) — only inspects commands that mention codex.

set -euo pipefail

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# Exit early if not a codex command — this is the fast path for 99% of Bash calls
if [ -z "$COMMAND" ]; then
  exit 0
fi

if ! echo "$COMMAND" | grep -Eq '(^|[;&|][[:space:]]*)codex([[:space:]]|$)' && [[ "$COMMAND" != *".claude/helpers/codex-"* ]]; then
  exit 0
fi

# Allow our own helper scripts (they enforce read-only internally)
if [[ "$COMMAND" == *".claude/helpers/codex-"* ]]; then
  exit 0
fi

# Block write-capable Codex modes
if [[ "$COMMAND" == *"workspace-write"* ]] || [[ "$COMMAND" == *"danger-full-access"* ]] || [[ "$COMMAND" == *"--full-auto"* ]] || [[ "$COMMAND" == *"--dangerously-bypass-approvals-and-sandbox"* ]]; then
  echo "Blocked unsafe Codex usage. Codex is advisory-only and must stay read-only." >&2
  exit 2
fi

# Allow safe subcommands
if [[ "$COMMAND" == *"codex --help"* ]] || [[ "$COMMAND" == *"codex -h"* ]] || [[ "$COMMAND" == *"codex --version"* ]] || [[ "$COMMAND" == *"codex login"* ]] || [[ "$COMMAND" == *"codex logout"* ]]; then
  exit 0
fi

# Allow review mode
if [[ "$COMMAND" == *"codex review"* ]]; then
  exit 0
fi

# Allow exec with read-only sandbox
if [[ "$COMMAND" == *"codex exec"* ]] || [[ "$COMMAND" == *"codex -C "* ]]; then
  if [[ "$COMMAND" == *"--sandbox read-only"* ]]; then
    exit 0
  fi
  echo "Blocked Codex exec without '--sandbox read-only'." >&2
  exit 2
fi

echo "Blocked unsupported Codex command. Use read-only review/search/challenge flows only." >&2
exit 2
