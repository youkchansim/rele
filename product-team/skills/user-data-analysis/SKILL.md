---
name: user-data-analysis
description: >
  This skill should be used when analyzing user behavior data, funnel conversion
  rates, retention cohorts, revenue metrics, or LTV calculations.
  Useful for "analyze funnel", "check retention", "revenue analysis",
  "user segment comparison", "LTV calculation", "behavior analysis".
user-invocable: false
---

# User Data Analysis Framework

Led by Data Analyst, with PO A participation. Quantitative analysis tool.

## Analysis Types

### 1. Funnel Analysis

```markdown
## Funnel Analysis: [Funnel Name]

### Funnel Definition
[Step 1: Event Name] -> [Step 2] -> [Step 3] -> [Goal]

### Conversion Rates
| Step | Event | Reach Rate | Drop Rate | Drop Cause (estimated) |
|------|-------|-----------|-----------|----------------------|
| 1->2 | | ??% | ??% | |
| 2->3 | | ??% | ??% | |
| 3->Goal | | ??% | ??% | |

### Segment Comparison
| Segment | Step1->2 | Step2->3 | Total Conversion |
|---------|----------|----------|-----------------|
| New users | | | |
| Existing users | | | |
| Free | | | |
| Paid | | | |

### Insights & Actions
- [Finding 1] -> [Proposed action]
- [Finding 2] -> [Proposed action]
```

### 2. Retention Analysis

```markdown
## Retention Analysis

### Cohort Retention
| Cohort | D1 | D3 | D7 | D14 | D30 | D60 | D90 |
|--------|-----|-----|-----|------|------|------|------|
| [Month] | % | % | % | % | % | % | % |

### "Aha Moment" Analysis
- Common behavior of high-retention users: [Events/patterns]
- Common pattern of churned users: [Events/patterns]
- Key activation event: [Performing within D1 -> retention +N%]

### Insights & Actions
- [Finding] -> [Proposed action]
```

### 3. Revenue / LTV Analysis

Using RevenueCat MCP:
```markdown
## Revenue Analysis

### Overview Metrics
- MRR: $???
- ARR: $???
- Active Subscribers: ???
- Trial Conversion Rate: ??%
- Churn Rate: ??%

### Cohort LTV
| Cohort | 30-day LTV | 90-day LTV | 365-day LTV |
|--------|-----------|-----------|------------|
| [Period] | $? | $? | $? |

### Segment Analysis
| Segment | Sub Conversion | ARPU | Churn |
|---------|---------------|------|-------|
| [Country A] | | | |
| [Source A] | | | |
```

### 4. Amplitude Behavior Analysis

Using Amplitude MCP (when connected):
```markdown
## User Behavior Analysis

### Key Event Frequency
| Event | DAU Usage % | Weekly Avg Count | Trend |
|-------|------------|-----------------|-------|
| [Event] | ??% | ?? | up/down/flat |

### User Segments
| Segment | Share | Core Behavior | Conversion Potential |
|---------|-------|--------------|---------------------|
| Power User | ??% | [Behavior] | High |
| Casual | ??% | [Behavior] | Medium |
| At-risk | ??% | [Behavior] | Low |
```

## Data Source Priority

1. **Amplitude MCP** — User behavior events, funnels, cohorts
2. **RevenueCat MCP** — Revenue, subscriptions, LTV
3. **BigQuery MCP** (optional) — Firebase Analytics raw data SQL
4. **Qualitative Analysis** — Framework-based estimation when MCP is unavailable

When MCP is not connected, apply the analysis frameworks above using available project data (Logger files, EventType enums) and qualitative reasoning. Clearly mark estimated vs measured values.

## Deliverable

Save analysis results to `docs/decisions/YYYY-MM-DD-analysis-{topic}.md`.
