# Opportunity Solution Tree (OST)

The Opportunity Solution Tree is a visual framework from Teresa Torres' Continuous Discovery Habits. It structures the path from a desired outcome to validated experiments, ensuring teams explore broadly before committing to solutions.

## Tree Structure

```
                    [Desired Outcome]
                    (Business metric)
                          |
            +-------------+-------------+
            |             |             |
      [Opportunity 1] [Opportunity 2] [Opportunity 3]
      (User need)     (Pain point)    (Desire)
            |             |             |
        +---+---+     +--+--+      +---+---+
        |       |     |     |      |       |
     [Sol A] [Sol B] [Sol C][Sol D][Sol E] [Sol F]
        |       |     |
     [Exp 1] [Exp 2] [Exp 3]
```

### Node Types

| Level | Node Type | Description | Example |
|-------|-----------|-------------|---------|
| 1 | **Outcome** | Measurable business metric tied to strategy | "Increase D7 retention from 35% to 50%" |
| 2 | **Opportunity** | User need, pain point, or desire discovered through research | "Users forget why they opened the app" |
| 3 | **Solution** | A specific product idea addressing an opportunity | "Daily digest push notification at 9am" |
| 4 | **Experiment** | A test to validate the riskiest assumption of a solution | "Fake door test: show notification settings, measure opt-in rate" |

## How to Define Good Outcomes

A good outcome is:

- **Measurable** — Has a number you can track (not "improve user experience")
- **Connected to business strategy** — Clearly supports a company-level goal
- **Within the team's influence** — The team can actually move this metric
- **Lagging indicator with leading proxies** — Revenue is a lagging indicator; activation rate is a leading proxy

### Outcome Quality Check

| Criteria | Bad Example | Good Example |
|----------|-------------|--------------|
| Measurable | "Better onboarding" | "Increase onboarding completion from 40% to 65%" |
| Strategic | "Add dark mode" (output) | "Increase D7 retention to 50%" (outcome) |
| Influenceable | "Increase total revenue" (too broad) | "Increase trial-to-paid conversion to 15%" |
| Time-bound | "Improve retention" | "Increase D7 retention to 50% by Q3" |

## How to Discover Opportunities

Opportunities come from understanding user behavior, not from brainstorming features. Sources:

### Primary Sources
- **User interviews** — Weekly habit, 1-2 interviews per week minimum
- **Behavioral data** — Analytics showing where users struggle, drop off, or succeed
- **Support tickets** — Patterns in what users ask for help with

### Secondary Sources
- **Session recordings** — Watch real users interact with your product
- **Survey open-ends** — Qualitative responses from NPS or CSAT surveys
- **Sales call notes** — Why prospects say no, what they wish existed
- **Community forums** — Reddit, Discord, app store reviews

### Writing Good Opportunity Statements

Format: **"[User segment] needs a way to [desired outcome] because [context/reason]."**

Examples:
- "Power users need a way to organize 50+ tasks without losing overview because their current list becomes overwhelming after 30 items."
- "New users need a way to see immediate value in the first session because they don't yet trust the product enough to invest setup time."

## Node Rules

### Branching Requirements
- Each **outcome** should have **3+ opportunities** (avoid tunnel vision)
- Each **opportunity** should have **3+ solutions** (avoid single-solution bias)
- Each **solution** needs at least **1 experiment** (no untested solutions on the roadmap)

### Why 3+ Solutions Per Opportunity?

The first solution you think of is rarely the best. Generating multiple solutions:
1. Reduces anchoring bias on the obvious solution
2. Creates options to compare (some will be faster/cheaper to test)
3. Forces creative thinking beyond the first idea

## Worked Example: "Increase D7 Retention"

```
Outcome: Increase D7 retention from 35% to 50%
|
+-- Opportunity 1: Users forget to come back after first session
|   |
|   +-- Solution A: Daily push notification with personalized content
|   |   +-- Experiment: Fake door test — show notification opt-in, measure rate
|   |
|   +-- Solution B: Email drip campaign days 1, 3, 5 with tips
|   |   +-- Experiment: Send to 500 new users, compare D7 retention vs control
|   |
|   +-- Solution C: In-app streak counter with visual progress
|       +-- Experiment: Prototype test with 5 users — do they mention the streak?
|
+-- Opportunity 2: Users don't find enough value in first session
|   |
|   +-- Solution D: Guided first-session tutorial (interactive)
|   |   +-- Experiment: Wizard of Oz — manually guide 10 new users, measure D7
|   |
|   +-- Solution E: Pre-populated sample data so product feels alive
|   |   +-- Experiment: A/B test sample data vs empty state for 1000 new users
|   |
|   +-- Solution F: Quick-win onboarding task that delivers immediate value
|       +-- Experiment: Interview 5 retained users — what was their first "aha moment"?
|
+-- Opportunity 3: Users hit a confusing UX dead-end on day 2-3
    |
    +-- Solution G: Contextual tooltips triggered on second visit
    |   +-- Experiment: Clickthrough rate on tooltips in prototype
    |
    +-- Solution H: Simplified navigation with progressive disclosure
    |   +-- Experiment: Card sort study with 8 users — can they find key features?
    |
    +-- Solution I: "What to do next" smart suggestions
        +-- Experiment: Survey — show 3 suggestion mockups, rank usefulness
```

## Common Mistakes

### 1. Jumping to Solutions
**Problem:** Team skips from outcome directly to solutions without discovering opportunities.
**Fix:** Force an "opportunity discovery phase" before any solution ideation. Interview at least 5 users first.

### 2. Single-Solution Bias
**Problem:** Only one solution per opportunity — the first idea that came up.
**Fix:** Use "How Might We" brainstorming to generate 5+ solutions, then narrow to 3.

### 3. Outcome = Output Confusion
**Problem:** "Launch feature X" is an output, not an outcome. Outputs don't guarantee results.
**Fix:** Ask "Why do we want to launch feature X? What metric will improve?" That answer is the outcome.

### 4. Opportunities That Are Actually Solutions
**Problem:** "Users need a search bar" is a solution disguised as an opportunity.
**Fix:** Reframe: "Users need a way to quickly find specific items in a large collection." Now multiple solutions become possible (search, filters, categories, favorites).

### 5. No Experiments Before Building
**Problem:** Team picks a solution and builds it fully without testing assumptions.
**Fix:** For every solution, identify the riskiest assumption and design the cheapest possible test.

### 6. Static Tree
**Problem:** The tree is created once and never updated.
**Fix:** Update the tree weekly based on new interview data, experiment results, and analytics. Prune dead branches, add new ones.

## Building Your OST: Step by Step

1. **Start with the outcome** — Get alignment from leadership on the metric
2. **Interview 5-10 users** — Listen for needs, pain points, desires
3. **Synthesize into opportunities** — Group interview findings into themes
4. **Brainstorm solutions** — 3+ per opportunity, no judgment during ideation
5. **Identify assumptions** — For each solution, what must be true for it to work?
6. **Design experiments** — Test the riskiest assumption with the cheapest method
7. **Run, learn, update** — Update the tree based on results. Prune or expand.
8. **Repeat weekly** — Continuous discovery, not a one-time exercise
