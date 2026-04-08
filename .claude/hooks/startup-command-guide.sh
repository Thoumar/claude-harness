#!/usr/bin/env bash
set -euo pipefail

MESSAGE=$(cat <<'EOF'
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

Rules: Ask before implementing. Validate with Codex. Never assume requirements.
EOF
)

jq -n --arg message "$MESSAGE" '{systemMessage: $message}'
