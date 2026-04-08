# Plan Implementation

Create a detailed, step-by-step implementation plan for the current task with Codex validation.

## Prerequisites

This command works best when context has already been established:
- After `/investigate` has identified the issue and affected code
- After `/feature-interviewer` has produced a spec
- After `/write-prd` has produced requirements
- Or when the user provides clear requirements directly

## Baseline Verification (ALWAYS DO FIRST)

Before planning anything:
1. Run `git status` -- check for uncommitted changes from previous work
2. If a test suite exists, run it to confirm the codebase is in a clean state
3. If tests fail or there are uncommitted changes, report to the user before proceeding

## Process

### Step 1: Understand the Goal

If the task isn't clear from conversation context, ask the user:
- What are you trying to build or fix?
- Is there a spec, PRD, or investigation to reference?
- What constraints exist? (backward compatibility, performance, timeline)

### Step 2: Explore the Codebase

Before planning, understand the current state:
- Read CLAUDE.md for project patterns and standards
- Identify all files that will need to change
- Understand the existing patterns in those files
- Check for tests that cover the affected areas
- Look for reusable utilities, components, or patterns

### Step 3: Design the Approach

Consider multiple approaches if the solution isn't obvious:
- What are the trade-offs of each approach?
- Which approach best fits existing patterns?
- Which is simplest while still being correct?

If multiple viable approaches exist, present them to the user with trade-offs and ask for a preference.

### Step 4: Write the Plan

Produce a structured plan:

```
## Context
[Why this change is needed — the problem and intended outcome]

## Approach
[High-level description of the chosen approach and why]

## Steps

### 1. [Step title]
- **File(s):** `path/to/file.ext`
- **What:** [Specific change to make]
- **Why:** [Rationale]
- **Dependencies:** [Other steps this depends on]

### 2. [Step title]
...

## Testing Strategy
- [ ] [Specific test to add or verify]
- [ ] [Edge case to cover]

## Risks & Mitigations
- **Risk:** [What could go wrong]
- **Mitigation:** [How to handle it]

## Verification
[How to confirm the implementation is correct end-to-end]
```

### Step 5: Codex Validation

Use `.claude/helpers/codex-challenge.sh` to have Codex review the plan:
- Are any steps missing?
- Is the ordering correct (dependencies respected)?
- Are there edge cases not accounted for?
- Does the approach fit the project's patterns?

Loop until Codex returns `VERDICT: VALIDATED`.

### Step 6: Present to User

Show the validated plan to the user. Ask if anything needs adjustment.

### Step 7: Handoff

Once approved, suggest:
- **`/implement`** to execute the plan immediately
- Or the user can execute steps manually
