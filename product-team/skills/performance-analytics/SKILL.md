---
name: performance-analytics
description: >
  This skill should be used when analyzing marketing channel performance, App Store
  metrics, attribution models, or optimizing growth loops.
  Useful for "channel performance", "ASO metrics", "attribution analysis",
  "marketing ROI", "download conversion", "App Store analytics",
  "growth optimization", "campaign performance".
user-invocable: false
---

# Performance Analytics Framework

Marketer skill for measuring, analyzing, and optimizing marketing and growth channel performance.

## Channel Metrics

### App Store (ASO)
| Metric | Definition | Benchmark | Source |
|--------|-----------|-----------|--------|
| Impressions | Times app appeared in search/browse | Varies | App Store Connect |
| Product Page Views | Times product page was viewed | Varies | App Store Connect |
| Conversion Rate | Views -> Downloads | 25-35% (avg) | App Store Connect |
| Download Velocity | Downloads per day/week | Category-dependent | App Store Connect |
| Keyword Rankings | Position for target keywords | Top 10 = strong | ASO tools |
| Rating & Review Volume | Average rating + review count | 4.5+ / 100+ | App Store |

### Organic Social
| Metric | Definition | Target |
|--------|-----------|--------|
| Impressions | Total content views | Growth trend |
| Engagement Rate | (Likes + Replies + Shares) / Impressions | X: >2%, Reddit: high upvote ratio |
| Click-Through Rate | Link clicks / Impressions | >1% |
| Follower Growth | Net new followers per week | Steady growth |
| Content Virality | Shares / Impressions | >0.5% |

### Content Marketing
| Metric | Definition | Target |
|--------|-----------|--------|
| Blog/Post Views | Unique visitors to content | Growth trend |
| Time on Page | Average reading time | >2 min |
| Referral Traffic | Visitors from content to App Store | Conversion tracking |
| SEO Rankings | Position for target keywords | Top 10 |

### Community (Reddit / HN / Forums)
| Metric | Definition | Target |
|--------|-----------|--------|
| Post Engagement | Upvotes, comments per post | Above subreddit average |
| Sentiment | Positive vs negative mentions | >70% positive |
| Referral Traffic | Clicks to app/site from posts | Track with UTM |
| Community Growth | Followers, subscribers | Steady growth |

## Reporting Templates

### Weekly Performance Report
```markdown
## Weekly Marketing Report: [Week of Date]

### Downloads & Conversion
| Metric | This Week | Last Week | WoW Change |
|--------|-----------|-----------|-----------|
| Downloads | | | % |
| Product Page Views | | | % |
| Conversion Rate | | | pp |
| Organic vs Paid Split | | | |

### Channel Performance
| Channel | Impressions | Clicks | Downloads | Conv Rate |
|---------|------------|--------|-----------|----------|
| App Store Search | | | | % |
| App Store Browse | | | | % |
| X (Twitter) | | | | % |
| Reddit | | | | % |
| Direct / Referral | | | | % |

### Content Performance
| Content | Platform | Impressions | Engagement | Link Clicks |
|---------|----------|------------|-----------|-------------|
| [Post/Thread] | | | | |

### Key Takeaways
- [What worked]
- [What didn't]
- [Next week focus]
```

### Monthly Performance Report
```markdown
## Monthly Marketing Report: [Month]

### Summary
- Total Downloads: [Count] ([MoM change]%)
- Best Channel: [Channel] ([why])
- Conversion Rate: [%] ([MoM change])

### App Store Performance
- Impressions: [Count]
- Conversion Rate: [%]
- Keyword ranking changes: [Key movements]
- Rating: [Score] ([Change])

### Growth Funnel
Download -> Install -> Open -> Activate -> Subscribe
  [N]  ->  [N]  ->  [N]  ->  [N]   ->   [N]
       [%]      [%]      [%]       [%]

### Channel ROI (if applicable)
| Channel | Spend | Downloads | CPA | LTV | ROI |
|---------|-------|-----------|-----|-----|-----|
| [Channel] | $0 (organic) | | $0 | $ | - |

### Learnings & Next Month Plan
- [Key insight]
- [Strategic shift]
- [Experiment to run]
```

