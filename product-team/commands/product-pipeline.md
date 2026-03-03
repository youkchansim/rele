---
description: End-to-end feature pipeline — from idea debate to Go/No-Go decision, design handoff, and post-launch monitoring plan
argument-hint: Feature idea (e.g., "AI schedule recommendation", "calendar sharing")
---

# Feature Pipeline

End-to-end pipeline: Debate -> Hypothesis -> Review -> Design -> Monitoring Plan

**Feature**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("product-pipeline")`
2. Spawn Phase 1 agents only (progressive spawning — save tokens):
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
3. Create Phase 1 tasks only (Lazy Task Creation — next Phase tasks created after Gate passage):

```
Task 1: "PO-A Round 1 Initial Position" — assign to PO-A (parallel)
Task 2: "PO-B Round 1 Initial Position" — assign to PO-B (parallel)
Task 3: "PO-A Round 2 Cross-Critique" — assign to PO-A (blockedBy: [1,2])
Task 4: "PO-B Round 2 Cross-Critique" — assign to PO-B (blockedBy: [1,2])
Task 5: "Lead Round 3 Consensus + Gate 1 Evaluation" — Lead handles (blockedBy: [3,4])
```

---

## Phase 1: PO Debate (Direction)

### Round 1: Initial Positions (Parallel)

Send to both POs simultaneously via SendMessage:

**To PO-A:**
> Analyze the following topic from a data perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics and North Star
> 2. Query RevenueCat/Amplitude MCP for relevant metrics (when available)
> 3. State your for/against position with ICE score and expected business impact
> 4. Support your argument with specific data/numbers
> Mark Task 1 as completed when done.

**To PO-B:**
> Analyze the following topic from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Analyze related user reactions and competitor apps on Reddit/HN
> 3. State your for/against position from user journey and UX value perspectives
> 4. Support your argument with competitive analysis and community insights
> Mark Task 2 as completed when done.

### Round 2: Cross-Critique

When Tasks 1-2 complete, Lead forwards cross-results:

**To PO-A (SendMessage):**
> PO B's position: [Round 1 PO B result summary]
> Critique from data perspective. Specify what you accept and rebut.
> Mark Task 3 as completed when done.

**To PO-B (SendMessage):**
> PO A's position: [Round 1 PO A result summary]
> Critique from user/market perspective. Specify what you accept and rebut.
> Mark Task 4 as completed when done.

### Round 3: Consensus + Gate 1 (Lead — Task 5)

When Tasks 3-4 complete, Lead synthesizes consensus.

**Consensus Rules:**
1. Data clear -> Data wins
2. Data insufficient -> MVP validation
3. Low risk -> Try intuition
4. High risk -> Conservative approach

**Direction Judgment**: pursue / don't pursue / needs more research

### GATE 1: Direction Check

**If "don't pursue":**
1. Save debate result to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md` with Gate 1 stop note
2. Output: `## Pipeline Complete — Stopped at Gate 1`
3. Include consensus summary and key arguments
4. Run Cleanup (shutdown all + TeamDelete)
5. **STOP HERE. Do not proceed.**

**If "pursue" or "needs more research":** Continue to Phase 2.

---

## Phase 2: Hypothesis Structuring

After Gate 1 passage, create Phase 2 tasks:

```
Task 6: "PO-A Hypothesis Structuring" — assign to PO-A (blockedBy: [5])
Task 7: "PO-B User Perspective Complement" — assign to PO-B (blockedBy: [5])
Task 8: "Lead Hypothesis Integration" — Lead handles (blockedBy: [6,7])
```

Also spawn Analyst (needed for measurement plan):
- **Analyst** (product-team:data-analyst, name: "Analyst") — include Phase 1 consensus in spawn prompt

### Step 1: Hypothesis Formation (Parallel)

**To PO-A (SendMessage):**
> Based on the debate consensus below, structure a testable hypothesis:
> [Phase 1 consensus result summary]
> 1. Hypothesis format: "If we [change], then [metric] will improve by [target], because [evidence]"
> 2. Calculate ICE score using data from the debate
> 3. Define clear success/failure criteria
> 4. Do NOT re-analyze metrics already covered — build on existing findings
> Mark Task 6 as completed when done.

