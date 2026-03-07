# Lean Canvas

The Lean Canvas is Ash Maurya's adaptation of the Business Model Canvas, optimized for startups and new products. It captures the entire business model on a single page, forcing clarity and brevity.

## The 9 Boxes

```
+------------------+------------------+------------------+------------------+------------------+
|                  |                  |                  |                  |                  |
|  2. PROBLEM      |  4. SOLUTION     |  3. UNIQUE VALUE |  9. UNFAIR       |  1. CUSTOMER     |
|  Top 3 problems  |  Top 3 features  |  PROPOSITION     |  ADVANTAGE       |  SEGMENTS        |
|                  |                  |  Single, clear   |  Can't be easily |  Target users    |
|                  |                  |  message          |  copied          |                  |
|                  +------------------+                  +------------------+                  |
|                  |                  |                  |                  |                  |
|                  |  8. KEY METRICS  |                  |  5. CHANNELS     |                  |
|                  |  Key numbers     |                  |  Path to users   |                  |
|                  |  that matter     |                  |                  |                  |
+------------------+------------------+------------------+------------------+------------------+
|                                     |                                     |
|  7. COST STRUCTURE                  |  6. REVENUE STREAMS                 |
|  Fixed and variable costs           |  Revenue model                      |
|                                     |                                     |
+-------------------------------------+-------------------------------------+
```

## Recommended Fill Order

Don't fill left-to-right. Follow this order for the best thinking flow:

| Order | Box | Why This Order |
|-------|-----|---------------|
| 1st | **Customer Segments** | Start with who — everything else depends on this |
| 2nd | **Problem** | What are their top 3 problems? (validate that these are real) |
| 3rd | **Unique Value Proposition** | Why will they choose you? (forces early differentiation) |
| 4th | **Solution** | Only now think about features (avoids solution-first thinking) |
| 5th | **Channels** | How will you reach these customers? |
| 6th | **Revenue Streams** | How will you make money? |
| 7th | **Cost Structure** | What does it cost to operate? |
| 8th | **Key Metrics** | How will you know it's working? |
| 9th | **Unfair Advantage** | What's your moat? (hardest to fill — it's okay to leave blank initially) |

## Box-by-Box Guide

### 1. Customer Segments

Who are your early adopters? Be specific — not "everyone."

**Write:**
- Primary segment with demographics/firmographics
- Early adopter characteristics (what makes them eager to try)
- Distinction between users and customers (if different)

**Example:**
> - Remote engineering teams (5-20 people) at Series A-B startups
> - Early adopters: teams currently using 4+ productivity tools, frustrated with tool sprawl
> - Users: individual engineers. Customer: engineering manager (budget holder)

### 2. Problem

List the top 3 problems for your customer segment. These should come from user research.

**Write:**
- Top 3 problems, ranked by severity
- Existing alternatives (how users solve these today)

**Example:**
> 1. Context lost when switching between planning, execution, and communication tools (5+ daily)
> 2. No single view of team progress — managers piece together status from multiple sources
> 3. Meeting action items get lost because notes are disconnected from task systems
>
> **Existing alternatives:** Notion + Linear + Slack, Asana + Google Docs, spreadsheet trackers

### 3. Unique Value Proposition

One clear, compelling sentence. Not a feature list — a promise.

**Format:** [End result user wants] + [specific time period] + [addressing objections]

**Example:**
> "One workspace for your entire team's plan-execute-reflect cycle. Stop copy-pasting between 5 tools."

**Tips:**
- Be specific and measurable where possible
- Target the early adopter, not the mass market
- It should be immediately understandable

### 4. Solution

Top 3 features that address the top 3 problems. One-to-one mapping.

**Example:**

| Problem | Solution |
|---------|----------|
| Context switching between tools | Unified workspace: docs, tasks, and chat in one place |
| No single progress view | Auto-generated team dashboard from task data |
| Meeting action items lost | AI meeting summary → auto-created tasks |

**Caution:** Keep solutions minimal. This is your V1, not the final product.

### 5. Channels

How will you reach your first customers?

**Channel types:**
- **Free channels:** Content marketing, SEO, community, open source, product-led growth
- **Paid channels:** Google Ads, social ads, sponsorships
- **Relationship channels:** Sales, partnerships, integrations marketplace

**Example:**
> - Primary: Product-led growth (free tier → team viral spread)
> - Secondary: Content marketing (blog on remote team productivity)
> - Launch: Product Hunt, Hacker News, relevant Slack communities

