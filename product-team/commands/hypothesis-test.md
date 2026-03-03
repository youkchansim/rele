---
description: Structure an idea into a testable hypothesis with measurement plan
argument-hint: Idea to validate (e.g., "Moving the paywall after onboarding will increase conversion")
---

# Hypothesis Test Design

PO A (Data), PO B (Intuitive), and Data Analyst collaborate to structure an idea into a testable hypothesis.

**Idea**: $ARGUMENTS

---

## Phase 1: Hypothesis Structuring (Parallel)

### PO A (Data)
> Structure the following idea into a data-based hypothesis: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics
> 2. Query related data (RevenueCat/Amplitude MCP)
> 3. Hypothesis format: "If we [change], then [metric] will improve by [target], because [evidence]"
> 4. Calculate ICE score
> 5. Define clear success/failure criteria

### PO B (Intuitive)
> Complement the following idea from a user perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users
> 2. Explore Reddit/HN for user reactions to similar features/ideas
> 3. Assess the impact of this change on the user journey
> 4. Find competitor attempts and their results
> 5. Predict user reactions (positive/negative)

---

## Phase 2: Hypothesis Integration

Integrate PO A and PO B perspectives into a final hypothesis.

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

## Phase 3: Measurement Plan (Analyst)

### Data Analyst
> Create a measurement plan for the following hypothesis:
> [Pass Phase 2 integrated hypothesis]
> 1. Design required events using 3-Question filter
> 2. Decide A/B test vs Before-After approach
> 3. Calculate sample size and validation duration
> 4. Propose dashboard/alert configuration
> 5. Check if existing events can be reused

---

## Phase 4: Final Hypothesis Validation Plan

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
