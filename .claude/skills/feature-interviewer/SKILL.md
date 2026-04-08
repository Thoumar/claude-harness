---
name: feature-interviewer
description: Interview user about features and produce Codex-validated technical specs
---

# Feature Interviewer Skill

Trigger this skill when the user has a feature idea that needs to be shaped into a spec.

## Activation

- User describes a new feature, refactor, or tooling idea
- User wants to turn a PRD into a technical specification
- User has a vague request that needs requirements extraction

## Execution

Follow the process defined in `.claude/commands/feature-interviewer.md`:

1. Understand the initial idea (read PRD if available)
2. Explore relevant codebase areas
3. Deep interview with AskUserQuestion (functional behavior, technical decisions, edge cases)
4. Write technical spec
5. Validate with Codex
6. Get user approval
7. Suggest next steps (/plan or /implement)
