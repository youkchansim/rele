---
description: End-to-end feature pipeline — from idea debate to Go/No-Go decision, design handoff, and post-launch monitoring plan
argument-hint: Feature idea (e.g., "AI schedule recommendation", "calendar sharing")
---

# Feature Pipeline

End-to-end pipeline: Debate → Hypothesis → Review → Design → Monitoring Plan

**Feature**: $ARGUMENTS

---

## Phase 1: PO Debate (Direction)

PO A (Data-Driven) and PO B (Intuitive) conduct a 3-round structured debate.

### Round 1: Initial Positions (Parallel)

Invoke PO A and PO B agents **in parallel**.

**PO A Prompt**:
> Analyze the following topic from a data perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics and North Star
> 2. Query RevenueCat/Amplitude MCP for relevant metrics (when available)
> 3. State your for/against position with ICE score and expected business impact
> 4. Support your argument with specific data/numbers

**PO B Prompt**:
> Analyze the following topic from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Analyze related user reactions and competitor apps on Reddit/HN
> 3. State your for/against position from user journey and UX value perspectives
> 4. Support your argument with competitive analysis and community insights

### Round 2: Cross-Critique

Pass Round 1 results to each side and request rebuttals.

**To PO A**: Pass PO B's position and request rebuttal
> PO B's position: [Round 1 PO B result]
> Critique this from a data perspective. Specify which of PO B's points you accept and which you rebut.

**To PO B**: Pass PO A's position and request rebuttal
> PO A's position: [Round 1 PO A result]
> Critique this from a user/market perspective. Specify which of PO A's points you accept and which you rebut.

### Round 3: Consensus

Synthesize all positions and rebuttals into a consensus.

**Consensus Rules**:
1. **Data clear** -> Data wins
2. **Data insufficient** -> MVP validation
3. **Low risk** -> Try intuition
4. **High risk** -> Conservative approach

**Direction Judgment**: Determine one of the following:
- **pursue** — proceed to next phase
- **don't pursue** — stop the pipeline
- **needs more research** — treat as "pursue" but note research gaps

### GATE 1: Direction Check

If direction = **"don't pursue"**:
1. Save the debate result to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md` with a note that the pipeline was stopped at Gate 1
2. Output: `## Pipeline Complete — Stopped at Gate 1`
3. Include the consensus summary and key arguments
4. **STOP HERE. Do not proceed to Phase 2.**

If direction = **"pursue"** or **"needs more research"**: Continue to Phase 2.

---

## Phase 2: Hypothesis Structuring

Use the debate consensus from Phase 1 as context. Do NOT re-gather data already analyzed.

### Step 1: Hypothesis Formation (Parallel)

**PO A Prompt**:
> Based on the debate consensus below, structure a testable hypothesis:
> [Pass Phase 1 consensus result]
>
> 1. Hypothesis format: "If we [change], then [metric] will improve by [target], because [evidence]"
> 2. Calculate ICE score using data from the debate
> 3. Define clear success/failure criteria
> 4. Do NOT re-analyze metrics already covered in the debate — build on existing findings

**PO B Prompt**:
> Based on the debate consensus below, complement the hypothesis from a user perspective:
> [Pass Phase 1 consensus result]
>
> 1. Assess user journey impact based on debate findings
> 2. Predict user reactions (positive/negative)
> 3. Identify user segments most affected
> 4. Do NOT re-analyze competitors already covered in the debate — add only new insights

### Step 2: Hypothesis Integration

Integrate PO A and PO B perspectives into a unified hypothesis:

