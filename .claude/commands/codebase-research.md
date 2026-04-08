# Codebase Research

Perform deep exploration of how part of the codebase works using subagents and Codex synthesis.

## When to Use

- Understanding a complex module or feature before making changes
- Onboarding to an unfamiliar part of the codebase
- Mapping dependencies and data flow across modules
- Preparing for a refactor by understanding blast radius

## Process

### Step 1: Define the Research Question

Ask the user what they want to understand:
- A specific feature or module?
- A data flow or code path?
- How a library or pattern is used?
- Relationships between components?

### Step 2: Launch Parallel Exploration

Use the Agent tool with `subagent_type: "Explore"` to search in parallel. Launch up to 3 agents with different focus areas:

**Example split for a feature investigation:**
- Agent 1: Core implementation files and data models
- Agent 2: UI/presentation layer and user-facing behavior
- Agent 3: Tests, utilities, and integration points

**Example split for a data flow investigation:**
- Agent 1: Entry points and input handling
- Agent 2: Business logic and transformations
- Agent 3: Output, persistence, and side effects

### Step 3: Synthesize Findings

Combine the subagent results into a structured report:

**Architecture Overview**
- How the pieces fit together
- ASCII diagram of the component relationships

**Key Files**
| File | Purpose | Key Functions |
|------|---------|---------------|
| ... | ... | ... |

**Code Flow**
Entry point -> Step 1 -> Step 2 -> ... -> Output

**Patterns & Conventions**
- State management approach used here
- Error handling strategy
- Naming conventions specific to this area

**Dependencies**
- Internal: other modules this depends on
- External: libraries, APIs, services

**Observations**
- Design decisions worth noting
- Potential issues or tech debt
- Well-structured areas vs. fragile areas

### Step 4: Codex Validation

Use `.claude/helpers/codex-challenge.sh` to verify:
- Accuracy of the analysis
- Missing code paths or edge cases
- Anything the exploration overlooked

### Step 5: Present & Suggest Next Steps

Present the report to the user. Suggest:
- **Investigate deeper**: Drill into a specific area
- **`/plan`**: Plan changes based on the research
- **`/feature-interviewer`**: Design a feature that touches this area
- **`/large-refactor`**: Refactor this area if issues were found
