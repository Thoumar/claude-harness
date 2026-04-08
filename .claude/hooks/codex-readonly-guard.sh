#!/usr/bin/env bash
# Guard hook: ensures Codex sessions remain read-only.
# Attached to the Stop hook — runs after every agent stop.
# If the task description indicates a Codex session, check for violations.

TASK_DESCRIPTION="${1:-}"
STOP_REASON="${2:-}"

# Only check tasks that involve Codex
if ! echo "$TASK_DESCRIPTION" | grep -qi "codex"; then
  exit 0
fi

VIOLATIONS=""

# Check for uncommitted file changes (staged or unstaged)
if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
  CHANGED_FILES=$(git diff --name-only 2>/dev/null; git diff --cached --name-only 2>/dev/null)
  VIOLATIONS="${VIOLATIONS}VIOLATION: Codex modified files:\n${CHANGED_FILES}\n\n"
fi

# Check for untracked files created during session (heuristic: files modified in last 2 minutes)
RECENT_FILES=$(find . -maxdepth 4 -newer /tmp/.codex-session-marker -type f 2>/dev/null | grep -v '.git/' | grep -v 'node_modules/' | head -20)
if [ -n "$RECENT_FILES" ]; then
  VIOLATIONS="${VIOLATIONS}WARNING: New files created during Codex session:\n${RECENT_FILES}\n\n"
fi

# Check for commits made during session
RECENT_COMMITS=$(git log --oneline --since="2 minutes ago" 2>/dev/null)
if [ -n "$RECENT_COMMITS" ]; then
  VIOLATIONS="${VIOLATIONS}VIOLATION: Codex created commits:\n${RECENT_COMMITS}\n\n"
fi

if [ -n "$VIOLATIONS" ]; then
  echo "━━━ CODEX READONLY GUARD ━━━"
  echo ""
  echo "Codex is advisory only — it must NOT edit files or create commits."
  echo ""
  echo -e "$VIOLATIONS"
  echo "Action: Revert these changes before continuing."
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  exit 1
fi

exit 0
