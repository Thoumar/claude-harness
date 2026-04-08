# Claude Harness

A portable Claude Code harness template. Drop it into any codebase to get structured workflows, Codex validation, and agent delegation out of the box.

## What This Is

A `.claude/` directory you copy into your project that gives Claude Code:

- **10 slash commands** for structured workflows (planning, implementation, research, investigation)
- **5 specialized agents** that Claude auto-delegates to based on task type
- **Codex integration** as a read-only adversarial reviewer
- **Automatic stack detection** that generates project-specific CLAUDE.md configuration
- **Permission guardrails** (read/search always allowed; write/delete asks first)

## Prerequisites

- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) installed
- (Optional) [Codex CLI](https://github.com/openai/codex) for validation loops

## Quick Start

### One-liner install (recommended)

```bash
cd /path/to/your-project
curl -fsSL https://raw.githubusercontent.com/Thoumar/claude-harness/main/install.sh | bash
```

Then open Claude Code and run `/install-harness` to generate your project-specific `CLAUDE.md`.

### Manual copy

```bash
# Clone and copy
git clone https://github.com/Thoumar/claude-harness.git /tmp/claude-harness
cp -r /tmp/claude-harness/.claude /path/to/your-project/
cp /tmp/claude-harness/CLAUDE.md /path/to/your-project/
rm -rf /tmp/claude-harness
```

### Git Subtree (stays synced with upstream)

```bash
cd /path/to/your-project
git subtree add --prefix=.claude https://github.com/Thoumar/claude-harness main --squash
```

> **IMPORTANT**: After installing, run `/install-harness` inside Claude Code. This detects your tech stack and generates a project-specific `CLAUDE.md` with coding standards, workflow configuration, and agent delegation rules. Without it, the harness uses generic defaults.

## Commands

| Command | Purpose |
|---------|---------|
| `/install-harness` | Detect project stack, generate/upgrade CLAUDE.md |
| `/write-prd` | Write a product requirements document through deep interview |
| `/feature-interviewer` | Turn ideas into technical specs with Codex validation |
| `/investigate` | Issue investigation with root cause analysis and MCP discovery |
| `/codebase-research` | Deep codebase exploration with subagents and Codex synthesis |
| `/deep-research` | Internet-heavy research with multiple Codex web search rounds |
| `/plan` | Implementation planning with Codex validation |
| `/implement` | Execute implementation plans with quality checks |
| `/large-refactor` | High-blast-radius work in bounded, validated slices |
| `/commit` | Stage, commit, push, and optionally create a PR |

## Agents

These are auto-delegated based on the task type (configured in CLAUDE.md):

| Agent | Handles |
|-------|---------|
| `requirement-interviewer` | New features, specs, requirements gathering |
| `codebase-researcher` | Architecture questions, code exploration |
| `deep-research-analyst` | Library comparison, ecosystem research |
| `refactor-orchestrator` | Multi-file refactors, migrations |
| `codex-challenger` | Validation loops, adversarial review |

## Directory Structure

```
.claude/
├── settings.json                  # Permissions + hooks
├── agents/                        # Agent definitions
│   ├── codebase-researcher.md
│   ├── codex-challenger.md
│   ├── deep-research-analyst.md
│   ├── refactor-orchestrator.md
│   └── requirement-interviewer.md
├── commands/                      # Slash commands
│   ├── install-harness.md
│   ├── write-prd.md
│   ├── codebase-research.md
│   ├── commit.md
│   ├── deep-research.md
│   ├── feature-interviewer.md
│   ├── implement.md
│   ├── investigate.md
│   ├── large-refactor.md
│   └── plan.md
├── context/                       # Shared context files
│   └── codex-sidekick-preamble.md
├── helpers/                       # Shell scripts for Codex invocation
│   ├── codex-challenge.sh
│   ├── codex-review.sh
│   └── codex-web-search.sh
├── hooks/                         # Session hooks
│   ├── codex-readonly-guard.sh
│   └── startup-command-guide.sh
├── prd/                           # Generated PRDs (gitignored)
└── skills/                        # Skill definitions
    ├── codebase-research/SKILL.md
    ├── codex-sidekick/SKILL.md
    ├── deep-research/SKILL.md
    ├── feature-interviewer/SKILL.md
    └── large-refactor/SKILL.md
```

## How It Works

1. **`/install-harness`** interviews you about your project (stack, workflow, standards) and generates a `CLAUDE.md` tailored to your codebase
2. **CLAUDE.md** tells Claude which agents to auto-delegate to and what coding standards to follow
3. **Slash commands** provide structured workflows for common tasks
4. **Codex** runs as a read-only sidekick that challenges plans, reviews code, and validates implementations
5. **Hooks** enforce guardrails (Codex can't edit files, commands are listed at session start)

## Customization

- **Add your own commands**: Create `.md` files in `.claude/commands/`
- **Add your own agents**: Create `.md` files in `.claude/agents/`
- **Modify coding standards**: Edit your project's CLAUDE.md (regenerate with `/install-harness`)
- **Disable Codex**: Remove Codex references from commands and CLAUDE.md if you don't use it

## License

MIT
