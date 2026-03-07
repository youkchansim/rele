# SWOT Analysis & PESTLE Analysis

## SWOT Analysis

SWOT is a strategic planning framework that evaluates an organization or product through four lenses: internal strengths and weaknesses, and external opportunities and threats.

### The Four Quadrants

#### Strengths (Internal, Positive)
Capabilities and advantages your product or team possesses.

Guiding questions:
- What do we do better than competitors?
- What unique resources or technology do we have?
- What do users consistently praise?
- What proprietary data or network effects do we leverage?

#### Weaknesses (Internal, Negative)
Limitations and disadvantages relative to competitors.

Guiding questions:
- Where do users drop off or complain most?
- What features are competitors offering that we lack?
- Where are our technical debt bottlenecks?
- What skills or resources are we missing?

#### Opportunities (External, Positive)
External factors or trends that could benefit the product.

Guiding questions:
- What market trends favor our product category?
- Are there underserved segments we could reach?
- What new platform capabilities (APIs, OS features) can we leverage?
- Are competitors leaving gaps we could fill?

#### Threats (External, Negative)
External factors that could harm the product's position.

Guiding questions:
- What are competitors building that could erode our advantage?
- Are there regulatory changes that could affect us?
- Is the market becoming commoditized?
- Could platform changes (App Store policies, API deprecations) disrupt us?

### SWOT Template

```markdown
## SWOT Analysis: [Product/Feature Name]
Date: YYYY-MM-DD

### Strengths
1. [Strength 1] — [Evidence/metric]
2. [Strength 2] — [Evidence/metric]
3. [Strength 3] — [Evidence/metric]

### Weaknesses
1. [Weakness 1] — [Evidence/metric]
2. [Weakness 2] — [Evidence/metric]
3. [Weakness 3] — [Evidence/metric]

### Opportunities
1. [Opportunity 1] — [Source/trend]
2. [Opportunity 2] — [Source/trend]
3. [Opportunity 3] — [Source/trend]

### Threats
1. [Threat 1] — [Source/likelihood]
2. [Threat 2] — [Source/likelihood]
3. [Threat 3] — [Source/likelihood]
```

---

## TOWS Matrix

The TOWS Matrix converts SWOT findings into actionable strategies by cross-referencing internal and external factors.

| | **Opportunities** | **Threats** |
|---|---|---|
| **Strengths** | **SO Strategies** — Use strengths to capture opportunities | **ST Strategies** — Use strengths to counter threats |
| **Weaknesses** | **WO Strategies** — Overcome weaknesses via opportunities | **WT Strategies** — Minimize weaknesses and avoid threats |

### Strategy Types

**SO (Strength-Opportunity): Aggressive**
Leverage what you do well to capture external opportunities. These are your highest-priority strategic moves.
- Example: "Our strong notification system (S) + growing demand for habit tracking (O) = Build habit streak reminders"

**WO (Weakness-Opportunity): Developmental**
Use external opportunities to address internal weaknesses. Often involves investment or partnership.
- Example: "Limited analytics capability (W) + new Amplitude integration (O) = Implement data-driven feature prioritization"

**ST (Strength-Threat): Defensive**
Use internal advantages to protect against external threats. Focus on differentiation.
- Example: "Superior UX design (S) + new competitor entering market (T) = Double down on design quality as moat"

**WT (Weakness-Threat): Survival**
Minimize weaknesses to avoid threats. Often involves cutting scope or pivoting.
- Example: "Small team (W) + platform requiring compliance changes (T) = Focus only on mandatory compliance, defer new features"

### TOWS Template

```markdown
## TOWS Strategic Actions

### SO Strategies (Pursue)
1. [Action] — leveraging [Strength] to capture [Opportunity]

### WO Strategies (Develop)
1. [Action] — using [Opportunity] to overcome [Weakness]

### ST Strategies (Defend)
1. [Action] — using [Strength] to counter [Threat]

### WT Strategies (Avoid/Minimize)
1. [Action] — reducing exposure of [Weakness] to [Threat]
```

---

## PESTLE Analysis

PESTLE scans the macro-environment across six dimensions to identify external forces that may impact your product.

### Political Factors
Government policies, regulations, and political stability that affect your market.

Example considerations for app/tech products:
- App Store review policy changes (Apple/Google tightening rules)
- Government data privacy mandates (GDPR, state-level privacy laws)
- International trade restrictions affecting API providers or cloud services
- Government subsidies or programs that could expand your addressable market