```
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

### Step 3: Measurement Plan (Analyst)

**Data Analyst Prompt**:
> Create a measurement plan for the following hypothesis:
> [Pass Step 2 integrated hypothesis]
>
> 1. Design required events using 3-Question filter
> 2. Decide A/B test vs Before-After approach
> 3. Calculate sample size and validation duration
> 4. Propose dashboard/alert configuration
> 5. Check if existing events can be reused

---

## Phase 3: Team Review + Go/No-Go

All 6 team members review the feature using Phase 1-2 results as context.

### 6-Perspective Parallel Review

Invoke all 6 agents **in parallel**. Pass the debate consensus, hypothesis, and measurement plan to each reviewer.

**PO A (Data) Prompt**:
> Review this feature proposal from a data/business perspective.
> Context — Debate consensus: [Phase 1 result] | Hypothesis: [Phase 2 result]
> 1. Business impact (revenue, conversion, retention effect)
> 2. Data-based risk assessment
> 3. Score: 1-10 (business value)
> Do NOT re-analyze what was already covered. Focus on review judgment.

**PO B (Intuitive) Prompt**:
> Review this feature proposal from a user/market perspective.
> Context — Debate consensus: [Phase 1 result] | Hypothesis: [Phase 2 result]
> 1. User value (problem solving, satisfaction, differentiation)
> 2. Position in user journey
> 3. Score: 1-10 (user value)
> Do NOT re-analyze what was already covered. Focus on review judgment.

**Designer Prompt**:
> Review this feature proposal from a UI/UX perspective.
> Context — Debate consensus: [Phase 1 result] | Hypothesis: [Phase 2 result]
> 1. Scan the project's DesignSystem directory
> 2. UI consistency, HIG compliance, accessibility
> 3. Score: 1-10 (design quality)

**iOS Developer Prompt**:
> Review this feature proposal from a technical implementation perspective.
> Context — Debate consensus: [Phase 1 result] | Hypothesis: [Phase 2 result]
> 1. Explore codebase for feasibility analysis
> 2. Technical debt, architecture impact, performance/stability risks
> 3. Score: 1-10 (technical quality/feasibility)

**Data Analyst Prompt**:
> Review this feature proposal from a measurement/analysis perspective.
> Context — Debate consensus: [Phase 1 result] | Hypothesis: [Phase 2 result] | Measurement plan: [Phase 2 Step 3 result]
> 1. Measurability assessment
> 2. Score: 1-10 (measurability)
> Build on the measurement plan already created. Do NOT redesign from scratch.

**Marketer Prompt**:
> Review this feature proposal from a marketing/growth perspective.
> Context — Debate consensus: [Phase 1 result] | Hypothesis: [Phase 2 result]
> 1. Marketing material value, viral potential, ASO impact
> 2. Score: 1-10 (marketing value)

### Scorecard Summary

```markdown
## Feature Review Scorecard: [Feature Name]

| Perspective | Score | Key Opinion | Main Risk |
|-------------|:-----:|------------|----------|
| PO A (Business) | /10 | | |
| PO B (User) | /10 | | |
| Designer (UX) | /10 | | |
| Developer (Tech) | /10 | | |
| Analyst (Measurement) | /10 | | |
| Marketer (Growth) | /10 | | |
| **Average** | **/10** | | |
```

### Go/No-Go Decision

**Decision Criteria**:
- **4+ of 6 score 7 or above** -> **Go**
- Developer scores **4 or below** (critical technical issue) -> **Conditional Hold**
- PO A scores **4 or below** (unclear metric impact) -> **Validate hypothesis first**
- Average **5 or below** -> **No-Go** (re-evaluate needed)

### GATE 2: Go/No-Go Check

**If No-Go** (average ≤ 5):
1. Save everything so far to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md`
2. Output: `## Pipeline Complete — Stopped at Gate 2: No-Go`
3. **STOP HERE.**

**If Conditional Hold** (Developer scores ≤ 4):
1. Save everything with conditions to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md`
2. Output: `## Pipeline Complete — Stopped at Gate 2: Conditional Hold`
3. Include the conditions that must be met before re-evaluation
4. **STOP HERE.**

**If Validate first** (PO A scores ≤ 4):
1. Save everything with hypothesis gaps to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md`
2. Output: `## Pipeline Complete — Stopped at Gate 2: Validate Hypothesis First`
3. Include recommended validation steps
4. **STOP HERE.**

