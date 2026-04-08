---
name: install-harness
description: Detect project stack and generate or upgrade the project CLAUDE.md with harness configuration.
disable-model-invocation: true
argument-hint: "[optional: project description]"
---

# Install / Upgrade Harness

Generate or upgrade the project's CLAUDE.md to integrate with this harness. This is a deep, multi-round interview — gather as much context as possible before generating.

## Round 1: Stack Detection & Confirmation

Scan the project root and subdirectories for all tech stack indicators. Build a comprehensive report:

**Package managers & languages:**
- `package.json` -> Node.js (inspect for react, next, vue, angular, express, nestjs, etc.)
- `tsconfig.json` -> TypeScript (check `strict`, `target`, module system)
- `pubspec.yaml` -> Flutter/Dart (check for riverpod, bloc, provider, hive, sqflite, etc.)
- `requirements.txt` / `pyproject.toml` / `setup.py` / `Pipfile` -> Python (check for django, flask, fastapi, etc.)
- `go.mod` -> Go
- `Cargo.toml` -> Rust
- `Gemfile` -> Ruby (check for rails, sinatra, etc.)
- `pom.xml` / `build.gradle` / `build.gradle.kts` -> Java/Kotlin
- `*.sln` / `*.csproj` -> .NET/C#
- `composer.json` -> PHP (check for laravel, symfony, etc.)
- `mix.exs` -> Elixir

**Infrastructure & tooling:**
- `docker-compose.yml` / `Dockerfile` -> Containerized
- `wrangler.toml` -> Cloudflare Workers
- `vercel.json` / `netlify.toml` -> Deployment platform
- `.github/workflows/` -> GitHub Actions CI
- `Makefile` / `justfile` -> Build automation
- `turbo.json` / `nx.json` / `lerna.json` -> Monorepo tooling

**State management & data:**
- Check for Riverpod, Bloc, Provider, Redux, Zustand, Jotai, MobX, Pinia
- Check for Prisma, TypeORM, Sequelize, Drizzle, Hive, sqflite, SQLAlchemy
- Check for i18n setup (flutter_localizations, i18next, react-intl, etc.)

**Testing:**
- Check for test directories, test frameworks (jest, vitest, pytest, flutter_test, etc.)
- Check for E2E frameworks (cypress, playwright, detox, etc.)

Present findings as a structured report, organized by sub-project if it's a monorepo.

Use AskUserQuestion: "Here's what I detected about your project stack. Is this accurate? Anything missing, wrong, or that I should know about?"

## Round 2: Project Identity

Use AskUserQuestion to ask (batch these into one question):
1. "What does this project do? Give me a one-sentence description and tell me who the primary users are."
2. "What stage is the project at? (early prototype, MVP, active development, production, maintenance mode)"

If $ARGUMENTS was provided, use it as the project description and only ask about stage.

## Round 3: Team & Workflow

Use AskUserQuestion for each (batch closely related ones):

1. "What project tracker do you use? (Jira, Linear, GitHub Issues, Notion, none, etc.) If applicable, what's the ticket ID format? (e.g., PROJ-123, #123)"
2. "What's your branch naming convention? Examples: `TICKET-123-short-desc`, `feat/short-desc`, `feature/PROJ-123-desc`. If no convention, I'll suggest one."
3. "What's your commit message convention? (conventional commits like `feat:`, `fix:`, free-form, ticket prefix, etc.)"
4. "How do you do code review? (PR reviews on GitHub, pair programming, self-merge for small changes, etc.)"

## Round 4: Architecture & Patterns

Use AskUserQuestion:

1. "Are there architectural patterns I should know about? For example: clean architecture, MVVM, MVC, feature-based folder structure, domain-driven design, hexagonal architecture. Or describe how your code is organized."
2. "Are there specific libraries, frameworks, or patterns that are sacred — things I should never replace, deviate from, or suggest alternatives to?"
3. "Are there known tech debt areas or patterns you're actively migrating away from? (So I avoid reinforcing the old pattern)"

## Round 5: Coding Standards

Use AskUserQuestion:

