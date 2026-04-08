# Deep Research

Perform internet-heavy research on a topic with multiple Codex web search rounds until findings are comprehensive and validated.

## When to Use

- Comparing libraries, frameworks, or tools
- Researching best practices or industry patterns
- Understanding external APIs or services
- Evaluating migration or upgrade paths
- Security vulnerability research
- Technology selection decisions

## Process

### Step 1: Define the Research Question

Clarify with the user:
- What do you need to research?
- What decision will this inform?
- Are there specific options you're already considering?
- What constraints matter? (bundle size, license, performance, maintenance status)

### Step 2: Initial Web Research

Use `.claude/helpers/codex-web-search.sh` for the primary topic.

Parse the results and identify follow-up angles that need deeper investigation.

### Step 3: Deep Dive Rounds

Run additional research rounds, each focused on a specific angle:

**Round 2:** Comparisons and benchmarks
**Round 3:** Known issues, gotchas, and migration guides
**Round 4:** Community sentiment (GitHub issues, discussions, recent blog posts)
**Round 5+:** Any gaps identified in previous rounds

Continue rounds until:
- All key questions are answered
- Sources corroborate each other
- No significant gaps remain

### Step 4: Codebase Context

Read relevant parts of the current codebase to understand:
- How the current solution works (if replacing something)
- Integration points and constraints
- Existing patterns that a new approach must fit

### Step 5: Synthesize

Produce a structured research report:

**Executive Summary**
[2-3 sentences: what was researched and the recommendation]

**Options Evaluated**
| Option | Pros | Cons | Project Fit |
|--------|------|------|-------------|
| ... | ... | ... | Good/Fair/Poor |

**Detailed Comparison**
For each option:
- Maturity and maintenance status (last release, contributor count, issue response time)
- Bundle size / performance characteristics
- API design and developer experience
- Community and ecosystem
- License compatibility
- Migration effort from current state

**Recommendation**
[Clear recommendation with rationale]

**Migration Path** (if applicable)
[Step-by-step approach]

**Risks and Mitigations**
[What could go wrong and how to handle it]

**Sources**
[All URLs and references used]

### Step 6: Codex Validation

Use `.claude/helpers/codex-challenge.sh` to verify:
- Accuracy of claims
- Completeness of comparison
- Reasonableness of recommendation

### Step 7: Present

Share the report with the user. Suggest next steps:
- **`/plan`** to plan the adoption of the recommended option
- **`/feature-interviewer`** to spec out the integration
- **Continue research** on a specific sub-topic
