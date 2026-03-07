---
name: metrics-tracking
description: >
  This skill should be used when defining North Star metrics, building metric hierarchies,
  designing dashboards, setting OKRs, or establishing review cadences.
  Useful for "define North Star metric", "metric hierarchy", "dashboard design",
  "OKR setting", "weekly review template", "what should we track".
user-invocable: false
---

# Metrics Tracking Framework

Shared skill for PO A (Data-Driven) and Data Analyst. Establishes the measurement system that drives product decisions.

## Metrics Hierarchy

### Structure
```
North Star Metric (1 metric that defines product success)
  |
  +-- L1 Metrics (3-5 direct drivers of North Star)
  |     |
  |     +-- L2 Metrics (operational metrics per L1)
  |
  +-- Health Metrics (guardrails: crash rate, load time, error rate)
```

### Template
```markdown
## Metrics Hierarchy: [App Name]

### North Star: [Metric]
Definition: [Precise definition including time window]
Current: [Value] | Target: [Value] | Timeline: [When]

### L1 Metrics
| L1 Metric | Connection to North Star | Current | Target |
|-----------|------------------------|---------|--------|
| Activation Rate | More activated users -> higher NS | ??% | ??% |
| Retention (D7) | Retained users compound NS | ??% | ??% |
| Core Action Frequency | More usage -> higher NS | ?? / week | ?? / week |

### L2 Metrics (per L1)
| L1 | L2 Metric | Measures | Current |
|----|-----------|----------|---------|
| Activation | Onboarding completion % | Funnel health | ??% |
| Activation | Time-to-first-value | UX friction | ?? min |
| Retention | DAU/MAU ratio | Engagement depth | ??% |
| Retention | Feature adoption % | Value discovery | ??% |
| Core Action | Actions per session | Engagement intensity | ?? |

### Health Metrics (Guardrails)
| Metric | Threshold | Alert If |
|--------|-----------|----------|
| Crash-free rate | > 99.5% | Drops below |
| App load time | < 2s | Exceeds |
| Error rate | < 1% | Exceeds |
```

## Common Product Metrics

### Engagement
- **DAU / WAU / MAU**: Active user counts by period
- **DAU/MAU Ratio**: Stickiness (20%+ is strong for most apps)
- **Session Frequency**: Sessions per user per day/week
- **Session Duration**: Average time in app

### Retention
- **D1 / D7 / D30 Retention**: % of users returning after N days
- **Rolling Retention**: % of users active in last 7/30 days
- **Resurrection Rate**: Previously churned users who return

### Conversion
- **Activation Rate**: % of new users who reach "Aha Moment"
- **Trial-to-Paid**: % of free trial users who convert
- **Paywall Conversion**: % of paywall views that convert

### Revenue (via RevenueCat)
- **MRR / ARR**: Monthly/Annual Recurring Revenue
- **ARPU / ARPPU**: Revenue per user / per paying user
- **LTV**: Lifetime Value by cohort
- **Churn Rate**: Monthly subscriber churn

## Goal Setting (OKR Framework)

### For Solo iOS Developer
```markdown
## OKR: [Quarter]

### Objective 1: [Qualitative goal]
- KR1: [Metric] from [current] to [target]
- KR2: [Metric] from [current] to [target]
- KR3: [Metric] from [current] to [target]

### Objective 2: [Qualitative goal]
- KR1: [Metric] from [current] to [target]
- KR2: [Metric] from [current] to [target]
```

### OKR Principles
- **2-3 Objectives** per quarter (solo developer = focused capacity)
- **2-3 KRs** per Objective (measurable, time-bound)
- **70% achievement** = well-calibrated stretch goals
- **Leading indicators**: Prefer metrics you can influence this quarter

## Review Cadences

### Weekly Review (Solo Developer)
```markdown
## Weekly Review: [Week of Date]

### Key Metrics
| Metric | This Week | Last Week | WoW Change | On Track? |
|--------|-----------|-----------|-----------|-----------|
| [North Star] | | | | Y/N |
| [L1 Metric A] | | | | Y/N |
| [L1 Metric B] | | | | Y/N |

### Highlights
- [What went well]

### Concerns
- [Metric that needs attention]

### Next Week Focus
- [1-2 priorities]
```

### Monthly Review
```markdown
## Monthly Review: [Month]

### North Star Progress
- Start of month: [Value]
- End of month: [Value]
- MoM change: [%]

### OKR Progress
| KR | Start | Current | Target | Confidence |
|----|-------|---------|--------|-----------|
| KR1 | | | | High/Med/Low |

### Key Learnings
- [What the data taught us this month]

### Next Month Focus
- [Strategic priorities based on data]
```

### Quarterly Review
- Full OKR scoring and retrospective
- Metric hierarchy reassessment
- North Star validation: is it still the right metric?

## Dashboard Design Principles

1. **Start with a question**: What decision does this dashboard help make?
2. **North Star at the top**: The most important metric is immediately visible
3. **Context over numbers**: Show trends, comparisons, and targets — not just current values
4. **5-10 metrics max**: More than that and nothing gets attention
5. **Actionable grouping**: Group by decision area, not data source
6. **Time range default**: Default to 30-day view with WoW comparison

### Amplitude Dashboard Layout
```
Row 1: North Star metric (large, with trend line)
Row 2: L1 metrics (3-4 cards with sparklines)
Row 3: Key funnels (activation, conversion)
Row 4: Retention curve (latest cohort vs benchmark)
Row 5: Health metrics (crash rate, errors)
```

## Deliverable

Save metrics framework to `docs/decisions/YYYY-MM-DD-metrics-{topic}.md`.
