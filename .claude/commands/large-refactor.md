# Large Refactor

Execute high-blast-radius refactoring work using bounded slices with Codex critique at each step.

## When to Use

- Renaming across 3+ files
- Moving or restructuring directories
- Changing a widely-used interface or type
- Migrating from one pattern/library to another
- Extracting or consolidating modules
- Database schema changes with code updates

## Core Principle

**Never refactor everything at once.** Break the work into bounded slices that can each be validated independently. Each slice leaves the codebase in a working state.

## Process

### Step 1: Define the Refactor

Clarify with the user:
- What is being refactored and why?
- What is the desired end state?
- Are there constraints? (backward compatibility, feature flags, incremental rollout)

### Step 2: Impact Assessment

Before changing anything:
- Identify all files affected (use Grep to find all references)
- Map dependencies between affected files
- Identify the blast radius — what could break?
- Check for tests that cover the affected code
- Read CLAUDE.md for relevant coding standards

Present:
- **Files to change**: X files across Y modules
- **Blast radius**: low / medium / high with explanation
- **Test coverage**: what's covered, what's not
- **Risk areas**: specific concerns

### Step 3: Slice Planning

Break the refactor into ordered slices:

| Slice | Description | Files | Risk | Depends On |
|-------|-------------|-------|------|------------|
| 1 | ... | n | low | — |
| 2 | ... | n | med | Slice 1 |

Rules for slices:
- Each slice is independently testable
- Each slice doesn't break existing functionality
- Each slice has a clear rollback path
- One concern per slice (don't mix renaming with logic changes)

### Step 4: Codex Pre-Review

Use `.claude/helpers/codex-challenge.sh` to review the plan:
- Are the slices correctly ordered?
- Are there hidden dependencies?
- Is the blast radius accurate?
- Is there a safer approach?

### Step 5: Execute Slices

For each slice:
1. **Announce** — Tell the user what you're about to change and why
2. **Execute** — Make the changes
3. **Verify** — Run tests, type check, lint (whatever the project has)
4. **Review** — Use `.claude/helpers/codex-review.sh` to review changes
5. **Confirm** — Only move to next slice if current one is clean

**Stop conditions:**
- If a slice fails tests, stop and fix before continuing
- If scope grows beyond initial assessment, stop and re-plan with user
- If Codex finds critical issues, stop and address

### Step 6: Final Validation

After all slices:
- Run the full test suite
- Use `.claude/helpers/codex-challenge.sh` for final review
- Verify no regressions in related areas

### Step 7: Summary

Present a summary of all changes:
- Slices completed
- Files changed (with counts)
- Tests added or modified
- Any remaining follow-up items
