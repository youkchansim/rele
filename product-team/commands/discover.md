---
description: Discovery workflow to find product opportunities using OST and Assumption Mapping
argument-hint: Discovery topic (e.g., "user onboarding pain points", "scheduling friction")
---

# Product Discovery

PO B-led Discovery workflow using Opportunity Solution Tree and Assumption Mapping.

**Topic**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("discover")`
2. Spawn agents:
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
   - **Analyst** (product-team:data-analyst, name: "Analyst")
3. Create tasks with dependencies:

```
Task 1: "PO-B Opportunity Discovery via OST" — assign to PO-B
Task 2: "PO-B Assumption Mapping" — assign to PO-B (blockedBy: [1])
Task 3: "Analyst Data Validation" — assign to Analyst (blockedBy: [2])
Task 4: "Lead Integration — Prioritized Assumptions + Experiment Design" — Lead handles (blockedBy: [3])
```

---

## Phase 1: Opportunity Discovery (PO-B — Task 1)

Send to PO-B via SendMessage:
> Discover product opportunities for: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and current product state
> 2. Search Reddit and HN for related user pain points and discussions
> 3. WebSearch for competitor approaches to this problem space
> 4. Build an Opportunity Solution Tree:
>    - Outcome: [relevant business metric to improve]
>    - Opportunities: [3-5 user needs/pain points discovered]
>    - Solutions: [2-3 potential solutions per opportunity]
> 5. Use the product-discovery skill for OST structure
> Mark Task 1 as completed when done.

---

## Phase 2: Assumption Mapping (PO-B — Task 2)

When Task 1 completes, send to PO-B via SendMessage:
> Based on your OST from Phase 1, map assumptions for the top opportunities:
> 1. List key assumptions for each top solution (minimum 5 assumptions)
> 2. Categorize each assumption by risk type (Desirability, Viability, Feasibility, Usability)
> 3. Map on Impact x Evidence matrix (High Impact + Low Evidence = test first)
> 4. Prioritize: rank assumptions by test priority
> 5. Use the product-discovery skill for assumption mapping framework
> Mark Task 2 as completed when done.

---

## Phase 3: Data Validation (Analyst — Task 3)

When Task 2 completes, send to Analyst via SendMessage:
> Review the assumptions mapped by PO-B:
> [Include PO-B's assumption mapping results]
> 1. Check which assumptions can be validated with existing data (Amplitude/RevenueCat)
> 2. For data-validatable assumptions: run queries and provide evidence
> 3. For non-data assumptions: recommend experiment type (survey, prototype test, fake door)
> 4. Estimate effort and timeline for each validation approach
> Mark Task 3 as completed when done.

---

## Phase 4: Integration (Lead — Task 4)

When Task 3 completes, Lead synthesizes:
1. Merge PO-B's OST + Assumption Map with Analyst's validation findings
2. Create prioritized assumption list with validation plan
3. Design experiment proposals for top 3 assumptions

### Output Format

```markdown
# Discovery Report: [Topic]
Date: YYYY-MM-DD

## Opportunity Solution Tree
[Visual tree: Outcome → Opportunities → Solutions]

## Assumption Map
| # | Assumption | Risk Type | Impact | Evidence | Priority |
|---|-----------|-----------|--------|----------|----------|
| 1 | | | | | |

## Data Validation Results
[Analyst findings — what data confirms/denies]

## Experiment Design
### Experiment 1: [Top assumption]
- Method: [prototype/fake door/survey/data analysis]
- Hypothesis: [If we..., then...]
- Success criteria: [Measurable threshold]
- Effort: [Timeline]

## Recommended Next Steps
- [ ] [Action item 1]
- [ ] [Action item 2]
```

---

## Save Deliverables

Save to `docs/decisions/YYYY-MM-DD-discovery-{topic-summary}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to PO-B and Analyst via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
