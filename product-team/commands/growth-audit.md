---
description: PO A + Analyst + Marketer diagnose current metrics and discover growth opportunities
argument-hint: Audit focus (optional, e.g., "subscription conversion", "retention", "onboarding")
---

# Growth Audit

PO A (Data), Data Analyst, and Marketer collaborate to diagnose current metrics and discover growth opportunities.

**Audit Focus**: $ARGUMENTS

---

## Phase 1: Data Collection (Parallel)

### PO A (Data)
> Collect business metrics for the growth audit.
> Focus area: "$ARGUMENTS" (if empty, conduct full audit)
> 1. Read project CLAUDE.md for North Star and current goals
> 2. Collect revenue metrics via RevenueCat MCP:
>    - Overview metrics (MRR, ARR, Active Subscribers)
>    - Subscription conversion rate, churn rate
>    - LTV charts
> 3. Collect user metrics via Amplitude MCP (when available):
>    - DAU/MAU, session frequency
>    - Core feature usage rates
> 4. Analyze metric trends (rising/falling/stagnant)

### Data Analyst
> Analyze user behavior data for the growth audit.
> Focus area: "$ARGUMENTS" (if empty, conduct full audit)
> 1. Core funnel analysis (install -> onboarding -> activation -> subscription)
> 2. Retention cohort analysis (D1, D7, D30)
> 3. Segment behavior differences (free vs paid, new vs existing)
> 4. Churn points and cause estimation
> 5. Identify "Aha Moment" (common behavior of high-retention users)

### Marketer
> Analyze external environment for the growth audit.
> Focus area: "$ARGUMENTS" (if empty, conduct full audit)
> 1. Recent competitor trends (Reddit/HN exploration)
> 2. Category trends (growing/stagnant/declining)
> 3. ASO status (keyword rankings, review trends)
> 4. Organic growth channel effectiveness
> 5. Estimate viral coefficient (K-factor)

---

## Phase 2: Funnel Diagnosis

Synthesize Phase 1 data using the AARRR framework.

```markdown
## AARRR Funnel Diagnosis

### Acquisition
- Current: [Metrics]
- Issues: [If any]
- Opportunities: [Improvable areas]

### Activation
- Current: [Metrics]
- "Aha Moment": [Identified core behavior]
- Issues: [If any]
- Opportunities: [Improvable areas]

### Retention
- D1: ??% | D7: ??% | D30: ??%
- Primary churn cause: [Analysis]
- Opportunities: [Improvable areas]

### Revenue
- MRR: $???
- Subscription conversion: ??%
- LTV: $???
- Opportunities: [Improvable areas]

### Referral
- K-factor: ???
- Primary sharing channels: [Channels]
- Opportunities: [Improvable areas]
```

---

## Phase 3: Opportunity Discovery & Prioritization

### PO A
> Calculate ICE scores for growth opportunities based on funnel analysis.
> [Pass Phase 2 funnel diagnosis results]
> Provide Impact, Confidence, Ease scores with evidence for each opportunity.

---

## Phase 4: Action Plan

```markdown
# Growth Audit Results: [Focus Area]

## Summary
- Biggest opportunity: [#1 priority]
- Most urgent issue: [Critical problem]
- Quick Win: [Low effort, high impact]

## Funnel Diagnosis
[Phase 2 results]

## Opportunity List (by ICE)
| # | Opportunity | I | C | E | ICE | AARRR | Est. Effort |
|---|-----------|---|---|---|-----|-------|------------|
| 1 | | | | | | | |

## Action Plan

### Immediate (This week)
- [ ] [Quick Win items]

### Short-term (1-2 weeks)
- [ ] [Items]

### Medium-term (1 month)
- [ ] [Items]

## Measurement Plan
[Which metrics to track and how]
```

---

## Save Deliverables

Save audit results to `docs/decisions/YYYY-MM-DD-growth-audit.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.
