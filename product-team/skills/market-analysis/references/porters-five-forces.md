# Porter's Five Forces

Porter's Five Forces is a framework for analyzing the competitive structure of an industry. It helps product teams understand where competitive pressure comes from and how to position strategically.

## The Five Forces

### 1. Threat of New Entrants

How easy is it for new competitors to enter the market?

**Key Factors:**
- **Capital requirements** — How much investment is needed to build a competitive product?
- **Technical barriers** — Does the product require specialized technology, data, or expertise?
- **Brand loyalty** — Do existing products have strong user loyalty and switching costs?
- **Distribution access** — Can new entrants easily reach users (app stores lower this barrier)?
- **Regulatory barriers** — Are there compliance requirements that slow new entrants?
- **Network effects** — Does the product become more valuable with more users?

**Assessment Scale:**

| Level | Criteria | Implication |
|-------|----------|-------------|
| **Low** | High capital/tech barriers, strong brand loyalty, powerful network effects | Existing players are protected; focus on deepening moats |
| **Medium** | Moderate barriers; new entrants possible but face significant hurdles | Monitor new entrants; invest in differentiation |
| **High** | Low barriers to entry; app stores make distribution easy; minimal tech moat | Expect frequent new competitors; speed and UX are key differentiators |

### 2. Bargaining Power of Suppliers

How much leverage do your suppliers (platforms, API providers, infrastructure) have?

**Key Factors:**
- **Platform dependency** — Reliance on Apple/Google for distribution and APIs
- **API provider concentration** — Critical third-party services (OpenAI, Stripe, Firebase)
- **Switching costs** — How costly is it to move to an alternative supplier?
- **Supplier differentiation** — Are supplier offerings unique or commoditized?

**Assessment Scale:**

| Level | Criteria | Implication |
|-------|----------|-------------|
| **Low** | Multiple interchangeable suppliers; easy switching; commodity infrastructure | Negotiate freely; suppliers compete for your business |
| **Medium** | Some supplier lock-in; switching possible but costly | Maintain alternative options; avoid deep integration with single provider |
| **High** | Single dominant supplier (e.g., Apple App Store); no viable alternatives | Accept terms; diversify revenue streams; advocate for policy changes |

### 3. Bargaining Power of Buyers

How much leverage do your users and customers have?

**Key Factors:**
- **Switching costs** — How easy is it for users to move to a competitor?
- **Price sensitivity** — How sensitive are users to subscription price changes?
- **Availability of alternatives** — How many competing products solve the same problem?
- **Information availability** — Can users easily compare products (App Store reviews, comparison sites)?
- **Volume of individual buyers** — Are there a few large customers or many small ones?

**Assessment Scale:**

| Level | Criteria | Implication |
|-------|----------|-------------|
| **Low** | High switching costs; few alternatives; data lock-in | Can command premium pricing; focus on expansion revenue |
| **Medium** | Some alternatives exist but switching has friction; moderate price sensitivity | Competitive pricing needed; focus on retention and value demonstration |
| **High** | Easy switching; many alternatives; high price sensitivity; active comparison shopping | Must compete on value; invest in onboarding, lock-in, and unique features |

### 4. Threat of Substitutes

Can users solve the same problem with a fundamentally different type of solution?

**Key Factors:**
- **Functional substitutes** — Different products serving the same need (pen and paper vs. task app)
- **Performance trade-offs** — Is the substitute "good enough" despite being different?
- **Price-performance ratio** — Does the substitute offer better value?
- **Switching propensity** — How willing are users to adopt fundamentally different solutions?

**Assessment Scale:**

| Level | Criteria | Implication |
|-------|----------|-------------|
| **Low** | No viable substitutes; digital solution clearly superior to alternatives | Strong market position; focus on growing the category |
| **Medium** | Substitutes exist but offer worse experience; some users tolerate them | Educate market on advantages; make switching from substitutes frictionless |
| **High** | Strong substitutes (built-in OS features, spreadsheets, manual processes) widely used | Must deliver 10x value over substitutes; emphasize unique digital advantages |

### 5. Competitive Rivalry

How intense is competition among existing players?

**Key Factors:**
- **Number of competitors** — How many direct competitors operate in this space?
- **Differentiation level** — Are products meaningfully different or commoditized?
- **Market growth rate** — Is the market growing (everyone wins) or stagnant (zero-sum)?
- **Exit barriers** — Are competitors locked in (sunk costs, commitments)?
- **Strategic stakes** — Is this a "must-win" market for large players?

**Assessment Scale:**

| Level | Criteria | Implication |
|-------|----------|-------------|
| **Low** | Few competitors; highly differentiated products; fast-growing market | Focus on market education and growth; competition is not the bottleneck |
| **Medium** | Several competitors; some differentiation; steady market growth | Find and defend a niche; invest in unique features |
| **High** | Many competitors; low differentiation; slow growth; large players investing heavily | Compete on niche focus, UX quality, or cost; avoid head-to-head with giants |

