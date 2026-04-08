---
name: commit
description: Stage, commit, push changes and optionally create a pull request.
disable-model-invocation: true
argument-hint: "[optional: commit message or 'pr' to also create a PR]"
---

# Commit & Push

Stage changes, write a commit message, push, and optionally create a PR.

## Process

### Step 1: Review changes

Run `git status` and `git diff` to understand what changed. Present a summary to the user:

- Files modified / added / deleted
- Brief description of each change
- Any untracked files that might need to be included or ignored

Use AskUserQuestion: "Here are the changes. Which files should I stage? (all / specific files / let me pick)"

### Step 2: Write the commit message

Based on the diff, draft a commit message following the project's convention (check CLAUDE.md for commit style). If no convention is specified, use conventional commits (`feat:`, `fix:`, `refactor:`, `docs:`, `chore:`).

Show the proposed message to the user via AskUserQuestion: "Proposed commit message: [message]. Want to use this, or provide your own?"

### Step 3: Commit

Stage the approved files and commit with the approved message.

### Step 4: Push

Push to the current branch. If no upstream is set, push with `-u origin [branch-name]`.

### Step 5: PR (if requested)

If $ARGUMENTS contains "pr" or the user asks for a PR:

1. Use AskUserQuestion to ask for the PR title and description, or offer to generate them from the commit history
2. Create the PR with `gh pr create`
3. Return the PR URL

If $ARGUMENTS is a commit message, use it directly instead of generating one.
