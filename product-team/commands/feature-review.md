---
description: 6-perspective team review of a feature with Go/No-Go decision
argument-hint: Feature to review (e.g., "AI schedule recommendation", "calendar widget")
---

# Feature Review

All 6 virtual product team members review a feature from their expert perspectives.

**Review Target**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("feature-review")`
2. Spawn all 6 agents **simultaneously** via Agent tool with `team_name: "feature-review"`:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
   - **Designer** (product-team:app-designer, name: "Designer")
   - **Developer** (product-team:ios-developer, name: "Developer")
   - **Analyst** (product-team:data-analyst, name: "Analyst")
   - **Marketer** (product-team:marketer, name: "Marketer")
3. Create all tasks:

```
Task 1: "PO-A 비즈니스 관점 리뷰" — assign to PO-A (병렬)
Task 2: "PO-B 사용자 관점 리뷰" — assign to PO-B (병렬)
Task 3: "Designer UX 관점 리뷰" — assign to Designer (병렬)
Task 4: "Developer 기술 관점 리뷰" — assign to Developer (병렬)
Task 5: "Analyst 측정 관점 리뷰" — assign to Analyst (병렬)
Task 6: "Marketer 성장 관점 리뷰" — assign to Marketer (병렬)
Task 7: "Lead Scorecard 집계 + Go/No-Go 판정" — Lead handles (blockedBy: [1,2,3,4,5,6])
```

---

## Phase 1: 6-Perspective Parallel Review

Send tasks to all 6 agents simultaneously via SendMessage:

### To PO-A:
> Review the following feature from a data/business perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for context
> 2. Business impact (revenue, conversion, retention effect)
> 3. Calculate ICE score
> 4. Data-based risk assessment
> 5. Score: 1-10 (business value)
> Mark Task 1 as completed when done.

### To PO-B:
> Review the following feature from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for context
> 2. User value (problem solving, satisfaction, differentiation)
> 3. Competitive analysis (similar features exist?)
> 4. Position in user journey
> 5. Score: 1-10 (user value)
> Mark Task 2 as completed when done.

### To Designer:
> Review the following feature from a UI/UX perspective: "$ARGUMENTS"
> 1. Scan the project's DesignSystem directory
> 2. UI consistency, HIG compliance, accessibility
> 3. User interaction quality
> 4. Design system integration level
> 5. Score: 1-10 (design quality)
> Mark Task 3 as completed when done.

### To Developer:
> Review the following feature from a technical implementation perspective: "$ARGUMENTS"
> 1. Explore codebase for feasibility analysis
> 2. Technical debt, architecture impact
> 3. Performance and stability risks
> 4. Estimated effort
> 5. Score: 1-10 (technical quality/feasibility)
> Mark Task 4 as completed when done.

### To Analyst:
> Review the following feature from a measurement/analysis perspective: "$ARGUMENTS"
> 1. Measurability (can success/failure be determined?)
> 2. Required events and metrics
> 3. Can existing data validate the hypothesis?
> 4. A/B test necessity
> 5. Score: 1-10 (measurability)
> Mark Task 5 as completed when done.

### To Marketer:
> Review the following feature from a marketing/growth perspective: "$ARGUMENTS"
> 1. Marketing material value
> 2. Viral potential (sharing, spread)
> 3. ASO impact
> 4. Build in Public story material
> 5. Score: 1-10 (marketing value)
> Mark Task 6 as completed when done.

---

## Phase 2: Scorecard Summary + Cross-Challenge (Lead)

When all 6 tasks complete, Lead compiles the scorecard (Task 7):

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

### Optional Cross-Challenge
If any two reviewers' scores differ by **>= 5 points**, Lead may initiate a 1-round cross-challenge:
- Send the higher scorer's rationale to the lower scorer via SendMessage, asking for response
- Send the lower scorer's rationale to the higher scorer via SendMessage, asking for response
- Adjust scores if either side is convinced, then update the scorecard

---

## Phase 3: Go/No-Go Decision (Lead)

### Decision Criteria
- **4+ of 6 score 7 or above** -> **Go**
- Developer scores **4 or below** (critical technical issue) -> **Conditional Hold**
- PO A scores **4 or below** (unclear metric impact) -> **Validate hypothesis first**
- Average **5 or below** -> **No-Go** (re-evaluate needed)

### Decision Format

```markdown
## Decision: [Go / Conditional Go / Hold / No-Go]

### Reason
[Decision rationale]

### Conditions (if Conditional Go)
- [Conditions to meet]

### Next Steps
- [ ] [Action item 1]
- [ ] [Action item 2]
```

---

## Save Deliverables

Save review results to `docs/decisions/YYYY-MM-DD-review-{feature-name}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to all 6 teammates via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
