---
description: PO A + Analyst + Marketer diagnose current metrics and discover growth opportunities
argument-hint: Audit focus (e.g., "weekly metric check", "subscription funnel deep dive", "post-launch review")
---

# Growth Audit

AARRR-based growth diagnosis with Amplitude dashboard improvement execution.

**Focus**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("growth-audit")`
2. Spawn 3 agents simultaneously via Agent tool with `team_name: "growth-audit"`:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **Analyst** (product-team:data-analyst, name: "Analyst")
   - **Marketer** (product-team:marketer, name: "Marketer")
3. Create Phase 1 tasks only (Lazy Task Creation):

```
Task 1: "PO-A Core Metric Health Check" — assign to PO-A (parallel)
Task 2: "Analyst Dashboard & Chart Audit" — assign to Analyst (parallel)
Task 3: "Marketer Channel Performance Analysis" — assign to Marketer (parallel)
```

---

## Phase 1: Parallel Data Collection (Tasks 1-3)

### Task 1: PO-A — Core Metric Health Check

**Send to PO-A (SendMessage):**
> Diagnose the health of our core metrics for: "$ARGUMENTS"
> 1. Read project CLAUDE.md for North Star metric and current targets
> 2. Query RevenueCat MCP for revenue metrics (MRR, churn rate, trial-to-paid, LTV) — if available
> 3. Query Amplitude MCP (`get_context`, `query_chart`, `query_dataset`) for engagement and retention data — if available
> 4. For each metric, assess: current value, trend direction, vs target, severity (Green/Yellow/Red)
> 5. Use the metrics-tracking skill hierarchy (North Star -> L1 -> L2) to structure findings
> 6. Output a health scorecard table
> Mark Task 1 as completed when done.

### Task 2: Analyst — Dashboard & Chart Audit

**Send to Analyst (SendMessage):**
> Audit our existing Amplitude dashboards and charts for: "$ARGUMENTS"
> 1. Use Amplitude MCP `get_context` to identify the project
> 2. Use `get_charts` and `search` to list all existing charts
> 3. Use `get_dashboard` to review each dashboard's structure and layout
> 4. For each dashboard/chart, evaluate:
>    - Does it follow the metrics-tracking dashboard layout principles? (North Star at top, L1 metrics, funnels, retention, health)
>    - Does it follow data-visualization chart selection guidelines? (correct chart type for the data relationship)
>    - Is it still relevant? Are there orphan/unused charts?
> 5. Output an audit table: Dashboard/Chart name | Current state | Issues found | Improvement recommendation
> Mark Task 2 as completed when done.

### Task 3: Marketer — Channel Performance Analysis

**Send to Marketer (SendMessage):**
> Analyze marketing channel performance for: "$ARGUMENTS"
> 1. Use performance-analytics skill templates for channel metrics
> 2. Check App Store performance data (search rankings, conversion rate, review trends) via web search if App Store Connect is unavailable
> 3. Scan Reddit (mcp__reddit-buddy) and HN (mcp__hackernews) for brand mentions, sentiment, community engagement
> 4. Query Amplitude MCP for acquisition source data if tracked (`query_chart`, `query_dataset`)
> 5. For each channel: impressions, engagement rate, estimated download contribution, quality (retention of users from that source)
> 6. Output a channel performance table with optimization recommendations
> Mark Task 3 as completed when done.

---

## Phase 2: AARRR Synthesis (Task 4)

After Tasks 1-3 complete, create Phase 2 task:

```
Task 4: "Lead AARRR Synthesis + Priority Setting" — Lead handles (blockedBy: [1,2,3])
```

### Task 4: Lead — AARRR Framework Synthesis

Combine PO-A metric health, Analyst dashboard audit, and Marketer channel analysis into AARRR diagnosis:

```markdown
## AARRR Diagnosis: [Focus]

### Acquisition
- Current state: [Marketer channel data]
- Health: Green/Yellow/Red
- Key issue: [If any]

### Activation
- Current state: [PO-A onboarding/activation metrics]
- Health: Green/Yellow/Red
- Key issue: [If any]

### Retention
- Current state: [PO-A retention metrics]
- Health: Green/Yellow/Red
- Key issue: [If any]

### Revenue
- Current state: [PO-A revenue metrics]
- Health: Green/Yellow/Red
- Key issue: [If any]

### Referral
- Current state: [Marketer viral/sharing data]
- Health: Green/Yellow/Red
- Key issue: [If any]

