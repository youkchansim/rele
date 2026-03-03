---
description: PO A + Analyst + Marketer diagnose current metrics and discover growth opportunities
argument-hint: Audit focus (optional, e.g., "subscription conversion", "retention", "onboarding")
---

# Growth Audit

PO A (Data), Data Analyst, and Marketer collaborate to diagnose current metrics and discover growth opportunities.

**Audit Focus**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("growth-audit")`
2. Spawn all 3 agents **simultaneously** via Agent tool with `team_name: "growth-audit"`:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **Analyst** (product-team:data-analyst, name: "Analyst")
   - **Marketer** (product-team:marketer, name: "Marketer")
3. Create all tasks:

```
Task 1: "PO-A 비즈니스 메트릭 수집" — assign to PO-A (병렬)
Task 2: "Analyst 사용자 행동 분석" — assign to Analyst (병렬)
Task 3: "Marketer 외부 환경 분석" — assign to Marketer (병렬)
Task 4: "Lead AARRR 퍼널 진단 종합" — Lead handles (blockedBy: [1, 2, 3])
Task 5: "PO-A ICE 스코어 기반 기회 우선순위화" — assign to PO-A (blockedBy: [4])
Task 6: "Lead 액션 플랜 + 최종 문서" — Lead handles (blockedBy: [5])
```

---

## Phase 1: Data Collection (Parallel)

Send tasks to all 3 agents simultaneously via SendMessage:

### To PO-A:
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
> Mark Task 1 as completed when done.

### To Analyst:
> Analyze user behavior data for the growth audit.
> Focus area: "$ARGUMENTS" (if empty, conduct full audit)
> 1. Core funnel analysis (install -> onboarding -> activation -> subscription)
> 2. Retention cohort analysis (D1, D7, D30)
> 3. Segment behavior differences (free vs paid, new vs existing)
> 4. Churn points and cause estimation
> 5. Identify "Aha Moment" (common behavior of high-retention users)
> Mark Task 2 as completed when done.

### To Marketer:
> Analyze external environment for the growth audit.
> Focus area: "$ARGUMENTS" (if empty, conduct full audit)
> 1. Recent competitor trends (Reddit/HN exploration)
> 2. Category trends (growing/stagnant/declining)
> 3. ASO status (keyword rankings, review trends)
> 4. Organic growth channel effectiveness
> 5. Estimate viral coefficient (K-factor)
> Mark Task 3 as completed when done.

---

## Phase 2: Funnel Diagnosis (Lead)

When Tasks 1-3 complete, Lead synthesizes data using AARRR framework (Task 4):

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

## Phase 3: Opportunity Prioritization

After Task 4 completes, send funnel diagnosis to PO-A via SendMessage (Task 5):

### To PO-A:
> Calculate ICE scores for growth opportunities based on the following funnel analysis:
> [Phase 2 funnel diagnosis results]
> Provide Impact, Confidence, Ease scores with evidence for each opportunity.
> Mark Task 5 as completed when done.

---

## Phase 4: Action Plan (Lead)

When Task 5 completes, Lead compiles the final document (Task 6):

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

---

## Cleanup

1. Send `shutdown_request` to PO-A, Analyst, Marketer via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
