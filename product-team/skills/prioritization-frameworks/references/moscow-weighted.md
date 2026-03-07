# MoSCoW & Weighted Scoring

## MoSCoW Prioritization

MoSCoW is a categorical prioritization technique used for release planning and stakeholder alignment. Each feature is placed into one of four buckets, creating clear shared understanding of what's in and out of scope.

### The Four Buckets

| Bucket | Definition | Guideline |
|--------|-----------|-----------|
| **Must Have** | Non-negotiable for the release. Without these, the release has no value or is not viable. | ~60% of effort |
| **Should Have** | Important but not critical. The release works without them, but they add significant value. | ~20% of effort |
| **Could Have** | Nice-to-have features. Include if time/budget allows, cut first when under pressure. | ~20% of effort |
| **Won't Have (this time)** | Explicitly out of scope for this release. Acknowledged as valuable but deferred. | 0% of effort |

### Percentage Guidelines (60/20/20)

The 60/20/20 rule ensures buffer capacity:

- **Must Have: ~60%** of total planned effort. If Must Haves exceed 60%, you're overcommitted. Any delay will cause the release to fail.
- **Should Have: ~20%** of total effort. These are your first line of cuts if Must Haves take longer than expected.
- **Could Have: ~20%** of total effort. Second buffer. Expect these to be cut in most releases.

**Why this works:** The 40% buffer (Should + Could) protects the release from inevitable estimation errors and scope creep.

### Classification Rules

Ask these questions in order:

1. **"Will the release fail without this?"** Yes = Must Have
2. **"Is this painful to live without but we can work around it?"** Yes = Should Have
3. **"Would users appreciate this but won't miss it?"** Yes = Could Have
4. **"Is this out of scope for now?"** Yes = Won't Have

### Worked Example: E-commerce Checkout Redesign

**Must Have (60% effort):**
- Payment processing (credit card, Apple Pay)
- Order confirmation email
- Address validation
- Cart persistence across sessions
- Error handling for failed payments

**Should Have (20% effort):**
- Guest checkout (no account required)
- Order tracking page
- Save payment method for future use

**Could Have (20% effort):**
- One-click reorder
- Gift wrapping option
- Delivery time slot selection

**Won't Have (this time):**
- Cryptocurrency payments
- AR product preview in checkout
- Social checkout (buy through Instagram)

### Facilitation Tips

1. **Start with Won't Have.** It's psychologically easier to exclude features first, and it sets realistic expectations early.
2. **Challenge every Must Have.** Ask: "What happens if we ship without this?" If the answer isn't "the release is unusable/illegal/dangerous," downgrade it.
3. **Timebox the discussion.** Give each feature max 3 minutes of debate. If no consensus, park it and return at the end.
4. **Use stakeholder voting.** Give each participant 5 "Must Have tokens." Forces trade-offs.
5. **Separate technical Must Haves from business Must Haves.** Security fixes and compliance requirements are non-negotiable; don't let them compete with product features.

### Common Mistakes

| Mistake | Problem | Fix |
|---------|---------|-----|
| Everything is Must Have | No prioritization has occurred | Apply the 60% rule strictly |
| No Won't Have items | Scope is implicitly unlimited | Force at least 3 Won't Haves per release |
| Must Have = "I want it" | Personal preference, not business criticality | Require failure scenario for every Must Have |
| Ignoring the Could Have bucket | Lost opportunity for quick wins | Review Could Haves weekly for low-effort items |
| Never revisiting Won't Have | Good ideas get permanently lost | Review Won't Haves at next planning cycle |

---

## Weighted Scoring

Weighted Scoring is a structured multi-criteria decision method for complex prioritization where different factors matter in different degrees. It's the most rigorous framework — use it when stakes are high and you need defensible decisions.

### Process

1. **Select criteria** (4-7 recommended)
2. **Assign weights** (must total 100%)
3. **Score each feature** on every criterion (1-5 or 1-10 scale)
4. **Calculate weighted score** for each feature
5. **Rank and discuss** the results

### Step 1: Select Criteria

Choose criteria that reflect your current strategic priorities. Common criteria:

