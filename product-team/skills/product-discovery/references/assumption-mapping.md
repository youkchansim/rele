# Assumption Mapping

Assumption Mapping is a systematic process for identifying, categorizing, and prioritizing the assumptions behind product ideas. By mapping assumptions on an Impact x Evidence matrix, teams can focus experiments on the riskiest unknowns first.

## 8 Risk Categories

Every product idea rests on assumptions across multiple dimensions. Categorize each assumption into one of these risk types:

| # | Category | Core Question | Example Assumption |
|---|----------|--------------|-------------------|
| 1 | **Desirability** | Do users want it? | "Users will prefer AI-generated summaries over manual notes" |
| 2 | **Viability** | Does it work for the business? | "We can offer this at our current price point and maintain margins" |
| 3 | **Feasibility** | Can we build it? | "Our ML model can achieve 90%+ accuracy on user content" |
| 4 | **Usability** | Can users figure it out? | "Users will understand how to configure automation rules without help" |
| 5 | **Ethical** | Should we build it? | "Collecting location data for personalization won't feel invasive" |
| 6 | **Value** | Will users pay for it? | "Users will upgrade to Pro to access this feature" |
| 7 | **Growth** | Will it spread? | "Users will invite teammates once they see collaborative features" |
| 8 | **Retention** | Will they come back? | "Users will continue using this weekly after the initial novelty wears off" |

### Category Deep Dive

**Desirability** — The most fundamental risk. If users don't want it, nothing else matters. Test this first.

**Viability** — Business model risk. Can you deliver it sustainably? Includes unit economics, operational costs, legal/compliance.

**Feasibility** — Technical risk. Can your team actually build this with current technology, skills, and timeline?

**Usability** — UX risk. Even if users want it and you can build it, will they understand how to use it? Especially critical for novel interactions.

**Ethical** — Societal and trust risk. Could this harm users, create bias, or damage trust? Increasingly important for AI/data features.

**Value** — Monetization risk. Separate from desirability — users may want something but not pay for it.

**Growth** — Distribution risk. How will new users discover this? Will existing users spread it?

**Retention** — Engagement risk. First use is different from ongoing use. Will the value sustain over time?

## Impact x Evidence Matrix

Map each assumption on a 2x2 grid:

```
                    HIGH IMPACT
                        |
         Test First     |    Monitor
         (Leap of      |    (Important but
          Faith)        |     supported)
                        |
  LOW EVIDENCE ---------+--------- HIGH EVIDENCE
                        |
         Defer          |    Safe to Proceed
         (Low risk,     |    (Known and
          unknown)      |     low stakes)
                        |
                    LOW IMPACT
```

### Quadrant Actions

| Quadrant | Impact | Evidence | Action |
|----------|--------|----------|--------|
| **Test First** | High | Low | Design experiment immediately — this is your biggest risk |
| **Monitor** | High | High | Important and supported, but keep watching for changes |
| **Defer** | Low | Low | Not worth testing now — revisit later if context changes |
| **Safe to Proceed** | Low | High | Low risk, well-understood — build with confidence |

## Process: Step by Step

### Step 1: List Assumptions

For each proposed solution, brainstorm all assumptions. Use this prompt for each risk category:

> "For this solution to succeed, what must be true about [category]?"

Aim for 10-20 assumptions per solution. Don't filter — capture everything.

### Step 2: Categorize

Label each assumption with its risk category (Desirability, Viability, etc.). Some assumptions span multiple categories — pick the primary one.

### Step 3: Map on Matrix

Place each assumption on the Impact x Evidence matrix:
- **Impact:** If this assumption is wrong, does the whole idea fail (high) or just need adjustment (low)?
- **Evidence:** Do we have data, research, or prior experience supporting this (high) or is it a guess (low)?

### Step 4: Prioritize

Focus on the **Test First** quadrant (high impact, low evidence). Rank these by:
1. How catastrophic is failure? (deal-breaker vs. adjustable)
2. How cheap is the test? (cheaper tests first)
3. How fast can we learn? (faster learning loops)

### Step 5: Design Experiments

For each high-priority assumption, design the cheapest test that gives you enough confidence to proceed or pivot.

## Experiment Types