**To PO-B (SendMessage):**
> Based on the debate consensus below, complement the hypothesis from a user perspective:
> [Phase 1 consensus result summary]
> 1. Assess user journey impact based on debate findings
> 2. Predict user reactions (positive/negative)
> 3. Identify user segments most affected
> 4. Do NOT re-analyze competitors already covered — add only new insights
> Mark Task 7 as completed when done.

### Step 2: Hypothesis Integration (Lead — Task 8)

Integrate PO A and PO B perspectives into unified hypothesis with ICE score and success metrics.

### Step 3: Measurement Plan

Create measurement task:
```
Task 9: "Analyst Measurement Plan" — assign to Analyst (blockedBy: [8])
```

**To Analyst (SendMessage):**
> Create a measurement plan for the following hypothesis:
> [Task 8 integrated hypothesis]
> 1. Design required events using 3-Question filter
> 2. Decide A/B test vs Before-After approach
> 3. Calculate sample size and validation duration
> 4. Propose dashboard/alert configuration
> 5. Check if existing events can be reused
> Mark Task 9 as completed when done.

---

## Phase 3: Team Review + Go/No-Go

After Task 9 completes, spawn remaining 3 agents:
- **Designer** (product-team:app-designer, name: "Designer") — include Phase 1-2 summary in spawn prompt
- **Developer** (product-team:ios-developer, name: "Developer") — include Phase 1-2 summary in spawn prompt
- **Marketer** (product-team:marketer, name: "Marketer") — include Phase 1-2 summary in spawn prompt

Create review tasks:
```
Task 10: "PO-A Business Review" — assign to PO-A (blockedBy: [9])
Task 11: "PO-B User Review" — assign to PO-B (blockedBy: [9])
Task 12: "Designer UX Review" — assign to Designer (blockedBy: [9])
Task 13: "Developer Technical Review" — assign to Developer (blockedBy: [9])
Task 14: "Analyst Measurement Review" — assign to Analyst (blockedBy: [9])
Task 15: "Marketer Growth Review" — assign to Marketer (blockedBy: [9])
Task 16: "Lead Scorecard + Gate 2 Evaluation" — Lead handles (blockedBy: [10,11,12,13,14,15])
```

### 6-Perspective Parallel Review

Send review tasks to all 6 agents via SendMessage. Pass debate consensus, hypothesis, and measurement plan as context. Each reviewer provides a 1-10 score and key opinion.

**Review prompts follow feature-review.md format** — each agent reviews from their perspective and scores 1-10. Add instruction: "Do NOT re-analyze what was already covered. Focus on review judgment."

### Scorecard + Gate 2 (Lead — Task 16)

Compile scorecard, then evaluate:

**Decision Criteria:**
- 4+ of 6 score 7 or above -> **Go**
- Developer scores 4 or below -> **Conditional Hold**
- PO A scores 4 or below -> **Validate hypothesis first**
- Average 5 or below -> **No-Go**

### GATE 2: Go/No-Go Check

**If No-Go** (average <= 5):
1. Save everything to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md`
2. Output: `## Pipeline Complete — Stopped at Gate 2: No-Go`
3. Run Cleanup. **STOP HERE.**

**If Conditional Hold** (Developer <= 4):
1. Save with conditions. Output: `## Pipeline Complete — Stopped at Gate 2: Conditional Hold`
2. Include conditions for re-evaluation. Run Cleanup. **STOP HERE.**

**If Validate first** (PO A <= 4):
1. Save with hypothesis gaps. Output: `## Pipeline Complete — Stopped at Gate 2: Validate Hypothesis First`
2. Include recommended validation steps. Run Cleanup. **STOP HERE.**

**If Go:** Continue to Phase 4.

---

## Phase 4: Design & Implementation Planning

Create Phase 4 tasks:
```
Task 17: "Designer UI/UX Design" — assign to Designer (blockedBy: [16])
Task 18: "Developer Implementation Plan" — assign to Developer (blockedBy: [16])
Task 19: "Analyst Event Placement Design" — assign to Analyst (blockedBy: [16])
```

### Parallel Work

**To Designer (SendMessage):**
> Design the UI/UX for: "$ARGUMENTS"
> Context — Review result: [Phase 3 summary] | Hypothesis: [Phase 2 summary]
> 1. Scan DesignSystem directory for tokens/components
> 2. Screen design: wireframe, tokens, components, state-based UI, interaction
> 3. Accessibility + dark mode + HIG compliance
> 4. SwiftUI code snippets
> Mark Task 17 as completed when done.

