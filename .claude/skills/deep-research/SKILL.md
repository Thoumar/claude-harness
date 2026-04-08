---
name: deep-research
description: Internet-heavy research with multiple Codex web search rounds
---

# Deep Research Skill

Trigger this skill when the user needs external research beyond the codebase.

## Activation

- Comparing libraries or frameworks
- Researching best practices
- Understanding external APIs
- Evaluating migration paths
- Security advisories

## Execution

Follow the process defined in `.claude/commands/deep-research.md`:

1. Define the research question
2. Run initial web research via Codex
3. Run additional focused rounds until comprehensive
4. Check codebase context for compatibility
5. Synthesize into a structured report with recommendation
6. Validate with Codex
7. Present to user
