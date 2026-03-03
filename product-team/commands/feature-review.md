---
description: 6-perspective team review of a feature with Go/No-Go decision
argument-hint: Feature to review (e.g., "AI schedule recommendation", "calendar widget")
---

# Feature Review

All 6 virtual product team members review a feature from their expert perspectives.

**Review Target**: $ARGUMENTS

---

## Phase 1: 6-Perspective Parallel Review

Invoke all 6 agents **in parallel** for independent reviews.

### PO A (Data)
> Review the following feature from a data/business perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for context
> 2. Business impact (revenue, conversion, retention effect)
> 3. Calculate ICE score
> 4. Data-based risk assessment
> 5. Score: 1-10 (business value)

### PO B (Intuitive)
> Review the following feature from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for context
> 2. User value (problem solving, satisfaction, differentiation)
> 3. Competitive analysis (similar features exist?)
> 4. Position in user journey
> 5. Score: 1-10 (user value)

### Designer
> Review the following feature from a UI/UX perspective: "$ARGUMENTS"
> 1. Scan the project's DesignSystem directory
> 2. UI consistency, HIG compliance, accessibility
> 3. User interaction quality
> 4. Design system integration level
> 5. Score: 1-10 (design quality)

### iOS Developer
> Review the following feature from a technical implementation perspective: "$ARGUMENTS"
> 1. Explore codebase for feasibility analysis
> 2. Technical debt, architecture impact
> 3. Performance and stability risks
> 4. Estimated effort
> 5. Score: 1-10 (technical quality/feasibility)

### Data Analyst
> Review the following feature from a measurement/analysis perspective: "$ARGUMENTS"
> 1. Measurability (can success/failure be determined?)
> 2. Required events and metrics
> 3. Can existing data validate the hypothesis?
> 4. A/B test necessity
> 5. Score: 1-10 (measurability)

### Marketer
> Review the following feature from a marketing/growth perspective: "$ARGUMENTS"
> 1. Marketing material value
> 2. Viral potential (sharing, spread)
> 3. ASO impact
> 4. Build in Public story material
> 5. Score: 1-10 (marketing value)

---

## Phase 2: Scorecard Summary

Compile all 6 reviews into a scorecard.

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

---

## Phase 3: Go/No-Go Decision

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
