---
name: statistical-analysis
description: >
  This skill should be used when interpreting A/B test results, detecting outliers
  in app metrics, performing hypothesis testing, or analyzing statistical significance.
  Useful for "A/B test results", "is this statistically significant", "outlier detection",
  "correlation analysis", "trend analysis", "metric distribution".
user-invocable: false
---

# Statistical Analysis Framework

Data Analyst skill for rigorous interpretation of app metrics and experiments.

## Descriptive Statistics

### Central Tendency & Spread
For any app metric (DAU, session length, conversion rate, retention):
- **Mean vs Median**: Use median for skewed distributions (e.g., session length, revenue per user)
- **Standard Deviation**: Understand normal variation before flagging anomalies
- **Percentiles** (P25, P50, P75, P90, P99): Identify power user thresholds

### Distribution Analysis
```markdown
## Distribution: [Metric Name]

| Statistic | Value |
|-----------|-------|
| Mean | |
| Median | |
| Std Dev | |
| P25 | |
| P75 | |
| P90 | |
| Skewness | Left / Right / Normal |

### Interpretation
- [What this distribution tells us about user behavior]
- [Segment implications: power users vs casual]
```

## Trend Analysis

### Time-Series Patterns
- **Moving Averages**: 7-day MA to smooth daily noise in DAU, revenue
- **Period Comparisons**: WoW (Week-over-Week), MoM (Month-over-Month), YoY (Year-over-Year)
- **Seasonality**: Day-of-week patterns, holiday effects, app update impacts

### Trend Report Template
```markdown
## Trend Analysis: [Metric]

### Period: [Date Range]
| Period | Value | WoW Change | MoM Change |
|--------|-------|-----------|-----------|
| Current Week | | | |
| Previous Week | | | |
| 4-Week Avg | | | |

### Seasonality
- Day-of-week pattern: [Peak days, low days]
- Notable events: [App updates, holidays, press coverage]

### Trend Direction
- Short-term (1-2 weeks): [Up / Down / Flat]
- Medium-term (1-3 months): [Up / Down / Flat]
- Confidence: [High / Medium / Low]
```

## Outlier Detection

### Methods
1. **Z-Score**: Flag data points > 2 standard deviations from mean
   - Best for: normally distributed metrics (DAU, session count)
2. **IQR Method**: Q1 - 1.5*IQR to Q3 + 1.5*IQR
   - Best for: skewed metrics (revenue per user, session length)

### Outlier Investigation
When an outlier is detected:
1. **Verify data quality**: Is this a tracking bug or real behavior?
2. **Check external factors**: App update, press mention, viral moment, App Store feature?
3. **Segment analysis**: Is the outlier driven by a specific user segment or geography?
4. **Persistence**: One-time spike or sustained shift?

## Hypothesis Testing (A/B Test Interpretation)

### Framework
```markdown
## A/B Test Analysis: [Test Name]

### Setup
- **Hypothesis**: If [change], then [metric] improves by [target]
- **Control**: [Current experience]
- **Variant**: [Modified experience]
- **Primary Metric**: [What we're measuring]
- **Sample Size**: [Users per group]
- **Duration**: [Days run]

### Results
| Group | Sample Size | Metric Value | 95% CI |
|-------|------------|-------------|--------|
| Control | | | [lower, upper] |
| Variant | | | [lower, upper] |

### Interpretation
- **Lift**: +/- ??%
- **Statistical Significance**: p-value [< or >] 0.05
- **Practical Significance**: Is the effect size meaningful for the business?
- **Confidence Interval Overlap**: [Do CIs overlap?]

### Decision
- [ ] Ship Variant (significant + practically meaningful)
- [ ] Continue testing (promising but underpowered)
- [ ] Revert to Control (no improvement or negative)
- [ ] Redesign experiment (flawed setup)
```

### Key Principles
1. **Statistical vs Practical Significance**: A p < 0.05 with +0.1% conversion lift may not be worth shipping
2. **Minimum Sample Size**: Don't peek early — decide sample size before running
3. **One Primary Metric**: Multiple comparisons inflate false positive rate
4. **Segment Effects**: Check if the effect varies across user segments (new vs returning, free vs paid)

## Common Pitfalls (Always Check)

1. **Correlation != Causation**: "Users who enable notifications retain better" doesn't mean notifications cause retention — engaged users enable notifications
2. **Simpson's Paradox**: A trend in aggregated data can reverse when segmented. Always check segments
3. **Survivorship Bias**: Analyzing only active users ignores those who churned
4. **Selection Bias**: Users who opt into a feature are different from those who don't
5. **Novelty Effect**: New feature engagement often spikes then normalizes — wait for stabilization
6. **Multiple Testing**: Running 10 tests at p < 0.05 means ~1 false positive expected

## Amplitude Chart Interpretation

When reading Amplitude charts:
- **Event Segmentation**: Check sample sizes per segment before comparing rates
- **Funnel Charts**: Note the conversion window — a 7-day window vs 1-day changes interpretation
- **Retention Charts**: Compare cohort curves, not single points
- **User Composition**: Understand who is included/excluded from the chart's user base

## Deliverable

Save analysis results to `docs/decisions/YYYY-MM-DD-statistical-analysis-{topic}.md`.
