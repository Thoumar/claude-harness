# Investigate Issue

Perform a detailed investigation of an issue, bug, or feature area to understand root cause, impact, and code paths.

## Instructions

### Step 1: Identify the issue

Look for context in the current conversation. If none found, ask the user:

- What issue or area would you like to investigate?
- What is the problem you're trying to solve?

### Step 2: Discover available tools

List available MCP servers and tools that could help with investigation:

- Project trackers (Jira, Linear, GitHub Issues, etc.)
- Browser automation (for reproducing UI issues)
- Database access
- Monitoring / logging tools
- Any other connected MCPs

Tell the user what tools are available and ask which are relevant for this investigation.

### Step 3: Gather context

Before diving into code, ask the user clarifying questions to narrow the investigation:

- **Reproduction context**: How is this issue reproduced? What are the steps?
- **Error messages**: Are there any error messages, logs, or stack traces?
- **Affected area**: Which part of the application is affected?
- **Recent changes**: Did this start after a specific deployment or change?
- **Frequency**: Does it happen always, sometimes, or under specific conditions?

### Step 4: Choose investigation depth

Ask the user what level of investigation they need:

1. **Quick scan** (~2-3 min) — Find likely files and functions
2. **Medium analysis** (~5-10 min) — Trace code paths and identify impact
3. **Thorough investigation** (~15+ min) — Full analysis with related code paths and broader impact

### Step 5: Perform the investigation

Based on gathered context and chosen depth:

#### Root Cause Analysis
- Identify the most likely files and functions causing the issue
- Search for relevant keywords, error messages, and patterns
- Trace the logic flow to pinpoint where the bug likely occurs

#### Impact Assessment
- What other features or modules could be affected?
- Are there shared utilities or components involved?
- Could fixing this introduce regressions elsewhere?

#### Related Code Paths
- Trace the flow from entry point to the problem area
- Identify all layers involved
- Map dependencies and data flow

### Step 6: Present the report

Display a structured report:

- **Summary** (one paragraph of the issue and likely cause)
- **Root Cause Analysis** (file:line, explanation, confidence level, evidence)
- **Key Files** (table with path, role, relevance)
- **Code Flow** (entry point -> step 1 -> step 2 -> problem area)
- **Impact Assessment** (directly and potentially affected areas)
- **Recommended Approach** (brief suggestion on how to fix)

### Step 7: Offer next actions

1. **Create a branch** — If one doesn't exist for this issue
2. **Start `/plan`** — Turn the investigation into an implementation plan
3. **Run `/codebase-research`** — Expand the investigation with subagents and Codex validation
4. **Create a TODO list** — Break down the fix into actionable steps
5. **Investigate deeper** — Ask more questions and explore further
