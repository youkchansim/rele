# Opportunity Scoring & Kano Model

## Opportunity Scoring (Outcome-Driven Innovation)

Opportunity Scoring, from Tony Ulwick's Outcome-Driven Innovation (ODI) methodology, identifies **underserved user needs** by measuring the gap between how important an outcome is and how satisfied users currently are.

### Formula

```
Opportunity Score = Importance + max(Importance - Satisfaction, 0)
```

Both Importance and Satisfaction are measured on a **1-10 scale** via user survey.

### Score Interpretation

| Opportunity Score | Meaning | Action |
|-------------------|---------|--------|
| 15+ | Massively underserved | Top priority — high impact opportunity |
| 12-15 | Significantly underserved | Strong candidate for investment |
| 10-12 | Moderately underserved | Worth exploring, validate further |
| 5-10 | Appropriately served | Low priority — users are satisfied enough |
| < 5 | Overserved | Potential to simplify or remove features |

### Survey Design

Ask users to rate each **desired outcome** (not feature) on two dimensions:

**Importance question:**
> "When [doing the job], how important is it to you to [desired outcome]?"
> Scale: 1 (Not at all important) to 10 (Extremely important)

**Satisfaction question:**
> "How satisfied are you with existing solutions for [desired outcome]?"
> Scale: 1 (Not at all satisfied) to 10 (Extremely satisfied)

### Worked Example: Task Management App

| Desired Outcome | Importance | Satisfaction | Opp Score |
|----------------|------------|--------------|-----------|
| Quickly capture a task without losing context | 9 | 4 | 9 + (9-4) = 14 |
| See only what's relevant for today | 8 | 6 | 8 + (8-6) = 10 |
| Know exactly when a deadline is at risk | 9 | 7 | 9 + (9-7) = 11 |
| Easily delegate tasks to teammates | 6 | 5 | 6 + (6-5) = 7 |
| Review completed work for the week | 5 | 7 | 5 + 0 = 5 |

**Top opportunity:** "Quickly capture a task without losing context" (score 14) — users find it very important but poorly served by existing solutions.

### When to Use Opportunity Scoring

- You want to discover what to build (not just rank what you already have)
- You have access to users for surveying (need 30+ responses for reliability)
- You want to identify gaps competitors haven't filled
- You're entering a new market or rethinking your product's core

---

## Kano Model

The Kano Model categorizes features by how they affect user satisfaction. Not all features work the same way — some are expected (their absence causes frustration), while others delight (their presence creates joy).

### The 5 Categories

| Category | Absent | Present | Description |
|----------|--------|---------|-------------|
| **Must-Be** (Basic) | Dissatisfied | Neutral | Expected features. Users don't notice when present, but are frustrated when absent. |
| **One-Dimensional** (Performance) | Dissatisfied | Satisfied | Linear relationship — more is better. Satisfaction scales with delivery. |
| **Attractive** (Delighters) | Neutral | Delighted | Unexpected features that create disproportionate satisfaction. |
| **Indifferent** | Neutral | Neutral | Users don't care either way. |
| **Reverse** | Satisfied | Dissatisfied | Features some users actively dislike. |

### Functional / Dysfunctional Questionnaire

For each feature, ask **two questions:**

**Functional (positive) form:**
> "If [feature] were available, how would you feel?"

**Dysfunctional (negative) form:**
> "If [feature] were NOT available, how would you feel?"

**Answer options for both:**
1. I like it
2. I expect it
3. I'm neutral
4. I can tolerate it
5. I dislike it

### Kano Evaluation Table

Cross-reference functional and dysfunctional answers:

| | **Dysfunctional: Like** | **Expect** | **Neutral** | **Tolerate** | **Dislike** |
|---|---|---|---|---|---|
| **Functional: Like** | Q | A | A | A | O |
| **Expect** | R | I | I | I | M |
| **Neutral** | R | I | I | I | M |
| **Tolerate** | R | I | I | I | M |
| **Dislike** | R | R | R | R | Q |

**Legend:** M = Must-Be, O = One-Dimensional, A = Attractive, I = Indifferent, R = Reverse, Q = Questionable

### Worked Example: Fitness App Features

| Feature | Category | Rationale |
|---------|----------|-----------|
| App doesn't crash during workout | Must-Be | Users expect stability; crashes cause frustration |
| Accurate calorie tracking | One-Dimensional | More accuracy = more satisfaction |
| AI-generated workout music | Attractive | Nobody expects it; delights those who discover it |
| Social sharing to Facebook | Indifferent | Most users don't care |
| Mandatory social login | Reverse | Many users actively dislike forced social login |

### Category Shift Over Time

Kano categories are not permanent. Features naturally migrate:

```
Attractive --> One-Dimensional --> Must-Be
(Delighter)    (Expected more)    (Baseline)
```

**Example:** Smartphone touchscreens were Attractive in 2007, One-Dimensional by 2010, and Must-Be by 2013.

**Implication:** Continuously invest in new Attractive features while maintaining Must-Be quality. Yesterday's delighter is tomorrow's baseline.

### When to Use the Kano Model

- You want to understand *how* features affect satisfaction, not just rank them
- You're deciding between maintenance (Must-Be) and innovation (Attractive)
- You need to justify cutting features (Indifferent or Reverse)
- You're designing a new product and need to separate "must ship" from "nice to have"
- You have access to 20+ users for the paired questionnaire

---

## Opportunity Score vs Kano: When to Use Which

| Criteria | Opportunity Score | Kano Model |
|----------|-------------------|------------|
| Goal | Find underserved needs | Classify feature types |
| Input | Importance + Satisfaction survey | Functional/Dysfunctional pairs |
| Output | Ranked opportunity scores | Feature category classification |
| Best for | "What should we build?" | "What kind of feature is this?" |
| Sample size | 30+ respondents | 20+ respondents |
| Combines with | OST (discovery) | Roadmap planning, release scoping |

**Use together:** Run Opportunity Scoring to find the biggest gaps, then use Kano to understand whether your proposed solution is a Must-Be fix, a Performance improvement, or a potential Delighter.
