---
description: Full team (PO A/B, Designer, Developer, Analyst, Marketer) collaboration to plan a sprint
argument-hint: Sprint topic (e.g., "next week sprint", "onboarding improvement sprint")
---

# Team Sprint Planning

The full virtual product team collaborates to plan a sprint.

**Sprint Topic**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("team-sprint")`
2. Spawn Phase 1 agents (Designer, Developer, Marketer spawn later):
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
   - **Analyst** (product-team:data-analyst, name: "Analyst")
3. Create Phase 1-2 tasks:

```
Task 1: "PO-A Data-driven Opportunity Analysis" — assign to PO-A (parallel)
Task 2: "PO-B User/Market Perspective" — assign to PO-B (parallel)
Task 3: "Analyst User Behavior Analysis" — assign to Analyst (parallel)
Task 4: "PO-A Cross-evaluate Opportunity List" — assign to PO-A (blockedBy: [1,2,3])
Task 5: "PO-B Cross-evaluate Opportunity List" — assign to PO-B (blockedBy: [1,2,3])
Task 6: "Lead Consensus + Priority Decision" — Lead handles (blockedBy: [4,5])
```

Tasks 7-11 are created progressively as later Phases begin.

---

## Phase 1: Context Gathering (Parallel)

Send tasks to 3 agents simultaneously via SendMessage:

### To PO-A:
> Gather data on the current product state for sprint planning: "$ARGUMENTS"
> 1. Read project CLAUDE.md for North Star metrics and current state
> 2. Query RevenueCat/Amplitude MCP for recent metric trends (when available)
> 3. Summarize data-driven opportunities and problems
> 4. Calculate ICE scores for each opportunity
> Mark Task 1 as completed when done.

### To PO-B:
> Analyze user/market perspective for sprint planning: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Explore Reddit/HN for recent relevant trends and user reactions
> 3. Check recent competitor app updates
> 4. Summarize user-priority features/improvements
> Mark Task 2 as completed when done.

### To Analyst:
> Analyze user behavior data for sprint planning: "$ARGUMENTS"
> 1. Check recent user behavior patterns, funnel drop-offs, retention trends
> 2. Identify areas needing measurement
> 3. Audit existing event taxonomy (missing events, unnecessary events)
> Mark Task 3 as completed when done.

---

## Phase 2: Opportunity Discussion

When Tasks 1-3 complete, Lead forwards combined results to both POs via SendMessage:

### To PO-A (SendMessage):
> Here are all Phase 1 results. Evaluate PO-B's opportunity list and Analyst's findings:
> [PO-B results summary] [Analyst results summary]
> Which opportunities do you agree/disagree with? Apply consensus rules.
> Mark Task 4 as completed when done.

### To PO-B (SendMessage):
> Here are all Phase 1 results. Evaluate PO-A's opportunity list and Analyst's findings:
> [PO-A results summary] [Analyst results summary]
> Which opportunities do you agree/disagree with? Apply consensus rules.
> Mark Task 5 as completed when done.

### Lead (Task 6):
When Tasks 4-5 complete, Lead synthesizes consensus and determines priorities.
Apply consensus rules: data clear -> data wins, insufficient -> MVP, low risk -> intuition, high risk -> conservative.

---

## Phase 3: Design + Measurement (Parallel)

After Task 6 completes:

1. **Spawn Designer and Developer** via Agent tool with `team_name: "team-sprint"`. Include Phase 2 priority summary in spawn prompts.
   - **Designer** (product-team:app-designer, name: "Designer")
   - **Developer** (product-team:ios-developer, name: "Developer")
2. Create Phase 3 tasks:

```
Task 7: "Designer UI/UX Design" — assign to Designer (blockedBy: [6])
Task 8: "Developer Implementation Review" — assign to Developer (blockedBy: [6])
Task 9: "Analyst Measurement Plan" — assign to Analyst (blockedBy: [6])
```

### To Designer (included in spawn prompt + SendMessage):
> Design UI/UX for this sprint's priority items.
> [Phase 2 agreed priority items]
> 1. Scan the project's DesignSystem directory
> 2. Design each item's screen (wireframe, tokens, components)
> 3. Verify consistency with existing design system
> 4. Address accessibility and dark mode considerations
> Mark Task 7 as completed when done.

### To Developer (included in spawn prompt + SendMessage):
> Assess implementation feasibility for this sprint's priority items.
> [Phase 2 agreed priority items]
> 1. Search existing codebase for similar patterns
> 2. Evaluate estimated effort, risks, and required tech per item
> 3. Organize implementation order and dependencies
> 4. Reference SwiftUI Expert/Swift Concurrency skill references
> Mark Task 8 as completed when done.

### To Analyst (SendMessage — already spawned):
> Create measurement plans for this sprint's items.
> [Phase 2 agreed priority items]
> 1. Define success metrics for each item
> 2. Design required analytics events (apply 3-Question filter)
> 3. Propose dashboard configuration
> Mark Task 9 as completed when done.

---

## Phase 4: Marketing Plan

After Tasks 7-9 complete:

1. **Spawn Marketer** via Agent tool with `team_name: "team-sprint"`. Include Phase 2-3 summary in spawn prompt.
   - **Marketer** (product-team:marketer, name: "Marketer")
2. Create Phase 4 task:

```
Task 10: "Marketer Growth Strategy" — assign to Marketer (blockedBy: [7,8,9])
```

### To Marketer (included in spawn prompt + SendMessage):
> Analyze marketing/growth opportunities for this sprint.
> [Phase 2-3 summary]
> 1. Evaluate marketing material value of sprint deliverables
> 2. Discover Build in Public content material
> 3. Identify ASO optimization points for launch/update
> 4. Propose platform-specific content strategy
> Mark Task 10 as completed when done.

---

## Phase 5: Sprint Document (Lead)

After Task 10 completes, Lead compiles the sprint document:

```
Task 11: "Lead Sprint Document Compile" — Lead handles (blockedBy: [10])
```

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

---

## Cleanup

1. Send `shutdown_request` to all teammates (PO-A, PO-B, Analyst, Designer, Developer, Marketer) via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
