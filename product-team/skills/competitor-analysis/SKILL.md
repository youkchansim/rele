---
name: competitor-analysis
description: >
  This skill should be used when analyzing competitors, comparing features,
  evaluating market positioning, or identifying differentiation opportunities.
  Useful for "analyze competitors", "compare features", "market positioning",
  "what are similar apps doing", "find differentiation opportunities".
user-invocable: false
---

# Competitor Analysis Framework

Led by PO B (Intuitive), with Marketer participation. Structured competitor analysis tool.

## Analysis Structure

```markdown
## Competitor Analysis: [Category/Feature]

### 1. Competitor Mapping

| App | Core Value | Target Users | Price | Rating | Differentiator |
|-----|-----------|-------------|-------|--------|----------------|
| [A] | | | | | |
| [B] | | | | | |
| [Ours] | | | | | |

### 2. Feature Comparison Matrix

| Feature | Ours | A | B | Importance |
|---------|:----:|:---:|:---:|:----------:|
| [Feature 1] | Y/N | Y/N | Y/N | High/Med/Low |

### 3. User Reactions (Community)

**Reddit Insights:**
- [Subreddit]: [Key reactions/request patterns]

**HN Insights:**
- [Related discussion]: [Developer community reactions]

**App Store Review Patterns:**
- Positive: [Recurring praise patterns]
- Negative: [Recurring complaint patterns]
- Requests: [Features users are asking for]

### 4. Positioning Analysis

```
                High Functionality
                    |
          [App B] --+---- [App A]
                    |
    Simple ---------+------------- Complex
                    |
          [Ours] --+----
                    |
                Low Functionality
```

### 5. Differentiation Opportunities

- **Under-served needs**: [Areas competitors fail to address]
- **Over-served needs**: [Areas unnecessarily complex]
- **Blue Ocean**: [Areas nobody has attempted]
```

## Workflow

### Phase 1: Competitor Identification
1. WebSearch for top apps in the category
2. Check App Store category rankings
3. Explore apps recommended on Reddit/HN

### Phase 2: Deep Analysis
1. Analyze each competitor's core value proposition
2. Compare pricing models (free/freemium/subscription)
3. Update history -> infer strategic direction
4. Analyze user review patterns

### Phase 3: Opportunity Discovery
1. Find opportunities in competitor weaknesses
2. Identify unmet needs from community requests
3. Prioritize areas that intersect with our unique strengths

### Phase 4: Strategy Proposal
1. Short-term (1-2 weeks): Quick Win differentiation
2. Medium-term (1-3 months): Core differentiating features
3. Long-term (3-6 months): Category redefinition

## Data Sources

- **Reddit MCP**: r/productivity, r/apps, r/iphone, r/iosdev
- **HN MCP**: Show HN, related discussions
- **WebSearch**: App Store reviews, media reviews, trend articles
- **RevenueCat**: (when available) Benchmark against our own app

## Deliverable

Save analysis results to `docs/decisions/YYYY-MM-DD-competitor-{topic}.md`.