## Attribution

### Models Overview
| Model | How It Works | Best For |
|-------|-------------|----------|
| Last Touch | Credit to last interaction before install | Simple tracking |
| First Touch | Credit to first known interaction | Understanding discovery |
| Multi-Touch | Distribute credit across touchpoints | Complex journeys |

### Indie App Attribution (Practical)
For solo developers without enterprise attribution tools:
1. **UTM Parameters**: Tag all links (social posts, blog, email) with UTM codes
2. **App Store Connect**: Source type breakdown (Search, Browse, Referral, Web)
3. **Custom Onboarding Question**: "How did you hear about us?" (keep it optional, 3-4 choices)
4. **Amplitude Source Tracking**: Track `source` property on `app_opened` event

### Attribution Template
```markdown
## Attribution Analysis: [Period]

### Source Breakdown
| Source | % of Downloads | Trend | Quality (D7 Retention) |
|--------|---------------|-------|----------------------|
| App Store Search | ??% | | ??% |
| App Store Browse | ??% | | ??% |
| Social Referral | ??% | | ??% |
| Direct / Other | ??% | | ??% |

### High-Quality Sources
- Best retention: [Source] (D7: ??%)
- Best conversion: [Source] (Trial->Paid: ??%)
- Best LTV: [Source]

### Recommended Allocation
- Double down on: [Channel] because [reason]
- Experiment with: [Channel] because [opportunity]
- Reduce effort on: [Channel] because [low ROI]
```

## Optimization Framework

### 5-Step Loop
```
1. IDENTIFY: Which metric is underperforming vs benchmark?
   -> "Conversion rate is 18% vs 30% category average"

2. DIAGNOSE: Why is it underperforming?
   -> Analyze by segment, time, source
   -> Check screenshots, description, ratings

3. HYPOTHESIZE: What change could improve it?
   -> "Updating first screenshot to show core value will increase conversion"

4. TEST: Implement and measure
   -> Run for 7-14 days minimum
   -> Ensure sufficient sample size

5. SCALE or ITERATE: Did it work?
   -> Yes: Document and maintain
   -> No: New hypothesis, back to step 3
```

### Common Optimization Areas for iOS Apps
| Area | Lever | Expected Impact |
|------|-------|----------------|
| ASO - Screenshots | First 3 screenshots tell the story | Conversion +5-15% |
| ASO - Title/Subtitle | Include primary keyword | Search visibility +20-40% |
| ASO - Description | First 3 lines above fold | Conversion +3-5% |
| ASO - Ratings | Prompt happy users for review | Conversion +10-20% |
| Social - Hook | First line grabs attention | Engagement +50-100% |
| Social - Timing | Post when audience is active | Reach +20-50% |
| Content - SEO | Target long-tail keywords | Organic traffic growth |

## App Store Review Analysis

```markdown
## Review Analysis: [Period]

### Rating Distribution
| Stars | Count | % | Trend |
|-------|-------|---|-------|
| 5 | | | |
| 4 | | | |
| 3 | | | |
| 2 | | | |
| 1 | | | |

### Top Themes (from reviews)
| Theme | Frequency | Sentiment | Actionable? |
|-------|-----------|-----------|------------|
| [Theme 1] | | Positive/Negative | Yes/No |

### Competitive Review Comparison
| Aspect | Our App | Competitor A | Competitor B |
|--------|---------|-------------|-------------|
| Avg Rating | | | |
| Review Volume | | | |
| Top Complaint | | | |
```

## Deliverable

Save performance analysis to `docs/decisions/YYYY-MM-DD-performance-{topic}.md`.
