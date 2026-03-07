# ICE & RICE Scoring Frameworks

## ICE Framework

ICE is a lightweight prioritization method ideal for small teams or solo developers who need to rank ideas quickly without extensive data.

### Formula

```
ICE Score = Impact x Confidence x Ease
```

Each factor is scored on a **1-10 scale**.

### Factor Definitions

| Factor | Score Range | What It Measures |
|--------|-----------|-----------------|
| **Impact** | 1-10 | How much will this move the target metric? |
| **Confidence** | 1-10 | How sure are we about Impact and Ease estimates? |
| **Ease** | 1-10 | How easy is this to implement? (10 = trivial, 1 = massive effort) |

### Scoring Calibration Guide

**Impact Scale:**
- 10: Doubles or more the key metric
- 8: 50%+ improvement on key metric
- 6: 20-50% improvement
- 4: 5-20% improvement
- 2: < 5% improvement
- 1: Negligible or unmeasurable impact

**Confidence Scale:**
- 10: Strong data backing (A/B test results, validated research)
- 8: Good evidence (user interviews, analytics trends)
- 6: Moderate evidence (competitive analysis, expert opinion)
- 4: Educated guess based on experience
- 2: Pure gut feeling
- 1: Wild speculation

**Ease Scale:**
- 10: Less than 1 day of work, no dependencies
- 8: 1-3 days, minimal dependencies
- 6: 1 week, some coordination needed
- 4: 2-3 weeks, multiple team members
- 2: 1+ months, heavy cross-team coordination
- 1: Quarter+ effort, architectural changes required

### Worked Example: "Add Dark Mode"

| Factor | Score | Rationale |
|--------|-------|-----------|
| Impact | 6 | Improves retention for night-time users (~25% of base) |
| Confidence | 7 | Multiple user requests, competitor data available |
| Ease | 4 | Requires theming system, touches every screen |

**ICE Score = 6 x 7 x 4 = 168**

---

## RICE Framework

RICE extends ICE by adding an explicit **Reach** factor, making it better suited for teams with usage data and larger user bases.

### Formula

```
RICE Score = (Reach x Impact x Confidence) / Effort
```

### Factor Definitions

| Factor | Type | What It Measures |
|--------|------|-----------------|
| **Reach** | Number | How many users/events will this affect per time period? |
| **Impact** | Scale (0.25-3) | How much will each affected user benefit? |
| **Confidence** | Percentage (0-100%) | How sure are we about our estimates? |
| **Effort** | Person-weeks | How much work is required? |

### Impact Scale (RICE-specific)

| Score | Meaning |
|-------|---------|
| 3 | Massive impact |
| 2 | High impact |
| 1 | Medium impact |
| 0.5 | Low impact |
| 0.25 | Minimal impact |

### Confidence Guidelines

| Confidence | Meaning |
|------------|---------|
| 100% | Strong evidence: validated data, past experiments |
| 80% | Good evidence: user research, strong signals |
| 50% | Some evidence: anecdotal feedback, competitive benchmarks |
| 20% | Weak evidence: gut feeling, untested hypothesis |

### Worked Example: "Push Notification Reminders"

| Factor | Value | Rationale |
|--------|-------|-----------|
| Reach | 15,000 users/quarter | 60% of 25K MAU have notifications enabled |
| Impact | 2 (High) | Directly drives re-engagement |
| Confidence | 80% | Similar feature at competitor showed +18% DAU |
| Effort | 3 person-weeks | Backend scheduling + notification service + settings UI |

**RICE Score = (15,000 x 2 x 0.80) / 3 = 8,000**

---

## When to Use ICE vs RICE

| Criteria | ICE | RICE |
|----------|-----|------|
| Team size | Solo or small team | Medium to large team |
| Data availability | Limited user data | Strong analytics/reach data |
| Decision speed | Quick gut-check ranking | Deliberate, data-backed ranking |
| Stakeholder buy-in | Informal decisions | Need to justify to leadership |
| Scale sensitivity | Features affect all users similarly | Features vary widely in user reach |

**Rule of thumb:** Start with ICE. Graduate to RICE when you have reliable reach data and need to communicate priorities to stakeholders.

---

## Common Pitfalls

### 1. Overconfidence Bias
Teams consistently rate their own ideas with high confidence. **Fix:** Require evidence citations for any confidence score above 70%. Ask "What data supports this?"

### 2. Inconsistent Scales
Different team members interpret "Impact = 7" differently. **Fix:** Create a team-specific calibration table anchored to past shipped features. Example: "Feature X that increased retention by 12% was Impact = 5."

### 3. Gaming Scores
People inflate scores for features they're passionate about. **Fix:** Score independently first, then discuss outliers. Use median scores rather than averages.

### 4. Ignoring Dependencies
A high-scoring feature may depend on low-scoring infrastructure work. **Fix:** Score the full dependency chain, not just the end feature.

### 5. Comparing Across Categories
A growth feature and a tech-debt item shouldn't compete directly — they serve different strategic goals. **Fix:** Prioritize within categories first, then allocate budget across categories.

---

## Calibration Tips

1. **Anchor with past features:** Score 3-5 previously shipped features as a team calibration exercise. Use these as reference points.
2. **Use team consensus:** Have each team member score independently, then review where scores diverge by more than 2 points.
3. **Re-score quarterly:** As your product matures, recalibrate your scales — a "high impact" feature in year 1 is different from year 3.
4. **Document rationale:** Always record *why* a score was given, not just the number. This makes future calibration easier.
5. **Separate scoring from deciding:** Score first, then look at the ranked list. Discuss any results that feel "wrong" — they often reveal hidden assumptions.
