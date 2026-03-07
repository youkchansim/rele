---
name: user-research-synthesis
description: >
  This skill should be used when synthesizing user research data, performing thematic
  analysis on feedback, building evidence-based personas, or analyzing App Store reviews
  and community discussions.
  Useful for "analyze user feedback", "thematic analysis", "build personas",
  "synthesize research", "App Store review analysis", "Reddit feedback patterns",
  "affinity mapping", "user research findings".
user-invocable: false
---

# User Research Synthesis Framework

PO B (Intuitive) skill for transforming qualitative data from multiple sources into actionable product insights.

## Research Sources for Indie iOS Apps

| Source | What It Reveals | How to Access |
|--------|----------------|---------------|
| App Store Reviews | Satisfaction drivers, bugs, feature requests | App Store Connect / manual |
| Reddit (r/productivity, r/apps, r/iphone) | Community needs, competitor sentiment | Reddit MCP |
| Hacker News (Show HN, Ask HN) | Tech-savvy user perspectives, market trends | HN MCP |
| Support Emails / In-app Feedback | Direct pain points, UX confusion | Manual collection |
| Social Media Mentions | Organic sentiment, viral moments | WebSearch |
| Beta Tester Feedback | Pre-release usability issues | TestFlight notes |

## Thematic Analysis (6-Step Process)

### Step 1: Familiarization
- Read through all collected feedback without coding
- Note initial impressions and recurring phrases
- Count total data points per source

### Step 2: Initial Coding
```markdown
## Coding Sheet

| Source | Raw Quote | Initial Code | Sentiment |
|--------|-----------|-------------|-----------|
| App Store Review | "Love the app but wish it had..." | missing-feature-X | Mixed |
| Reddit r/productivity | "I switched from Y because..." | competitor-switching | Positive |
| HN comment | "The onboarding confused me" | onboarding-friction | Negative |
```

### Step 3: Theme Generation
Group codes into candidate themes:
```markdown
## Candidate Themes

### Theme 1: [Name]
- Codes: [code-a], [code-b], [code-c]
- Frequency: [N] mentions across [N] sources
- Example quotes: [2-3 representative quotes]

### Theme 2: [Name]
- Codes: [code-d], [code-e]
- Frequency: [N] mentions across [N] sources
- Example quotes: [2-3 representative quotes]
```

### Step 4: Theme Review
- Does each theme have enough data to support it?
- Are themes distinct or should some merge?
- Does the theme map cover the full dataset?

### Step 5: Theme Definition
Each final theme gets:
- **Name**: Concise, descriptive label
- **Definition**: 1-2 sentence description
- **Evidence count**: Number of data points
- **Source breadth**: How many different sources support it
- **Strength**: Strong (many sources, high frequency) / Moderate / Emerging

### Step 6: Synthesis Report
See deliverable template below.

## Affinity Mapping

### Process
1. **Extract insights**: One insight per "card" from each data source
2. **Sort bottom-up**: Group related insights without pre-defined categories
3. **Name clusters**: Give each group a descriptive label
4. **Identify hierarchy**: Which clusters are parent themes, which are sub-themes?
5. **Prioritize**: Rank by frequency + impact + breadth of sources

### Template
```markdown
## Affinity Map: [Research Topic]

### Cluster 1: [Theme Name] (N insights)
  - Sub-group A: [Label] (N insights)
    - "[Quote 1]" — Source
    - "[Quote 2]" — Source
  - Sub-group B: [Label] (N insights)
    - "[Quote 3]" — Source

### Cluster 2: [Theme Name] (N insights)
  ...
```

## Triangulation

### Multi-Source Validation
An insight is strongest when confirmed across multiple sources:

| Confidence Level | Criteria |
|-----------------|---------|
| **High** | 3+ sources agree (e.g., App Store + Reddit + Support) |
| **Moderate** | 2 sources agree |
| **Emerging** | 1 source, but high volume or strong signal |
| **Weak** | Single data point, not corroborated |

### Triangulation Matrix
```markdown
| Insight | App Store | Reddit | HN | Support | Confidence |
|---------|-----------|--------|-------|---------|-----------|
| [Insight A] | Y (12) | Y (5) | N | Y (3) | High |
| [Insight B] | N | Y (8) | Y (2) | N | Moderate |
| [Insight C] | Y (2) | N | N | N | Emerging |
```

## Interview Note Analysis

### Signal Types
When analyzing user feedback (interviews, reviews, comments):