| Method | Cost | Speed | Best For |
|--------|------|-------|----------|
| **Prototype Test** | Low-Medium | 1-2 weeks | Usability, Desirability |
| **Fake Door** | Low | 1-2 weeks | Desirability, Value |
| **Wizard of Oz** | Medium | 2-4 weeks | Feasibility (simulated), Desirability |
| **Concierge** | Medium | 2-4 weeks | Viability, Value |
| **Survey** | Low | 1 week | Desirability (directional only) |
| **Data Analysis** | Low | 1-3 days | Growth, Retention, Viability |
| **A/B Test** | High | 2-6 weeks | Any (requires working product) |
| **User Interview** | Low | 1-2 weeks | Desirability, Usability, Ethical |

### Experiment Selection Guide

- **Desirability:** Fake door > User interview > Survey
- **Viability:** Spreadsheet model > Concierge > Pilot program
- **Feasibility:** Spike/POC > Architecture review > Vendor evaluation
- **Usability:** Prototype test > First-click test > Card sort
- **Ethical:** User interview > Ethics review board > External audit
- **Value:** Fake door with pricing > Conjoint analysis > Concierge with payment
- **Growth:** Data analysis > Referral prototype > Landing page test
- **Retention:** Cohort analysis > Longitudinal interview > Usage log analysis

## Assumption Card Template

Use this template for each assumption in the Test First quadrant:

```markdown
## Assumption Card

**ID:** A-[number]
**Statement:** [Clear, falsifiable statement]
**Risk Category:** [Desirability / Viability / Feasibility / Usability / Ethical / Value / Growth / Retention]
**Impact Level:** [Critical / High / Medium]
**Current Evidence:** [What we know now, and its source]
**Evidence Strength:** [None / Weak / Moderate / Strong]

### Experiment Design
**Method:** [Experiment type]
**Success Criteria:** [What result would validate this assumption?]
**Failure Criteria:** [What result would invalidate it?]
**Sample Size:** [How many participants/data points needed?]
**Timeline:** [Expected duration]
**Cost:** [Resources required]

### Result
**Date:** [When experiment was completed]
**Outcome:** [Validated / Invalidated / Inconclusive]
**Evidence:** [What we learned]
**Next Step:** [Proceed / Pivot / Test further]
```

## Worked Example: AI Meeting Summary Feature

**Solution:** Automatically generate meeting summaries from recorded calls and send to all participants.

### Assumptions Listed

| ID | Assumption | Category | Impact | Evidence |
|----|-----------|----------|--------|----------|
| A1 | Users want automated summaries (vs. taking their own notes) | Desirability | High | Low |
| A2 | Our speech-to-text can handle multi-speaker conversations accurately | Feasibility | High | Low |
| A3 | Users will grant microphone/recording permission | Usability | High | Medium |
| A4 | Summarization quality will be good enough to trust without editing | Feasibility | High | Low |
| A5 | Users will pay $5/mo extra for this feature | Value | High | Low |
| A6 | Auto-sharing summaries won't create privacy concerns | Ethical | Medium | Low |
| A7 | Users will use this for 3+ meetings per week ongoing | Retention | Medium | Low |
| A8 | Users will recommend the feature to colleagues | Growth | Medium | Low |
| A9 | We can process summaries in under 5 minutes | Feasibility | Medium | High |
| A10 | Legal allows recording in all target markets | Viability | High | Medium |

### Mapped on Matrix

**Test First (High Impact, Low Evidence):** A1, A2, A4, A5
**Monitor (High Impact, High Evidence):** A10 (partial), A9
**Defer (Low Impact, Low Evidence):** A7, A8
**Safe to Proceed (Low Impact, High Evidence):** (none clearly here)

### Prioritized Test Order

1. **A1 (Desirability)** — Fake door test: add "AI Summary" button to existing meeting UI, measure click rate. 1 week, low cost.
2. **A2 (Feasibility)** — Technical spike: run 20 recorded meetings through speech-to-text pipeline, measure accuracy. 1 week, low cost.
3. **A4 (Feasibility)** — Wizard of Oz: manually create summaries for 10 meetings, ask recipients to rate quality. 2 weeks, medium cost.
4. **A5 (Value)** — Fake door with pricing: show upgrade modal with $5/mo price, measure "Subscribe" clicks. 1 week, low cost.

## Tips for Effective Assumption Mapping

1. **Be specific.** "Users will like it" is untestable. "60% of interviewed users will say they'd use this weekly" is testable.
2. **Separate assumptions from facts.** If you have data, it's evidence, not an assumption. Only map things you don't yet know.
3. **Update continuously.** After each experiment, move assumptions to new quadrants based on updated evidence.
4. **Involve the whole team.** Engineers surface feasibility assumptions PMs miss. Designers catch usability risks early.
5. **Kill ideas early.** If a critical assumption is invalidated, stop investing in that solution. This is a feature, not a bug.
