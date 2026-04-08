---
name: codebase-research
description: Deep codebase exploration with subagents and Codex synthesis
---

# Codebase Research Skill

Trigger this skill when the user wants to understand how part of the codebase works.

## Activation

- User asks "how does X work?"
- User wants to understand a module, feature, or data flow
- User needs to map dependencies before making changes

## Execution

Follow the process defined in `.claude/commands/codebase-research.md`:

1. Define the research question with the user
2. Launch parallel Explore subagents for different areas
3. Synthesize findings into a structured report
4. Validate with Codex
5. Present findings and suggest next steps
