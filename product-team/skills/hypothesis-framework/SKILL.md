---
name: hypothesis-framework
description: >
  This skill should be used when structuring business hypotheses with ICE scoring,
  defining success metrics, and quantifying business impact for feature proposals.
  Useful for "plan a feature", "evaluate this idea", "prioritize features",
  "ICE score this proposal", "structure a hypothesis", "compare feature options".
user-invocable: false
---

# Hypothesis Framework

Shared tool for PO A (Data) and PO B (Intuitive) to structure ideas into testable hypotheses.

## Hypothesis Structure (Required Format)

Every hypothesis must follow this format:

```markdown
## Hypothesis: [Title]

### 1. Hypothesis Statement
If we [change/action],
then [target users]' [behavior/metric]
will change by [direction + target amount].
Because [evidence/mechanism].

### 2. ICE Score
- **Impact** (1-10): [Business impact magnitude]
  - Evidence: [Why this score]
- **Confidence** (1-10): [Success confidence level]
  - Evidence: [Data/cases/intuition basis]
- **Ease** (1-10): [Implementation ease, solo-developer scale]
  - Evidence: [Estimated effort, technical difficulty]
- **Total**: I x C x E = ???

### 3. Success Metrics
- **Primary KPI**: [Core metric] — current -> target
- **Secondary KPI**: [Supporting metric] — current -> target
- **Guard Rail**: [Metric that must not degrade]

### 4. Validation Method
- **Type**: [A/B test / Before-After / Qualitative feedback]
- **Minimum sample**: [Required user count]
- **Duration**: [Days/weeks]
- **Decision criteria**: [Success/failure threshold]

### 5. Business Impact
- **Revenue effect**: [Expected ARR/MRR change]
- **User effect**: [Retention/active user change]
- **Strategic value**: [Connection to long-term vision]
```

## Filled Example

```markdown
## Hypothesis: Move Paywall After Onboarding Completion

### 1. Hypothesis Statement
If we move the paywall trigger from app launch to after completing the first schedule creation,
then new users' trial start rate
will increase by +15% (from 8% to ~9.2%).
Because users who experience the core value first are more likely to convert.

### 2. ICE Score
- **Impact** (8): Directly affects trial start rate -> revenue pipeline
- **Confidence** (6): Similar pattern seen in Todoist, but our context differs
- **Ease** (9): Simple trigger point change, ~2 hours of work
- **Total**: 8 x 6 x 9 = 432

### 3. Success Metrics
- **Primary KPI**: Trial Start Rate — 8.0% -> 9.2%
- **Secondary KPI**: D7 Retention — 25% -> maintain or improve
- **Guard Rail**: Immediate uninstall rate must not increase

### 4. Validation Method
- **Type**: Before-After (2 weeks each)
- **Minimum sample**: 500 new installs per period
- **Duration**: 4 weeks total
- **Decision criteria**: Trial start rate +10% or more = success
```

## Workflow

### Phase 1: Idea Collection
1. Check North Star metrics in project CLAUDE.md
2. Review current metric state (RevenueCat/Amplitude data)
3. Identify idea source (data-driven / intuition-based / external trend)

### Phase 2: Hypothesis Structuring
1. Write hypothesis using the format above
2. When scoring ICE, integrate both PO perspectives:
   - PO A: Support Impact/Confidence with data
   - PO B: Reflect user empathy/market trends in Confidence

### Phase 3: Prioritization
1. Sort by ICE total score
2. Map dependency relationships
3. Factor in solo-developer resource constraints
4. Identify Quick Wins (high E, adequate I) first

### Phase 4: Record
- Save hypotheses to `docs/decisions/`
- Filename: `YYYY-MM-DD-hypothesis-{topic}.md`

## Hypothesis Quality Checklist

- [ ] Contains measurable metrics?
- [ ] Validation timeline is realistic?
- [ ] Scope achievable as a solo developer?
- [ ] Connected to North Star metric?
- [ ] Structured to learn from failure?

## Anti-Patterns

- "Users will love it" -> Which users? How do we measure?
- "Revenue will grow" -> By how much? Through what mechanism?
- "Competitors are doing it" -> Is it valid for our users too?
- All ICE scores 8+ -> Watch for overconfidence bias