| Criterion | What It Measures |
|-----------|-----------------|
| Strategic Alignment | How well does this support our current strategy/OKRs? |
| User Impact | How much value does this deliver to users? |
| Revenue Potential | How much revenue could this generate or protect? |
| Implementation Effort | How much work is required? (reverse-scored: less effort = higher score) |
| Technical Risk | How risky is the implementation? (reverse-scored: less risk = higher score) |
| Time Sensitivity | Is there a deadline or market window? |
| Data/Evidence | How much evidence supports this idea? |

### Step 2: Assign Weights

Weights reflect relative importance of each criterion. They must total 100%.

**Example weight distribution for a growth-stage startup:**

| Criterion | Weight | Rationale |
|-----------|--------|-----------|
| User Impact | 30% | Users first at this stage |
| Revenue Potential | 25% | Need to prove monetization |
| Strategic Alignment | 20% | Stay focused on core vision |
| Implementation Effort | 15% | Small team, effort matters |
| Technical Risk | 10% | Acceptable risk tolerance at this stage |
| **Total** | **100%** | |

### Step 3-4: Score and Calculate

Use a consistent scale (1-5 recommended for simplicity).

### Scoring Scale

| Score | Meaning |
|-------|---------|
| 5 | Exceptional |
| 4 | Strong |
| 3 | Moderate |
| 2 | Weak |
| 1 | Minimal/None |

### Worked Example: Scoring Matrix

**Features being compared:**
- A: Collaborative editing
- B: Advanced analytics dashboard
- C: Mobile app offline mode

| Criterion | Weight | Feature A | Feature B | Feature C |
|-----------|--------|-----------|-----------|-----------|
| User Impact | 30% | 5 (1.50) | 3 (0.90) | 4 (1.20) |
| Revenue Potential | 25% | 4 (1.00) | 5 (1.25) | 2 (0.50) |
| Strategic Alignment | 20% | 4 (0.80) | 3 (0.60) | 5 (1.00) |
| Implementation Effort | 15% | 2 (0.30) | 3 (0.45) | 4 (0.60) |
| Technical Risk | 10% | 3 (0.30) | 4 (0.40) | 3 (0.30) |
| **Weighted Total** | | **3.90** | **3.60** | **3.60** |

**Calculation example for Feature A, User Impact:**
Score (5) x Weight (0.30) = 1.50

**Result:** Feature A (Collaborative editing) ranks highest at 3.90.

### Normalization

When comparing features scored by different people or at different times, normalize scores:

```
Normalized Score = (Raw Score - Min Score) / (Max Score - Min Score) x 100
```

This converts all scores to a 0-100 scale for fair comparison.

### Template

```markdown
## Weighted Scoring Matrix

**Date:** [YYYY-MM-DD]
**Scored by:** [Team members]
**Context:** [Release/quarter/initiative]

### Criteria & Weights

| # | Criterion | Weight | Description |
|---|-----------|--------|-------------|
| 1 | [Criterion] | [X%] | [What this measures] |
| 2 | [Criterion] | [X%] | [What this measures] |
| 3 | [Criterion] | [X%] | [What this measures] |
| 4 | [Criterion] | [X%] | [What this measures] |
| 5 | [Criterion] | [X%] | [What this measures] |
| | **Total** | **100%** | |

### Scoring (1-5 scale)

| Feature | C1 | C2 | C3 | C4 | C5 | Weighted Total |
|---------|----|----|----|----|----|----|
| [Feature A] | | | | | | |
| [Feature B] | | | | | | |
| [Feature C] | | | | | | |

### Decision
- **Selected:** [Feature(s)]
- **Rationale:** [Why the score aligns with strategic intent]
- **Deferred:** [Feature(s) and reason]
```

---

## MoSCoW vs Weighted Scoring: When to Use Which

| Criteria | MoSCoW | Weighted Scoring |
|----------|--------|-----------------|
| Speed | Fast (30-60 min workshop) | Slower (requires setup + scoring) |
| Rigor | Low-medium (categorical) | High (quantitative) |
| Best for | Release scoping, sprint planning | Strategic roadmap decisions, investment cases |
| Stakeholder type | Mixed technical/business | Leadership, cross-functional teams |
| Output | Categorical buckets | Ranked numerical scores |
| Risk of gaming | Low (binary classification) | Medium (score inflation possible) |

**Combine them:** Use MoSCoW for release-level scoping (what's in/out), then use Weighted Scoring within the "Must Have" and "Should Have" buckets to determine implementation order.
