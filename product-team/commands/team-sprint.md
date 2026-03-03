---
description: Full team (PO A/B, Designer, Developer, Analyst, Marketer) collaboration to plan a sprint
argument-hint: Sprint topic (e.g., "next week sprint", "onboarding improvement sprint")
---

# Team Sprint Planning

The full virtual product team collaborates to plan a sprint.

**Sprint Topic**: $ARGUMENTS

---

## Phase 1: Context Gathering (Parallel)

Invoke the following agents **in parallel**:

### PO A (Data)
> Gather data on the current product state for sprint planning: "$ARGUMENTS"
> 1. Read project CLAUDE.md for North Star metrics and current state
> 2. Query RevenueCat/Amplitude MCP for recent metric trends (when available)
> 3. Summarize data-driven opportunities and problems
> 4. Calculate ICE scores for each opportunity

### PO B (Intuitive)
> Analyze user/market perspective for sprint planning: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Explore Reddit/HN for recent relevant trends and user reactions
> 3. Check recent competitor app updates
> 4. Summarize user-priority features/improvements

### Data Analyst
> Analyze user behavior data for sprint planning: "$ARGUMENTS"
> 1. Check recent user behavior patterns, funnel drop-offs, retention trends
> 2. Identify areas needing measurement
> 3. Audit existing event taxonomy (missing events, unnecessary events)

---

## Phase 2: Opportunity Discussion

Synthesize Phase 1 results and conduct a brief PO A vs PO B discussion.

Invoke PO A and PO B **in parallel** to exchange opinions on each other's opportunity lists.
Apply consensus rules (data clear -> data wins, insufficient -> MVP, low risk -> intuition, high risk -> conservative) to determine priorities.

---

## Phase 3: Design + Measurement (Parallel)

For prioritized items:

### Designer
> Design UI/UX for this sprint's priority items.
> [Pass Phase 2 agreed priority items]
> 1. Scan the project's DesignSystem directory
> 2. Design each item's screen (wireframe, tokens, components)
> 3. Verify consistency with existing design system
> 4. Address accessibility and dark mode considerations

### iOS Developer
> Assess implementation feasibility for this sprint's priority items.
> [Pass Phase 2 agreed priority items]
> 1. Search existing codebase for similar patterns
> 2. Evaluate estimated effort, risks, and required tech per item
> 3. Organize implementation order and dependencies
> 4. Reference SwiftUI Expert/Swift Concurrency skill references

### Data Analyst
> Create measurement plans for this sprint's items.
> [Pass Phase 2 agreed priority items]
> 1. Define success metrics for each item
> 2. Design required analytics events (apply 3-Question filter)
> 3. Propose dashboard configuration

---

## Phase 4: Marketing Plan

### Marketer
> Analyze marketing/growth opportunities for this sprint.
> [Pass Phase 2-3 summary]
> 1. Evaluate marketing material value of sprint deliverables
> 2. Discover Build in Public content material
> 3. Identify ASO optimization points for launch/update
> 4. Propose platform-specific content strategy

---

## Phase 5: Sprint Document

Compile all Phase results into a sprint planning document.

Follow the sprint-planning skill structure:
- Sprint goal, North Star connection
- Metric targets
- Must Have / Nice to Have / Won't Do backlog
- Schedule
- Risks
- Success criteria

---

## Save Deliverables

Save sprint document to `docs/sprints/YYYY-MM-DD-sprint.md`.
Save any decisions to `docs/decisions/` as separate files.

Verify directories exist before saving; create them if needed.