### Priority Ranking
| Rank | AARRR Stage | Severity | Expected Impact | Recommended Action |
|------|-------------|----------|----------------|-------------------|
| 1 | [Stage] | Red/Yellow | [Impact] | [Action] |
| 2 | [Stage] | Red/Yellow | [Impact] | [Action] |
| 3 | [Stage] | Red/Yellow | [Impact] | [Action] |
```

Decide which AARRR stages need immediate attention and which dashboard improvements to execute.

---

## Phase 3: Dashboard Improvement Execution (Tasks 5-6)

After Task 4 completes, create Phase 3 tasks:

```
Task 5: "Analyst Dashboard Refactoring" — assign to Analyst (blockedBy: [4])
Task 6: "Marketer Marketing Dashboard Proposal" — assign to Marketer (blockedBy: [4])
```

### Task 5: Analyst — Amplitude Dashboard Refactoring

**Send to Analyst (SendMessage):**
> Execute dashboard improvements based on the AARRR diagnosis and your Phase 1 audit:
> [Include Phase 2 AARRR priority ranking and Phase 1 audit findings]
>
> **Dashboard Layout Principles** (from metrics-tracking skill):
> - Row 1: North Star metric (large, with trend line)
> - Row 2: L1 metrics (3-4 cards with sparklines)
> - Row 3: Key funnels (activation, conversion)
> - Row 4: Retention curve (latest cohort vs benchmark)
> - Row 5: Health metrics (crash rate, errors)
>
> **Chart Selection** (from data-visualization skill):
> - Trend over time -> Line chart
> - Comparison -> Horizontal bar chart
> - Funnel -> Funnel chart
> - Retention -> Retention curve or heatmap
> - Single KPI -> Big number with sparkline
>
> **Execution Steps:**
> 1. Fix the highest-priority issues from your audit
> 2. Use Amplitude MCP to execute improvements:
>    - `create_dashboard` — Create new dashboards if needed (e.g., dedicated AARRR dashboard)
>    - `edit_dashboard` — Reorganize existing dashboards (reorder charts, add/remove)
>    - `save_chart_edits` — Fix individual chart settings (chart type, segments, time range)
> 3. For each change made, document: What changed | Why | Which principle applied
> Mark Task 5 as completed when done.

### Task 6: Marketer — Marketing Dashboard Proposal

**Send to Marketer (SendMessage):**
> Based on the AARRR diagnosis, propose and execute marketing performance dashboard improvements:
> [Include Phase 2 AARRR priority ranking, especially Acquisition and Referral findings]
>
> 1. Design a marketing performance view using performance-analytics reporting templates
> 2. Include: channel breakdown, conversion funnel (download -> activate -> subscribe), content performance
> 3. If Amplitude MCP execution is feasible:
>    - Use `create_dashboard` to create a marketing performance dashboard
>    - Use `save_chart_edits` to configure relevant charts
> 4. If not feasible via MCP, output a detailed dashboard specification that can be manually created
> 5. Document all changes or proposals
> Mark Task 6 as completed when done.

---

## Phase 4: Final Report (Task 7)

After Tasks 5-6 complete, create Phase 4 task:

```
Task 7: "Lead Final Growth Audit Report" — Lead handles (blockedBy: [5,6])
```

### Task 7: Lead — Compile Final Report

Compile ALL phases into a single Growth Audit document:

```markdown
# Growth Audit: [Focus]
Date: YYYY-MM-DD

## Executive Summary
[2-3 sentence overview: overall health, biggest issue, key action taken]

## 1. Metric Health Scorecard
| Metric | Current | Target | Trend | Status |
|--------|---------|--------|-------|--------|
| North Star: [Metric] | | | | Green/Yellow/Red |
| L1: [Metric A] | | | | |
| L1: [Metric B] | | | | |
| Revenue: MRR | | | | |
| Revenue: Churn | | | | |

## 2. AARRR Diagnosis
| Stage | Health | Key Finding | Priority |
|-------|--------|-------------|----------|
| Acquisition | | | |
| Activation | | | |
| Retention | | | |
| Revenue | | | |
| Referral | | | |

## 3. Channel Performance
| Channel | Performance | Quality | Recommendation |
|---------|------------|---------|----------------|
| App Store Search | | | |
| Social (X/Reddit) | | | |
| Direct/Referral | | | |

## 4. Dashboard Improvements Executed
| Change | Dashboard/Chart | Reason | Principle Applied |
|--------|----------------|--------|------------------|
| [Created/Modified/Removed] | [Name] | [Why] | [Which guideline] |

## 5. Growth Opportunities
| Opportunity | AARRR Stage | Expected Impact | Effort | Priority |
|------------|-------------|----------------|--------|----------|
| [Opportunity 1] | | | | |
| [Opportunity 2] | | | | |

## 6. Recommended Next Steps
1. [Immediate action — this week]
2. [Short-term — this month]
3. [Medium-term — this quarter]

### Follow-up Commands
- Deep dive on a specific area -> `/hypothesis-test "[specific opportunity]"`
- Full feature pipeline -> `/product-pipeline "[top opportunity]"`
- Quick PO opinion -> `/ask-po "[question]"`
```

---

## Save Deliverables

Save the complete Growth Audit report to `docs/decisions/YYYY-MM-DD-growth-audit-{focus-slug}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to all teammates (PO-A, Analyst, Marketer) via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