**To Developer (SendMessage):**
> Create an implementation plan for: "$ARGUMENTS"
> Context — Review result: [Phase 3 summary] | Hypothesis: [Phase 2 summary]
> 1. Search codebase for reusable components
> 2. Propose integration with existing architecture
> 3. Identify affected files (modified + new)
> 4. Estimate effort
> Mark Task 18 as completed when done.

**To Analyst (SendMessage):**
> Design analytics event placement for: "$ARGUMENTS"
> Context — Measurement plan: [Phase 2 Step 3 result] | Review: [Phase 3 summary]
> 1. Finalize event map from Phase 2 measurement plan
> 2. Specify code placement (Logger.log() locations)
> 3. Map events to dashboard metrics
> Mark Task 19 as completed when done.

---

## Phase 5: Post-Launch Monitoring Plan

After Tasks 17-19 complete, create monitoring tasks:
```
Task 20: "PO-A Monitoring Criteria Definition" — assign to PO-A (blockedBy: [17,18,19])
Task 21: "Analyst Dashboard Design" — assign to Analyst (blockedBy: [17,18,19])
Task 22: "Lead Final Document Compile" — Lead handles (blockedBy: [20,21])
```

**To PO-A (SendMessage):**
> Define post-launch monitoring criteria:
> Context — Hypothesis: [Phase 2] | Measurement plan: [Phase 2 Step 3]
> 1. Success/failure thresholds for each KPI
> 2. Timeline checkpoints (D1, D7, D14, D30) with specific checks
> 3. Rollback/pivot criteria
> 4. Business impact projection if successful
> Mark Task 20 as completed when done.

**To Analyst (SendMessage):**
> Define monitoring dashboard and alerting:
> Context — Measurement plan: [Phase 2 Step 3] | Event map: [Phase 4 Analyst result]
> 1. Dashboard configuration (charts, metrics)
> 2. Alert rules (thresholds)
> 3. Specific Amplitude/RevenueCat queries per checkpoint
> 4. Comparison methodology
> Mark Task 21 as completed when done.

---

## Final Output: Pipeline Document (Lead — Task 22)

Compile ALL phases into a single document:

```markdown
# Feature Pipeline: [Feature Name]
Date: YYYY-MM-DD

## 1. Direction (PO Debate)
[Consensus summary + key arguments + direction judgment]

## 2. Hypothesis
[Integrated hypothesis + ICE score + success metrics]

### Measurement Plan
[Events, A/B test design, sample size, duration]

## 3. Team Review Scorecard
[6-perspective scorecard table]
**Decision**: Go

## 4. Design & Implementation

### UI Design
[Wireframes, tokens, components, state-based UI, accessibility]

### Implementation Guide
[Architecture, affected files, effort estimate, code placement]

### Analytics Events
| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| | | | |

### Code Placement
[Where to place Logger.log() calls]

## 5. Post-Launch Monitoring Plan

### KPI Dashboard
| Metric | Current | Target | Alert Threshold |
|--------|---------|--------|-----------------|
| Primary KPI | | | |
| Secondary KPI | | | |
| Guard Rail | | | |

### Checkpoint Schedule
| Timing | What to Check | How to Check | Success Criteria |
|--------|--------------|-------------|-----------------|
| D1 | Event firing, crash rate | Amplitude live view | Events > 0, crash rate < baseline |
| D7 | Activation rate, usage freq | Amplitude funnel chart | Activation >= X% |
| D14 | Retention impact | Cohort analysis | D14 retention >= baseline |
| D30 | Revenue impact, full hypothesis | RevenueCat + Amplitude | Primary KPI meets target |

### Decision Criteria
- **Success**: [Primary KPI target met] -> Scale / iterate
- **Partial**: [Secondary met, primary not] -> Optimize
- **Failure**: [Below guard rail] -> Rollback
- **Inconclusive**: [Insufficient data] -> Extend experiment

### Recommended Actions
- D7: Run `/growth-audit subscription conversion` for early signal
- D30: Run `/growth-audit` for full AARRR diagnosis
```

---

## Save Deliverables

Save the complete pipeline document to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to all teammates (PO-A, PO-B, Analyst, Designer, Developer, Marketer) via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