**If Go**: Continue to Phase 4.

---

## Phase 4: Design & Implementation Planning

Designer, iOS Developer, and Data Analyst work in parallel using Phase 1-3 context.

### Parallel Work

**Designer Prompt**:
> Design the UI/UX for: "$ARGUMENTS"
> Context — Review result: [Phase 3 result] | Hypothesis: [Phase 2 result]
> 1. Scan the project's DesignSystem directory for existing tokens/components
> 2. Check Assets.xcassets for Color Sets
> 3. Screen design: ASCII wireframe, design tokens, existing/new components, state-based UI, interaction/animation
> 4. Accessibility check (VoiceOver, Dynamic Type, color contrast)
> 5. Dark mode considerations + HIG compliance
> 6. SwiftUI code snippets (layout structure)

**iOS Developer Prompt**:
> Create an implementation plan for: "$ARGUMENTS"
> Context — Review result: [Phase 3 result] | Hypothesis: [Phase 2 result]
> 1. Search existing codebase for reusable components
> 2. Propose integration approach with existing architecture
> 3. Identify affected files (modified + new)
> 4. Suggest optimal implementation using SwiftUI/Swift Concurrency
> 5. Estimate effort (hours/days)

**Data Analyst Prompt**:
> Design analytics event placement for: "$ARGUMENTS"
> Context — Measurement plan: [Phase 2 Step 3 result] | Review result: [Phase 3 result]
> 1. Finalize event map based on the measurement plan from Phase 2
> 2. Specify code placement (where to place Logger.log() calls)
> 3. Check for overlap with existing events
> 4. Map events to dashboard metrics

---

## Phase 5: Post-Launch Monitoring Plan

PO A and Data Analyst define the post-launch monitoring strategy.

### Parallel Work

**PO A Prompt**:
> Based on the hypothesis and measurement plan from earlier phases, define:
> Context — Hypothesis: [Phase 2 result] | Measurement plan: [Phase 2 Step 3 result]
> 1. Success/failure thresholds for each KPI
> 2. Timeline checkpoints (D1, D7, D14, D30) with specific checks per checkpoint
> 3. Rollback/pivot criteria (when to revert or change direction)
> 4. Business impact projection if successful

**Data Analyst Prompt**:
> Based on the event map and measurement plan, define:
> Context — Measurement plan: [Phase 2 Step 3 result] | Event map: [Phase 4 Analyst result]
> 1. Dashboard configuration (which charts, which metrics)
> 2. Alert rules (notify when metric drops below X)
> 3. Specific Amplitude/RevenueCat queries to run at each checkpoint
> 4. Comparison methodology (before/after, cohort comparison, A/B results)

---

## Final Output: Pipeline Document

Compile ALL phases into a single document:

```markdown
# Feature Pipeline: [Feature Name]
Date: YYYY-MM-DD

## 1. Direction (PO Debate)
[Consensus summary + key arguments + direction judgment]

## 2. Hypothesis
[Integrated hypothesis statement + ICE score + success metrics]

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
| D7 | Activation rate, usage freq | Amplitude funnel chart | Activation ≥ X% |
| D14 | Retention impact | Cohort analysis | D14 retention ≥ baseline |
| D30 | Revenue impact, full hypothesis | RevenueCat + Amplitude | Primary KPI meets target |

### Decision Criteria
- **Success**: [Primary KPI target met] → Scale / iterate
- **Partial**: [Secondary met, primary not] → Optimize
- **Failure**: [Below guard rail] → Rollback
- **Inconclusive**: [Insufficient data] → Extend experiment

### Recommended Actions
- D7: Run `/growth-audit subscription conversion` for early signal
- D30: Run `/growth-audit` for full AARRR diagnosis
```

---

## Save Deliverables

Save the complete pipeline document to `docs/decisions/YYYY-MM-DD-pipeline-{feature-name}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.
