# Market Sizing: TAM, SAM, SOM

Market sizing quantifies the revenue opportunity at three levels of scope. It answers "How big is this opportunity?" and grounds product strategy in realistic numbers.

## Three Levels of Market Size

### TAM — Total Addressable Market

The entire market demand for your product category if you had 100% market share with no constraints.

**What it represents:** The theoretical maximum. Useful for communicating the scale of the opportunity to investors and for strategic context.

**Example:** All global spending on mobile productivity apps.

### SAM — Serviceable Addressable Market

The segment of TAM that your product can realistically reach given your business model, geography, platform, and language.

**What it represents:** The market you could theoretically serve. Narrowed by practical constraints.

**Example:** iOS-only, English-language productivity app users in the US who pay for subscriptions.

### SOM — Serviceable Obtainable Market

The portion of SAM you can realistically capture in the short term (1-3 years) given your current resources, brand awareness, and competitive position.

**What it represents:** Your realistic revenue target. This is what matters for planning.

**Example:** Realistic first-year subscriber count based on current growth rate and conversion.

---

## Two Approaches

### Top-Down Approach

Start from industry-level data and narrow down through a series of filters.

**Process:**
1. Find total market size from industry reports
2. Apply geographic filter (e.g., US only = X% of global)
3. Apply platform filter (e.g., iOS = Y% of mobile)
4. Apply segment filter (e.g., subscription-willing users = Z%)
5. Apply price point (average revenue per user)

**Formula:**
```
TAM = Total market users x Average revenue per user
SAM = TAM x Geographic filter x Platform filter x Segment filter
SOM = SAM x Realistic market share %
```

**Strengths:** Fast, good for big-picture context, leverages existing research.

**Weaknesses:** Relies on available reports (may be outdated), successive filtering compounds estimation errors.

### Bottom-Up Approach

Start from your own unit economics and scale outward based on realistic growth.

**Process:**
1. Define your pricing (e.g., $4.99/month or $39.99/year)
2. Estimate realistic user acquisition (organic + paid channels)
3. Apply conversion rate (free to paid)
4. Apply retention rate (annual churn)
5. Project over time horizon

**Formula:**
```
Monthly revenue = Active subscribers x Monthly price
Annual revenue = (New subscribers - Churned subscribers) x Annual price
SOM = Year 1-3 projected annual revenue
SAM = SOM / Estimated achievable market share %
TAM = SAM expanded to all constraints removed
```

**Strengths:** Grounded in real economics, directly actionable, easier to validate.

**Weaknesses:** May underestimate opportunity, limited by current assumptions about channels and conversion.

---

## Data Sources for Market Sizing

| Source | What It Provides | Cost |
|--------|-----------------|------|
| Statista | Industry market size reports, forecasts | Paid (some free) |
| Sensor Tower / data.ai | App Store revenue estimates, download data, category trends | Paid |
| App Store Connect | Your own download, revenue, and conversion data | Free (your app) |
| Crunchbase | Competitor funding rounds (implies market validation) | Free tier available |
| SimilarWeb | Website traffic estimates for competitors with web presence | Freemium |
| Census.gov / BLS | Population demographics, employment data for TAM framing | Free |
| Industry reports (Gartner, Forrester) | Category size and growth forecasts | Paid (expensive) |
| Reddit / HN / Product Hunt | Qualitative demand signals, user willingness to pay | Free |
| RevenueCat public benchmarks | Subscription app benchmarks (conversion, retention, ARPU) | Free |
| Competitor App Store pages | Pricing, ratings, review volume as proxy for user base | Free |

---

## Validation

Always calculate market size using **both** Top-Down and Bottom-Up approaches, then compare.

**Healthy sign:** Both approaches are within 2-5x of each other.

**Red flag:** If they differ by more than 10x, one approach has a flawed assumption. Investigate.

**Sense-checks:**
- Compare your SOM to known competitor revenue (are you claiming more than the market leader?)
- Compare TAM growth rate to general industry growth rates
- Validate conversion assumptions against RevenueCat benchmarks (median trial-to-paid ~15-20% for subscription apps)
- Check if your user acquisition assumptions align with realistic CAC for your channels

