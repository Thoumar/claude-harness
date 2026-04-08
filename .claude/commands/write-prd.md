---
name: write-prd
description: Interview the user about product requirements and write a PRD document linked in CLAUDE.md.
disable-model-invocation: true
argument-hint: "[feature or product name]"
---

# Write PRD (Product Requirements Document)

Create a non-technical product requirements document through deep user interview. This is a thorough, multi-round process — the goal is to extract a complete, unambiguous specification.

## Round 1: Problem Space

Use AskUserQuestion for each (batch closely related ones):

1. "What problem does this solve? Who experiences this problem, and what does their current workaround look like?"
2. "How painful is this problem on a scale of 1-5? (1 = mild inconvenience, 3 = daily friction, 5 = complete blocker) How many users are affected?"
3. "What triggered building this now? Was there a specific event, user complaint, business goal, or competitive pressure?"

## Round 2: Users & Personas

Use AskUserQuestion:

1. "Who are the primary users of this feature? Describe them — their role, technical skill level, what they care most about, and their typical behavior."
2. "Are there secondary users or stakeholders who'll interact with this differently? (e.g., admins, support staff, API consumers)"
3. "Walk me through a typical user's day — at what moment would they encounter this feature? What were they doing before, and what do they do after?"

## Round 3: Desired Outcome

Use AskUserQuestion:

1. "What should the user be able to do after this is built that they can't do today? Describe the ideal end state in concrete terms."
2. "What does success look like from the user's perspective? And separately, from the business perspective?"
3. "Are there specific metrics you'll use to measure success? Examples: conversion rate, time-to-task completion, retention rate, NPS score, revenue impact, support ticket reduction."

## Round 4: Scope & Boundaries

Use AskUserQuestion:

1. "What is explicitly OUT of scope? What should this feature NOT do, even if it seems related or users might ask for it?"
2. "Are there features that are tempting to include but should be deferred to a later phase? What would phase 2 look like?"
3. "Are there hard constraints I should know about? Timeline, budget, platform limitations (iOS only? web only?), third-party API limits, regulatory requirements (GDPR, HIPAA), accessibility requirements."

## Round 5: Requirements Prioritization

Based on everything gathered so far, draft a requirements list and present it.

Use AskUserQuestion: "Here are the requirements I've extracted from our conversation. For each one, tell me: **Must Have** (launch blocker), **Should Have** (important but not blocking), or **Nice to Have** (would be great but can wait). Also tell me if I missed anything."

Use AskUserQuestion: "For the Must Have items — are there any that have dependencies on each other? Does anything need to be built in a specific order?"

## Round 6: Edge Cases & Risks

Use AskUserQuestion:

1. "What could go wrong? What are the riskiest assumptions we're making? What would make this feature fail even if we build it correctly?"
2. "Are there specific edge cases or error states we need to handle? Think about: empty states, maximum limits, concurrent access, offline behavior, data migration from existing state."
3. "Are there existing features this might conflict with or need to integrate with? Any shared data, overlapping UI, or behavioral expectations?"

## Round 7: References & Prior Art

Use AskUserQuestion:

1. "Are there competitors or existing products that do something similar? What do they do well? What do they do poorly that we should avoid?"
2. "Do you have mockups, wireframes, designs, or prototypes? If so, where are they? (I'll reference them in the PRD)"
3. "Is there any other context — user research, analytics data, support tickets, previous attempts — that would help me write a better PRD?"

## Round 8: Draft Review

Generate the complete PRD document with this structure:

```markdown
# PRD: [Feature Name]

**Author:** [user name if known, otherwise "Generated via /write-prd"]
**Date:** [current date]
**Status:** Draft

## Problem Statement
[What problem, who has it, current pain, why now]

## Goals
[Numbered list of what success looks like — user goals and business goals]

## Non-Goals
[What this explicitly will NOT address, with brief rationale for each]

## User Personas

### Primary: [Persona Name]
[Role, skill level, needs, typical behavior]

### Secondary: [Persona Name] (if applicable)
[Role, how they interact differently]

## User Journey
[Step-by-step walkthrough of the user's experience with this feature]

## Requirements

### Must Have (P0)
[Numbered list with clear, testable acceptance criteria for each]

### Should Have (P1)
[Numbered list]

### Nice to Have (P2)
[Numbered list]

## Success Metrics
| Metric | Current Baseline | Target | How to Measure |
|--------|-----------------|--------|----------------|
| ... | ... | ... | ... |

## Edge Cases & Error States
[Specific scenarios and expected behavior for each]

## Constraints & Dependencies
- **Timeline:** [if specified]
- **Technical:** [platform, API, or infrastructure constraints]
- **External:** [third-party dependencies, regulatory requirements]
- **Dependencies:** [features or systems that must exist first]

## Risks & Mitigations
| Risk | Likelihood | Impact | Mitigation |
|------|-----------|--------|------------|
| ... | High/Med/Low | High/Med/Low | ... |

## References
- [Competitor examples, mockups, research, related docs]

## Open Questions
[Unresolved items that need answers before or during implementation]
```

Show the full PRD to the user.

Use AskUserQuestion: "Here's the complete PRD. Please review each section carefully — is anything inaccurate, missing, or over-specified? I want this to be a source of truth for implementation."

Apply feedback. If changes are significant, show the updated version and confirm again.

## Step 9: Write & Link

Create the directory if needed: `.claude/prd/`

Write the PRD to `.claude/prd/[feature-name].md` (kebab-case the feature name).

Link in CLAUDE.md:
- If CLAUDE.md exists and has a `## PRD` or `## PRD & Reference Documents` section, append: `@.claude/prd/[feature-name].md`
- If CLAUDE.md exists but has no PRD section, add one at the bottom
- If CLAUDE.md doesn't exist, tell the user: "No CLAUDE.md found. Run `/install-harness` first to set up the project configuration, then the PRD will be automatically linked."

## Step 10: Suggest Next Steps

After writing the PRD, suggest:
- **`/feature-interviewer`** — Turn this PRD into a detailed technical spec
- **`/plan`** — Create an implementation plan directly from the PRD
- **`/investigate`** — Investigate the codebase areas this PRD will affect
