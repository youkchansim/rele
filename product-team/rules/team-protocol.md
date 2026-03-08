# Product Team Protocol

## Team Composition

| Role | Agent | Model | Core Responsibility |
|------|-------|-------|-------------------|
| PO A | po-data-driven | opus | Data-driven decisions, metric analysis, ICE framework |
| PO B | po-intuitive | opus | User empathy, competitive analysis, UX value judgment |
| Designer | app-designer | opus | UI/UX design, design system, HIG compliance, accessibility |
| iOS Developer | ios-developer | opus | Implementation feasibility, architecture, Swift/SwiftUI |
| Data Analyst | data-analyst | sonnet | Event design, funnel/retention analysis, A/B testing |
| Marketer | marketer | sonnet | Trends, viral strategy, ASO, content |

## Communication Rules

1. **Structured Output**: Each team member uses role name as header
2. **Evidence Required**: Every argument must cite data, examples, or principles
3. **Constructive Criticism**: Opposing views must include alternatives
4. **Decision Recording**: Important decisions are recorded in `docs/decisions/`

## Decision Protocol

### PO Debate Consensus Rules
1. **Data clear** -> Data wins
2. **Data insufficient** -> MVP validation
3. **Low risk** -> Try intuition
4. **High risk** -> Conservative approach

### Go/No-Go Criteria
- 4+ of 6 team members approve -> Go
- Critical technical issue (Developer opposes) -> Conditional Hold
- Unclear metric impact (PO A opposes) -> Validate hypothesis first

## Artifact Storage Rules

| Type | Location | Filename Convention |
|------|----------|-------------------|
| Sprint plans | `docs/sprints/` | `YYYY-MM-DD-sprint.md` |
| Decisions | `docs/decisions/` | `YYYY-MM-DD-{topic}.md` |
| Retrospectives | `docs/retros/` | `YYYY-MM-DD-retro.md` |

## Project Context Loading

All team members check the following before starting work:
1. **Project CLAUDE.md** — North Star, tech stack, key metrics
2. **Latest sprint record** — Most recent file in `docs/sprints/`
3. **Active decisions** — Most recent files in `docs/decisions/`

## Skill Sharing Matrix

| Skill | PO A | PO B | Designer | Developer | Analyst | Marketer |
|-------|:----:|:----:|:--------:|:---------:|:-------:|:--------:|
| hypothesis-framework | Lead | Participate | | | | |
| competitor-analysis | | Lead | | | | Participate |
| design-system-ios | | | Exclusive | | | |
| design-recommend-ios | | | Exclusive | | | |
| screenshot-to-swiftui | | | Exclusive | | | |
| apple-latest-apis | | | Participate | Participate | | |
| user-data-analysis | Participate | | | | Lead | |
| event-taxonomy | | | | | Exclusive | |
| viral-feature-finder | | | | | | Exclusive |
| sprint-planning | O | O | O | O | O | O |
| decision-log | O | O | O | O | O | O |

## Agent Team Communication Protocol

### Team Structure
- All commands create a team via TeamCreate and spawn teammates via Agent tool with `team_name`
- Lead (Main Session) manages tasks, evaluates Gates, and compiles documents
- Teammates work as independent instances, communicating via SendMessage

### Teammate Spawning Rules
1. **Gate-based commands** (product-pipeline): Spawn teammates progressively per Phase (saves tokens)
2. **Gate-free commands** (feature-review, growth-audit): Spawn all needed teammates at once
3. **Reuse spawned teammates**: For already-spawned teammates, send new tasks via SendMessage instead of re-spawning
4. **Context in prompt**: When spawning new teammates mid-pipeline, include previous Phase result summaries in the Agent prompt

### Context Forwarding
- **New teammate spawn**: Include previous Phase result summary in Agent `prompt` parameter
- **Existing teammate**: Forward new Task + context via SendMessage
- **Lead compiles**: After each Phase, Lead writes a structured summary extracting only key decisions, metrics, and rationale (not raw output)

### Cleanup Protocol
1. Send `shutdown_request` to all teammates via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call TeamDelete to remove team and task directories

## Pipeline Protocol

### `/product-pipeline` Flow
```
Debate -> Hypothesis -> Review -> Design -> Monitoring Plan
          GATE 1 ^            GATE 2 ^
```

### Gate Rules
- **Gate 1** (after debate): "don't pursue" consensus -> pipeline stops
- **Gate 2** (after review): No-Go / Conditional Hold -> pipeline stops with decision document

### Gate Early Termination
When a Gate stops the pipeline:
1. Save all results collected so far to the document
2. Include clear stop reason and recommendations
3. Run Cleanup Protocol (shutdown all teammates + TeamDelete)

### Lazy Task Creation
For gated commands (product-pipeline), only create tasks for the current Phase. Create next Phase tasks only after Gate passage is confirmed. This prevents wasted task setup for pipelines that stop early.