1. **Behavior signals** (strongest) — What users actually do
   - "I use the app every morning at 7am"
   - "I stopped using feature X after the update"

2. **Problem signals** (strong) — Pain points and frustrations
   - "I can't figure out how to..."
   - "It takes too long to..."

3. **Request signals** (moderate) — Feature requests (interpret with caution)
   - "I wish it could..." (often a solution, not the real problem)
   - Dig deeper: "What are you trying to accomplish?"

4. **Preference signals** (weaker) — Stated preferences
   - "I prefer dark mode" (useful but lower priority than behavior data)

### Intensity Indicators
| Indicator | Signal | Interpretation |
|-----------|--------|---------------|
| Emotional language | "I LOVE / HATE this" | Strong feeling, worth investigating |
| Repetition | Same point mentioned multiple times | High priority for the user |
| Comparison | "Unlike app X, this doesn't..." | Competitive gap |
| Workaround | "I have to use a separate app to..." | Unmet need |
| Abandonment | "I stopped using it because..." | Critical issue |

## Persona Development

### Evidence-Based Personas
Build personas from data, not assumptions:

```markdown
## Persona: [Name]

### Demographics & Context
- Who: [Brief description]
- Device: [iOS version, device type if relevant]
- Usage pattern: [When, how often, how long]

### Goals
- Primary: [What they're trying to achieve]
- Secondary: [Additional goals]

### Behaviors (from data)
- [Observed behavior 1] — Evidence: [Source + count]
- [Observed behavior 2] — Evidence: [Source + count]

### Pain Points (from data)
- [Pain point 1] — Evidence: [Source + count]
- [Pain point 2] — Evidence: [Source + count]

### Trigger to Use App
- [What prompts them to open the app]

### Success Criteria
- [How they judge if the app is working for them]
```

### Persona Rules
- **3-5 personas max**: More than that and they lose focus
- **Behavior-based, not demographic**: Group by what users do, not who they are
- **Evidence required**: Every trait must cite data sources
- **Living documents**: Update as new research comes in

## Opportunity Sizing

### Impact Assessment Matrix
```markdown
## Opportunity Assessment

| Opportunity | Impact (1-5) | Frequency (1-5) | Severity (1-5) | Score | Evidence |
|------------|-------------|-----------------|----------------|-------|----------|
| [Opp A] | | | | | [N] mentions, [sources] |
| [Opp B] | | | | | [N] mentions, [sources] |
```

- **Impact**: How many users would benefit? (1=few, 5=most users)
- **Frequency**: How often does this need arise? (1=rarely, 5=daily)
- **Severity**: How much does the current state frustrate? (1=mild, 5=blocking)
- **Score**: Impact x Frequency x Severity (max 125)

## App Store Review Analysis

### Structured Analysis
```markdown
## App Store Review Analysis: [Period]

### Volume & Rating
- Total reviews: [N]
- Average rating: [Score]
- Rating trend: [Improving / Stable / Declining]

### Theme Extraction
| Theme | Frequency | Avg Rating | Sentiment | Actionable? |
|-------|-----------|-----------|-----------|------------|
| [Theme 1] | N reviews | Stars | Pos/Neg | Yes/No |

### Feature Request Ranking
| Requested Feature | Frequency | Matches Roadmap? |
|-------------------|-----------|-----------------|
| [Feature A] | N mentions | Yes / No / Partial |

### Critical Issues (1-2 star reviews)
| Issue | Frequency | Reproducible? | Priority |
|-------|-----------|--------------|----------|
| [Bug/Issue] | N | Yes/No | P1/P2/P3 |
```

## Community Research (Reddit / HN)

### Collection Template
```markdown
## Community Research: [Topic]

### Sources Scanned
- Reddit: [subreddits, date range, N posts/comments analyzed]
- HN: [threads, date range, N comments analyzed]

### Key Findings
| Finding | Source | Volume | Confidence |
|---------|--------|--------|-----------|
| [Finding 1] | Reddit r/X (N), HN (N) | High | High |

### Competitor Mentions
| Competitor | Sentiment | Key Praise | Key Criticism |
|-----------|-----------|-----------|--------------|
| [App A] | Positive/Mixed | | |

### Unmet Needs
| Need | Evidence | Opportunity Size |
|------|----------|-----------------|
| [Need A] | [N] mentions across [sources] | Large/Medium/Small |
```

## Deliverable

Save research synthesis to `docs/decisions/YYYY-MM-DD-research-{topic}.md`.