1. "Any specific coding rules beyond what's standard for your stack? For example: naming conventions, file organization rules, import ordering, max file length, required patterns."
2. "How do you handle testing? Tell me about: required test types (unit, integration, E2E), coverage thresholds, test naming conventions, whether TDD is practiced."
3. "How do you handle i18n/localization? Is it already set up? If so, what library and what's the workflow for adding new strings?"

## Round 6: PRD & Documentation

Use AskUserQuestion:

1. "Do you have existing PRDs, specs, design docs, or architecture decision records? If so, where are they stored? (I'll link them in CLAUDE.md via @import so Claude always has context)"
2. "Any other context I should bake into the CLAUDE.md? Things every contributor (human or AI) should know when working on this project?"

## Round 7: Generate & Review

Based on all gathered information, generate the complete CLAUDE.md with these sections in order:

```
# CLAUDE.md

## Project Identity
[Project description, users, stage, detected stack summary]

## Agent Auto-Delegation (IMPORTANT)

For the following task types, proactively delegate to the named agent without waiting for the user to ask:

| Task type | Agent |
|-----------|-------|
| New features, vague requests, specs, requirements gathering | `requirements-interviewer` |
| Understanding codebase, architecture questions, code exploration | `codebase-researcher` |
| External research, library comparison, ecosystem questions | `deep-research-analyst` |
| Refactors touching 3+ files, migrations, architecture changes | `refactor-orchestrator` |
| Validating any non-trivial plan, spec, review, or implementation | `codex-challenger` |

## Codex Sidekick

- For any task that is not trivial, do your own first pass then challenge it with Codex.
- Codex is advisory only: read, review, and search only. Never let Codex edit files or commit.
- Keep looping until Codex returns `VERDICT: VALIDATED`.
- Helper scripts: `.claude/helpers/codex-challenge.sh`, `.claude/helpers/codex-review.sh`, `.claude/helpers/codex-web-search.sh`

## Standard Workflow
[Generated from Round 3 answers: tracker integration, branch naming, commit conventions, review process]

## Coding Standards
[Stack-specific standards generated from detection + Round 5 answers]

## Architecture
[From Round 4 answers: patterns, sacred libraries, tech debt notes]

## Testing Standards
[From Round 5 answers: required tests, coverage, conventions]

## PRD & Reference Documents
[From Round 6: @import links to PRDs, specs, design docs]
```

### Stack-Specific Coding Standards to generate:

**TypeScript/React/Next.js projects:**
- No `as` type assertions, `any`, `unknown`, or `!` non-null assertions
- Interface for object shapes, type for unions
- Extract props interface when 3+ props
- Named imports over default imports
- One component per file, no barrel exports
- Server components by default, `'use client'` only when needed (Next.js)

**Python projects:**
- Type hints on all function signatures
- Pydantic for data validation where applicable
- Follow existing project structure patterns
- Docstrings for public APIs only

**Flutter/Dart projects:**
- Follow existing state management pattern (detected: Riverpod, Bloc, Provider, etc.)
- Follow existing persistence pattern (detected: Hive, sqflite, etc.)
- Use flutter_localizations for i18n
- Const constructors where possible
- Follow effective Dart guidelines

**Go projects:**
- Follow standard Go project layout
- Error wrapping with fmt.Errorf
- Table-driven tests
- Keep interfaces small

**Cloudflare Workers:**
- Follow wrangler project structure
- Use environment bindings over hardcoded values
- Handle edge cases for cold starts

**For all stacks:**
- No comments in code — clear naming speaks for itself
- Self-documenting code with descriptive names
- Single responsibility functions
- Direct imports, no barrel files

Show the full generated CLAUDE.md to the user.

Use AskUserQuestion: "Here's the generated CLAUDE.md. Please review each section carefully. What would you change, add, or remove? I want this to be a comprehensive and accurate guide for working on your project."

Apply any feedback. If changes are significant, show the updated version and ask for confirmation again.

## Step 8: Write the File

Write to `./CLAUDE.md` in the project root.

If CLAUDE.md already exists, show a diff of what would change and get explicit approval before overwriting. Preserve any custom content that doesn't conflict with the harness template.

Confirm: "CLAUDE.md has been written. You can run `/install-harness` again anytime to update it."