### Economic Factors
Economic conditions that influence user spending and market dynamics.

Example considerations:
- Consumer spending trends on digital subscriptions (recession sensitivity)
- Currency fluctuations affecting international pricing
- Venture capital climate impacting competitor funding and market entry
- Inflation impact on user willingness to pay for premium features

### Social Factors
Cultural trends, demographics, and user behavior shifts.

Example considerations:
- Growing awareness of digital wellness and screen time
- Remote/hybrid work driving demand for productivity tools
- Generational preferences (Gen Z preference for visual-first, short-form content)
- Cultural shifts toward privacy consciousness and data ownership

### Technological Factors
Technology trends that create new possibilities or disrupt existing approaches.

Example considerations:
- AI/ML capabilities enabling new personalization features
- Platform updates (new iOS/Android APIs, widget systems, live activities)
- Cloud infrastructure cost changes affecting unit economics
- Emerging platforms (AR/VR, wearables) creating new distribution channels

### Legal Factors
Laws and legal frameworks that impose requirements or create risk.

Example considerations:
- GDPR/CCPA compliance requirements for user data handling
- App Store commission rules and legal challenges (Epic v. Apple implications)
- Intellectual property considerations for AI-generated content
- Accessibility requirements (ADA compliance for digital products)

### Environmental Factors
Environmental and sustainability trends affecting product decisions.

Example considerations:
- Growing user preference for energy-efficient apps (battery optimization)
- Carbon footprint awareness in cloud infrastructure choices
- Sustainability as brand differentiator for conscious consumers
- E-waste and device lifecycle affecting target device support decisions

### PESTLE Template

```markdown
## PESTLE Analysis: [Product/Market]
Date: YYYY-MM-DD

| Factor | Key Finding | Impact (H/M/L) | Timeframe | Action |
|--------|------------|-----------------|-----------|--------|
| Political | | | | |
| Economic | | | | |
| Social | | | | |
| Technological | | | | |
| Legal | | | | |
| Environmental | | | | |
```

---

## Combined Workflow: PESTLE then SWOT

The recommended approach is to run PESTLE first to scan the macro-environment, then feed those external insights into SWOT for strategic positioning.

### Step-by-Step Process

1. **PESTLE Scan** — Identify the top 2-3 most impactful external factors per dimension
2. **Filter to Relevant** — Discard factors with Low impact or distant timeframe
3. **Feed into SWOT Opportunities/Threats** — High-impact PESTLE findings become the O and T quadrants
4. **Complete SWOT** — Add internal Strengths and Weaknesses based on product knowledge
5. **Generate TOWS** — Cross-reference to produce actionable strategies
6. **Prioritize Actions** — Rank TOWS strategies by impact and feasibility

---

## Worked Example: Mobile Productivity App

### PESTLE Highlights

| Factor | Finding | Impact |
|--------|---------|--------|
| Political | Apple tightening App Tracking Transparency rules | Medium |
| Economic | Subscription fatigue — users reducing app subscriptions in downturn | High |
| Social | Remote work normalization increasing demand for async productivity tools | High |
| Technological | iOS Live Activities and widgets enabling ambient productivity surfaces | High |
| Legal | EU Digital Markets Act may force alternative app store distribution | Medium |
| Environmental | Users increasingly value battery-efficient apps | Low |

### SWOT

| | Positive | Negative |
|---|---|---|
| **Internal** | **Strengths:** Native iOS performance, strong widget experience, offline-first architecture | **Weaknesses:** No Android version, limited analytics, small development team |
| **External** | **Opportunities:** Remote work demand growing, Live Activities for ambient tasks, EU sideloading may reduce App Store commission | **Threats:** Subscription fatigue reducing conversion, large competitors (Notion, Todoist) adding similar features |

### TOWS Strategic Actions

**SO (Pursue):**
- Leverage native iOS performance + remote work demand = Build best-in-class widget and Live Activity experience for async task management

**WO (Develop):**
- Use remote work trend to justify analytics investment = Implement Amplitude to understand remote worker usage patterns

**ST (Defend):**
- Use offline-first architecture against subscription fatigue = Offer generous free tier (offline works without subscription) to build habit before conversion

**WT (Avoid):**
- Small team + competitor pressure = Focus exclusively on iOS niche rather than spreading to Android; differentiate on depth over breadth
