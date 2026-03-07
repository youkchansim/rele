---
description: Collaborative product strategy development using Strategy Canvas
argument-hint: Strategy topic (e.g., "2024 product direction", "monetization strategy")
---

# Product Strategy

PO A + PO B collaborative strategy development using Strategy Canvas.

**Topic**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("strategy")`
2. Spawn agents **simultaneously**:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
3. Create tasks with dependencies:

```
Task 1: "PO-A Business Metrics Analysis" — assign to PO-A (parallel)
Task 2: "PO-B Market Environment Analysis" — assign to PO-B (parallel)
Task 3: "Lead Strategy Canvas Draft" — Lead handles (blockedBy: [1, 2])
Task 4: "PO-A Canvas Review & Critique" — assign to PO-A (blockedBy: [3])
Task 5: "PO-B Canvas Review & Critique" — assign to PO-B (blockedBy: [3])
Task 6: "Lead Final Strategy Canvas" — Lead handles (blockedBy: [4, 5])
```

---

## Phase 1: Parallel Analysis

Send to both POs simultaneously via SendMessage:

### To PO-A:
> Analyze current business state for strategy development: "$ARGUMENTS"
> 1. Read project CLAUDE.md for North Star metrics and current state
> 2. Query RevenueCat MCP for revenue/subscription metrics (when available)
> 3. Query Amplitude MCP for user behavior and engagement data (when available)
> 4. Summarize: current metrics health, growth trajectory, key business strengths/weaknesses
> 5. Use the product-strategy skill for strategic framework
> Mark Task 1 as completed when done.

### To PO-B:
> Analyze market environment for strategy development: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target market and positioning
> 2. Conduct SWOT analysis of current product position
> 3. Analyze competitive landscape (Reddit/HN community sentiment + WebSearch)
> 4. Identify key market opportunities and threats
> 5. Use the product-strategy and market-analysis skills for frameworks
> Mark Task 2 as completed when done.

---

## Phase 2: Strategy Canvas Draft (Lead — Task 3)

When Tasks 1-2 complete, Lead creates Strategy Canvas draft:

Using the product-strategy skill's Strategy Canvas template, fill all 9 sections:
1. **Vision** — Synthesize from both PO inputs
2. **Target Segments** — From PO-B's market analysis
3. **Pain Points** — Combined from both analyses
4. **Value Propositions** — Differentiation from competitive analysis
5. **Trade-offs** — What we deliberately won't do
6. **Key Metrics** — From PO-A's metrics analysis
7. **Growth Engine** — Based on current traction data
8. **Core Capabilities** — Technical and product advantages
9. **Defensibility** — Moats identified from market analysis

---

## Phase 3: Parallel Review (PO-A + PO-B)

Send Canvas draft to both POs simultaneously via SendMessage:

### To PO-A:
> Review the Strategy Canvas draft below from a data/business perspective:
> [Canvas draft]
> 1. Validate metrics section against actual data
> 2. Challenge growth assumptions with evidence
> 3. Suggest modifications with data-backed reasoning
> 4. Score confidence (1-10) for each section
> Mark Task 4 as completed when done.

### To PO-B:
> Review the Strategy Canvas draft below from a user/market perspective:
> [Canvas draft]
> 1. Validate target segments against community insights
> 2. Challenge value propositions from user empathy standpoint
> 3. Identify missing market opportunities or threats
> 4. Score confidence (1-10) for each section
> Mark Task 5 as completed when done.

---

## Phase 4: Final Strategy Canvas (Lead — Task 6)

When Tasks 4-5 complete, Lead finalizes:
1. Integrate PO-A and PO-B review feedback
2. Resolve conflicting recommendations
3. Produce final Strategy Canvas

### Output Format

```markdown
# Product Strategy: [Topic]
Date: YYYY-MM-DD

## Strategy Canvas

### 1. Vision
[3-5 year product vision]

### 2. Target Segments
[Primary and secondary segments with characteristics]

### 3. Pain Points
[Top pain points per segment]

### 4. Value Propositions
[Unique value per segment + differentiation]

### 5. Trade-offs
[What we deliberately won't do and why]

### 6. Key Metrics
| Metric | Current | Target | Timeline |
|--------|---------|--------|----------|
| North Star | | | |
| Revenue | | | |
| Retention | | | |

### 7. Growth Engine
[Primary growth mechanism + supporting channels]

### 8. Core Capabilities
[Technical and organizational advantages]

### 9. Defensibility
[Moats and competitive advantages]

## Confidence Assessment
| Section | PO-A Score | PO-B Score | Notes |
|---------|-----------|-----------|-------|
| Vision | /10 | /10 | |
| Target Segments | /10 | /10 | |
| Pain Points | /10 | /10 | |
| Value Propositions | /10 | /10 | |
| Trade-offs | /10 | /10 | |
| Key Metrics | /10 | /10 | |
| Growth Engine | /10 | /10 | |
| Core Capabilities | /10 | /10 | |
| Defensibility | /10 | /10 | |

## Strategic Priorities (Next Quarter)
1. [Priority 1]
2. [Priority 2]
3. [Priority 3]

## Key Risks & Mitigations
- [Risk 1]: [Mitigation]
- [Risk 2]: [Mitigation]
```

---

## Save Deliverables

Save to `docs/decisions/YYYY-MM-DD-strategy-{topic-summary}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to PO-A and PO-B via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
