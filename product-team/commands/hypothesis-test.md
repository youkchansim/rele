---
description: Structure an idea into a testable hypothesis with measurement plan
argument-hint: Idea to validate (e.g., "Moving the paywall after onboarding will increase conversion")
---

# Hypothesis Test Design

PO A (Data), PO B (Intuitive), and Data Analyst collaborate to structure an idea into a testable hypothesis.

**Idea**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("hypothesis-test")`
2. Spawn PO agents **simultaneously** (Analyst spawns later in Phase 3):
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
3. Create initial tasks:

```
Task 1: "PO-A 데이터 기반 가설" — assign to PO-A (병렬)
Task 2: "PO-B 사용자 관점 보완" — assign to PO-B (병렬)
Task 3: "Lead 가설 통합" — Lead handles (blockedBy: [1, 2])
```

Tasks 4-5 are created after Task 3 completes (when Analyst is spawned).

---

## Phase 1: Hypothesis Structuring (Parallel)

### To PO-A (SendMessage):
> Structure the following idea into a data-based hypothesis: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics
> 2. Query related data (RevenueCat/Amplitude MCP)
> 3. Hypothesis format: "If we [change], then [metric] will improve by [target], because [evidence]"
> 4. Calculate ICE score
> 5. Define clear success/failure criteria
> Mark Task 1 as completed when done.

### To PO-B (SendMessage):
> Complement the following idea from a user perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users
> 2. Explore Reddit/HN for user reactions to similar features/ideas
> 3. Assess the impact of this change on the user journey
> 4. Find competitor attempts and their results
> 5. Predict user reactions (positive/negative)
> Mark Task 2 as completed when done.

---

## Phase 2: Hypothesis Integration (Lead)

When Task 1 and Task 2 complete, Lead integrates both perspectives (Task 3):

```markdown
## Hypothesis: [Title]

### Hypothesis Statement
If we [change/action],
then [target users]' [behavior/metric]
will change by [direction + target amount].
Because [evidence/mechanism].

### ICE Score
- Impact: ? (Evidence: ...)
- Confidence: ? (Evidence: ...)
- Ease: ? (Evidence: ...)
- Total: I x C x E = ?

### Success Metrics
- Primary KPI: [Metric] — current -> target
- Secondary KPI: [Supporting metric]
- Guard Rail: [Metric that must not degrade]
```

---

## Phase 3: Measurement Plan

After Task 3 completes:

1. **Spawn Analyst**: (product-team:data-analyst, name: "Analyst") via Agent tool with `team_name: "hypothesis-test"`. Include Phase 2 hypothesis summary in the spawn prompt.
2. Create remaining tasks:

```
Task 4: "Analyst 측정 계획" — assign to Analyst (blockedBy: [3])
Task 5: "Lead 최종 검증 계획 컴파일" — Lead handles (blockedBy: [4])
```

### To Analyst (included in spawn prompt + SendMessage):
> Create a measurement plan for the following hypothesis:
> [Phase 2 integrated hypothesis]
> 1. Design required events using 3-Question filter
> 2. Decide A/B test vs Before-After approach
> 3. Calculate sample size and validation duration
> 4. Propose dashboard/alert configuration
> 5. Check if existing events can be reused
> Mark Task 4 as completed when done.

---

## Phase 4: Final Hypothesis Validation Plan (Lead)

When Task 4 completes, Lead compiles the final document (Task 5):

```markdown
# Hypothesis Validation Plan: [Title]

## Hypothesis
[Integrated hypothesis statement]

## Validation Design
- Method: [A/B test / Before-After / Qualitative feedback]
- Duration: [N days/weeks]
- Sample: [N users]

## Event Map
| Event Name | Trigger | Properties |
|------------|---------|------------|
| | | |

## Decision Criteria
- Success: [Condition]
- Failure: [Condition]
- Inconclusive: [Need additional experiment]

## Risks
- [Risk 1] -> [Mitigation]

## Next Steps
- [ ] [Implement events]
- [ ] [Make UI changes]
- [ ] [Deploy and observe for N days]
```

---

## Save Deliverables

Save hypothesis validation plan to `docs/decisions/YYYY-MM-DD-hypothesis-{topic}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to PO-A, PO-B, and Analyst via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