### 6. Revenue Streams

How you make money. Be specific about pricing model.

**Example:**
> - Freemium: Free for up to 5 users (basic features)
> - Team plan: $12/user/month (integrations, AI features, unlimited history)
> - Target: $15K ARR per team account

### 7. Cost Structure

Major cost categories. Focus on what matters at current stage.

**Example:**
> - Infrastructure: $2K/month (AI processing, real-time sync)
> - Team: 4 engineers + 1 designer + 1 PM
> - Tools: $500/month
> - Monthly burn: ~$85K

### 8. Key Metrics

The numbers that tell you if your business model works. Use pirate metrics (AARRR) as a starting point.

| Metric Type | Example |
|------------|---------|
| **Acquisition** | Weekly signups |
| **Activation** | % of teams that create 10+ tasks in first week |
| **Retention** | Weekly Active Teams (D7, D30) |
| **Revenue** | MRR, trial-to-paid conversion |
| **Referral** | % of teams that came from invite |

### 9. Unfair Advantage

Something that cannot be easily copied or bought. This is the hardest box.

**Real unfair advantages:**
- Proprietary data that improves with usage
- Network effects
- Community/brand loyalty
- Unique team expertise or domain knowledge
- Existing distribution (audience, partnerships)

**NOT unfair advantages:**
- Features (can be copied)
- First mover (temporary)
- Passion (everyone has it)
- Low price (race to bottom)

**Example:**
> - AI models trained on team workflow data (improves with scale — data moat)
> - Founding team has built and scaled 2 previous PLG products (execution advantage)

---

## Startup Canvas Variation

For very early-stage validation (pre-product), use a simplified version focused on the problem space:

```
+---------------------------+---------------------------+
|  PROBLEM                  |  SOLUTION HYPOTHESIS      |
|  What's the #1 problem?   |  What's your best guess?  |
|  Who has it?              |  (Will change!)           |
+---------------------------+---------------------------+
|  EARLY ADOPTER            |  VALIDATION PLAN          |
|  Who has it worst?        |  How will you test this?  |
|  Where do they hang out?  |  What's the cheapest      |
|                           |  experiment?              |
+---------------------------+---------------------------+
|  KEY RISK                 |  FIRST MILESTONE          |
|  Biggest assumption to    |  What proves you should   |
|  test                     |  keep going?              |
+---------------------------+---------------------------+
```

This is a stepping stone to the full Lean Canvas — use it when you're still validating whether the problem is real.

---

## Worked Example: FocusFlow Team Productivity App

```
CUSTOMER SEGMENTS:
Remote engineering teams (5-20) at Series A-B startups
Early adopters: Teams using 4+ tools, frustrated with tool sprawl

PROBLEM:
1. Context lost switching between 5+ daily tools
2. No single view of team progress
3. Meeting action items lost between notes and tasks
Existing alternatives: Notion+Linear+Slack, Asana+Docs

UNIQUE VALUE PROPOSITION:
"One workspace for your team's plan-execute-reflect cycle.
Stop copy-pasting between 5 tools."

SOLUTION:
1. Unified workspace (docs + tasks + chat)
2. Auto-generated team dashboard
3. AI meeting summary → auto-tasks

CHANNELS:
- PLG: free tier → team viral growth
- Content: blog on remote productivity
- Launch: Product Hunt, HN

REVENUE STREAMS:
- Free: up to 5 users
- Team: $12/user/month
- Target: $15K ARR/team

COST STRUCTURE:
- Infra: $2K/mo, Team: 6 people
- Monthly burn: ~$85K

KEY METRICS:
- Acquisition: Weekly signups
- Activation: Teams with 10+ tasks in week 1
- Retention: Weekly Active Teams
- Revenue: MRR, trial-to-paid %

UNFAIR ADVANTAGE:
- AI trained on team workflow data (data moat)
- Founding team: 2 prior PLG exits
```

---

## Tips for Using Lean Canvas Effectively

1. **Keep it one page.** If you can't fit it, you don't understand it well enough yet.
2. **Iterate frequently.** Update weekly in early stages. The canvas is a living document.
3. **Use as communication tool.** Share with the team, investors, advisors. Forces alignment.
4. **Start with the riskiest box.** Identify which box has the weakest evidence and test that first.
5. **Create multiple canvases.** If you're exploring different segments or business models, create one canvas per variation and compare.
6. **Don't confuse this with a business plan.** The canvas captures hypotheses to test, not proven facts.
