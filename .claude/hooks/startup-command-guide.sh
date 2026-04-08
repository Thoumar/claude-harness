#!/usr/bin/env bash
set -euo pipefail

# Check Codex availability once at session start
CODEX_STATUS="available"
if ! command -v codex >/dev/null 2>&1; then
  CODEX_STATUS="not installed"
fi

MESSAGE=$(cat <<EOF
Claude Harness — Command Guide
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Setup & Configuration:
  /install-harness    Detect stack, generate/upgrade CLAUDE.md
  /write-prd          Write a product requirements document

Investigation & Research:
  /investigate         Issue investigation with MCP discovery
  /codebase-research   Repo exploration with subagents + Codex
  /deep-research       Internet-heavy research via Codex web rounds

Planning & Implementation:
  /feature-interviewer Specs for features/refactors with Codex validation
  /plan                Implementation planning with Codex validation
  /implement           Execute plan with quality checks
  /large-refactor      Bounded slices with Codex critique
  /commit              Stage, commit, push, and optionally create a PR

Codex CLI: ${CODEX_STATUS}$([ "$CODEX_STATUS" != "available" ] && echo " — install @openai/codex for validation loops" || echo "")

Rules: Ask before implementing. Validate with Codex. Never assume requirements.
EOF
)

jq -n --arg message "$MESSAGE" '{systemMessage: $message}'