---

## Assessment Template

```markdown
## Porter's Five Forces: [Market/Product]
Date: YYYY-MM-DD

| Force | Level | Key Drivers | Strategic Response |
|-------|-------|------------|-------------------|
| Threat of New Entrants | H/M/L | | |
| Supplier Power | H/M/L | | |
| Buyer Power | H/M/L | | |
| Threat of Substitutes | H/M/L | | |
| Competitive Rivalry | H/M/L | | |

### Overall Industry Attractiveness
[High / Medium / Low — based on the balance of forces]

### Key Strategic Implications
1. [Implication 1]
2. [Implication 2]
3. [Implication 3]
```

---

## Strategic Implications by Force Level

### When a Force is High (Unfavorable)

| Force | High-Level Strategy |
|-------|-------------------|
| New Entrants | Build moats: data network effects, switching costs, brand loyalty, patent/IP |
| Supplier Power | Diversify suppliers; build abstraction layers; reduce platform dependency |
| Buyer Power | Increase switching costs; create data lock-in; build community/habit loops |
| Substitutes | Deliver 10x value; integrate with substitutes rather than fighting them |
| Rivalry | Niche down; differentiate aggressively; avoid price wars |

### When a Force is Low (Favorable)

| Force | High-Level Strategy |
|-------|-------------------|
| New Entrants | Invest in growth; the moat protects you while you scale |
| Supplier Power | Negotiate better terms; integrate deeper for competitive advantage |
| Buyer Power | Expand revenue per user; introduce premium tiers |
| Substitutes | Grow the category; educate the market on your approach |
| Rivalry | Expand market share aggressively; define the category standard |

---

## Worked Example: Mobile Task Management App (iOS)

### Force 1: Threat of New Entrants — HIGH

**Key Drivers:**
- App Store makes distribution trivially accessible to any developer
- Core task management features are straightforward to build (SwiftUI + CloudKit)
- No significant regulatory barriers
- Low capital requirements (single developer can ship an MVP)

**Mitigating Factors:**
- Building polish and reliability takes time
- Existing apps have App Store ranking momentum and reviews

**Strategic Response:** Compete on design quality and integration depth (widgets, Shortcuts, Watch) that take time to replicate. Build data lock-in through proprietary features.

### Force 2: Bargaining Power of Suppliers — HIGH

**Key Drivers:**
- Apple controls the only iOS distribution channel (App Store)
- 15-30% commission on all in-app purchases
- Apple can reject app updates or change policies at any time
- CloudKit dependency for sync means Apple is infrastructure supplier too

**Strategic Response:** Accept App Store reality but diversify: offer web version to reduce platform risk, use standard sync protocols alongside CloudKit, keep alternative payment options ready (web-based subscription management).

### Force 3: Bargaining Power of Buyers — HIGH

**Key Drivers:**
- Dozens of task management alternatives available in App Store
- Low switching costs (many apps offer import/export)
- Price sensitivity high in productivity category (free tier expected)
- App Store reviews and comparison articles make evaluation easy

**Strategic Response:** Generous free tier to build habit before asking for payment. Focus on unique workflow that creates natural lock-in. Invest heavily in onboarding to demonstrate value quickly.

### Force 4: Threat of Substitutes — MEDIUM

**Key Drivers:**
- Apple Reminders is free, built-in, and increasingly capable
- Notes apps (Apple Notes, Notion) serve as functional substitutes
- Pen-and-paper and whiteboard still common for task management
- Calendar apps overlap with scheduling-oriented task management

**Mitigating Factors:**
- Built-in apps are generic; power users need specialized tools
- Physical methods lack sync, reminders, and collaboration

**Strategic Response:** Target use cases where built-in Reminders falls short (recurring habits, project planning, analytics). Make importing from Reminders frictionless.

### Force 5: Competitive Rivalry — HIGH

**Key Drivers:**
- Crowded market: Todoist, Things 3, TickTick, Any.do, Microsoft To Do, OmniFocus, and dozens more
- Large players (Microsoft, Google) subsidize their task apps within broader ecosystems
- Market growth is moderate (not a new category)
- Low differentiation in core features (lists, due dates, reminders)

**Strategic Response:** Do not compete on feature breadth. Find a specific niche (e.g., solo professionals, habit-driven productivity, minimal design-conscious users) and become the best option for that audience.

### Overall Assessment

| Force | Level |
|-------|-------|
| Threat of New Entrants | High |
| Supplier Power | High |
| Buyer Power | High |
| Threat of Substitutes | Medium |
| Competitive Rivalry | High |

**Overall Industry Attractiveness: Low**

Four of five forces are unfavorable. Success requires picking a defensible niche, building unique value that creates switching costs, and competing on quality and experience rather than features or price.

**Key Strategic Priorities:**
1. Define and own a specific niche segment
2. Build data and workflow lock-in through proprietary features
3. Invest in design and UX as the primary differentiator
4. Maintain lean operations to survive in a low-margin environment
