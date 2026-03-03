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
| apple-latest-apis | | | Participate | Participate | | |
| user-data-analysis | Participate | | | | Lead | |
| event-taxonomy | | | | | Exclusive | |
| viral-feature-finder | | | | | | Exclusive |
| sprint-planning | O | O | O | O | O | O |
| decision-log | O | O | O | O | O | O |
