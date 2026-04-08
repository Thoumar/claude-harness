# Feature Interviewer

Interview the user about a new feature, refactor, or tooling idea. Produce a detailed technical specification validated by Codex.

## When to Use

- User has a vague idea that needs to be shaped into a concrete spec
- Turning a PRD into a technical specification
- Defining the scope and approach for a refactor
- Designing a new tool or internal utility

## Process

### Step 1: Initial Understanding

If there's a PRD in context (from `/write-prd`), read it first.

Otherwise, ask the user:
- What do you want to build or change?
- Why? What problem does this solve?
- Do you have a preference for how it should work?

### Step 2: Codebase Exploration

Before diving into spec writing, understand the landscape:
- Read CLAUDE.md for project patterns
- Explore the area of the codebase this feature will touch
- Identify existing patterns, utilities, and components to reuse
- Map the integration points (where the new code meets existing code)

Share findings with the user: "Here's what I found in the codebase that's relevant..."

### Step 3: Deep Interview

This is the core of the process. Use AskUserQuestion extensively.

**Functional behavior:**
- Walk through each user-facing interaction step by step
- For each step: What does the user see? What can they do? What happens when they do it?
- What are the happy paths? What are the error paths?

**Technical decisions:**
- Should this follow an existing pattern or introduce a new one?
- What data models are needed? What's the schema?
- Where should this live in the file structure?
- Are there performance considerations?

**Edge cases:**
- What happens with empty/null data?
- What happens with very large data?
- What about concurrent access?
- What about offline/degraded scenarios?

### Step 4: Write the Technical Spec

```markdown
# Technical Spec: [Feature Name]

## Overview
[One paragraph summary]

## Related PRD
[Link if exists]

## Architecture

### Data Model
[New or modified models/schemas]

### Components / Modules
[What new files or modules are needed]

### Integration Points
[Where this connects to existing code]

## Detailed Design

### [Sub-feature 1]
- Implementation approach
- File locations
- Key functions and their signatures
- State management approach

### [Sub-feature 2]
...

## API Changes (if applicable)
[New or modified endpoints/interfaces]

## Migration Strategy (if applicable)
[How to get from current state to new state]

## Testing Strategy
[What tests are needed and how to structure them]

## Open Questions
[Anything still unresolved]
```

### Step 5: Codex Validation

Use `.claude/helpers/codex-challenge.sh` to review the spec:
- Technical feasibility
- Missing edge cases
- Consistency with existing patterns
- Security and performance concerns

Loop until `VERDICT: VALIDATED`.

### Step 6: User Approval

Present the final spec. Ask for approval or feedback.

### Step 7: Suggest Next Steps

- **`/plan`** to create an implementation plan from this spec
- **`/implement`** to start building directly (for simpler features)