---

## Market Sizing Template

```markdown
## Market Sizing: [Product Name]
Date: YYYY-MM-DD

### TAM (Total Addressable Market)
- Market definition: [What market are we sizing?]
- Total market size: $[X]B (Source: [report/data])
- Total potential users: [N] million
- Calculation: [Show work]

### SAM (Serviceable Addressable Market)
- Geographic scope: [Countries/regions]
- Platform: [iOS / Android / Both]
- Language: [Languages supported]
- Target segment: [Description of target users]
- SAM size: $[X]M
- SAM users: [N] thousand
- Calculation: TAM x [filters applied]

### SOM (Serviceable Obtainable Market)
- Time horizon: [1 year / 3 years]
- Estimated market share: [X]%
- SOM revenue: $[X]K - $[X]K
- SOM users: [N] subscribers
- Calculation: [Show work with conversion + retention]

### Top-Down Calculation
[Step-by-step from industry reports down to SOM]

### Bottom-Up Calculation
[Step-by-step from unit economics up to SOM]

### Validation
- Top-Down SOM: $[X]
- Bottom-Up SOM: $[X]
- Difference: [X]x — [Acceptable / Needs investigation]
- Sense-checks:
  - [ ] SOM < largest competitor's estimated revenue
  - [ ] Conversion rate within industry benchmarks
  - [ ] Growth assumptions realistic for team size
```

---

## Worked Example: Subscription-Based iOS Productivity App

### Context
A task management app with a freemium model: free tier with basic features, premium at $4.99/month ($39.99/year). iOS only, English-language, targeting the US market initially.

### Top-Down Approach

**TAM:**
- Global productivity software market: $96B (2024, Statista)
- Mobile productivity subset: ~12% = $11.5B
- Consumer (non-enterprise) segment: ~30% = $3.5B

**SAM:**
- US market: ~40% of consumer mobile productivity = $1.4B
- iOS share of US mobile: ~57% = $798M
- Subscription-willing segment: ~25% of iOS productivity users = $200M

**SOM (Year 1):**
- Realistic market share for new entrant: 0.01-0.05%
- SOM = $200M x 0.02% = $40K ARR

### Bottom-Up Approach

**Unit Economics:**
- Price: $39.99/year (assume most subscribers choose annual)
- Monthly organic downloads (realistic for new app): 500-1,500
- Average for estimation: 800/month
- Year 1 total downloads: 9,600
- Free-to-trial conversion: 20%
- Trial-to-paid conversion: 15%
- Year 1 subscribers: 9,600 x 0.20 x 0.15 = 288 subscribers
- Annual churn: 40% (first-year apps are higher)
- End of Year 1 active subscribers: ~200
- Year 1 ARR: 200 x $39.99 = **$8K**

**Year 3 projection (with growth):**
- Downloads grow 3x with ASO optimization and content marketing
- Conversion improves to 25% trial, 18% paid with iteration
- Year 3 annual downloads: 30,000
- Year 3 new subscribers: 30,000 x 0.25 x 0.18 = 1,350
- Plus retained from prior years: ~600
- Year 3 active subscribers: ~1,950
- Year 3 ARR: 1,950 x $39.99 = **$78K**

### Validation

| Metric | Top-Down | Bottom-Up |
|--------|----------|-----------|
| Year 1 ARR | $40K | $8K |
| Difference | 5x | |

The 5x difference is within acceptable range. Top-down tends to overestimate (not all users are reachable), and bottom-up tends to underestimate (conservative assumptions). A realistic Year 1 target is **$10-30K ARR**.

**Sense-checks:**
- Things 3 (premium iOS task app) estimated at $10-20M ARR — our SOM is well below this (pass)
- 15% trial-to-paid is within RevenueCat median benchmarks (pass)
- 800 organic downloads/month is conservative for a well-positioned App Store listing (pass)
- Solo developer breakeven at ~$60K ARR is achievable by Year 2-3 on the growth trajectory (reasonable)
