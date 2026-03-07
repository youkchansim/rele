# Value Proposition Canvas

The Value Proposition Canvas (from Strategyzer) is a tool for designing products that match what customers actually need. It combines customer research with solution design in a structured format, integrating Jobs-to-Be-Done (JTBD) thinking.

## Canvas Structure

The canvas has two sides that must fit together:

```
+----------------------------------+    +----------------------------------+
|         VALUE MAP                |    |      CUSTOMER PROFILE            |
|         (Your Product)           |    |      (Your Customer)             |
|                                  |    |                                  |
|  +----------+                    |    |                    +----------+  |
|  | Products |                    |    |                    | Customer |  |
|  | &        |  +-------------+  |    |  +-------------+  | Jobs     |  |
|  | Services |  | Gain        |  | <- |  | Gains       |  | (JTBD)   |  |
|  |          |  | Creators    |  |    |  | (Desired    |  |          |  |
|  +----------+  +-------------+  |    |  |  outcomes)  |  +----------+  |
|                                  |    |  +-------------+               |
|                +-------------+  |    |  +-------------+               |
|                | Pain        |  | <- |  | Pains       |               |
|                | Relievers   |  |    |  | (Obstacles) |               |
|                +-------------+  |    |  +-------------+               |
+----------------------------------+    +----------------------------------+
```

**Goal:** Achieve FIT — your Pain Relievers address their Pains, your Gain Creators enable their Gains, and your Products & Services support their Jobs.

---

## Customer Profile (Right Side)

Start here. Understand the customer before designing the solution.

### Customer Jobs

Jobs are what customers are trying to accomplish in their work and life. Three types:

| Job Type | Description | Example |
|----------|-------------|---------|
| **Functional** | Practical tasks they need to complete | "Coordinate my team's work across time zones" |
| **Social** | How they want to be perceived | "Be seen as an organized, effective team lead" |
| **Emotional** | How they want to feel | "Feel confident that nothing is falling through the cracks" |

**How to discover jobs:**
- User interviews: "What are you trying to accomplish when you [use category]?"
- Observation: Watch what they actually do (not what they say they do)
- JTBD format: "When [situation], I want to [motivation], so I can [expected outcome]."

**Examples using JTBD format:**
- "When I start my work day, I want to see what my team is working on, so I can identify blockers before they become problems."
- "When a meeting ends, I want action items captured automatically, so I can focus on the discussion instead of note-taking."
- "When reporting to leadership, I want accurate team progress data, so I can demonstrate my team's impact without manual tracking."

### Pains

Pains are what annoys, frustrates, or prevents customers from getting their jobs done.

**Pain categories:**
- **Undesired outcomes:** Results they want to avoid ("Spending 2 hours every Monday compiling status updates")
- **Obstacles:** Things that prevent or slow them down ("Can't see teammate progress without asking each person")
- **Risks:** Potential negative consequences ("Missing a deadline because a blocker wasn't surfaced early")

**Rate each pain by severity:** Critical / High / Medium / Low

**Example pains:**

| Pain | Severity | Category |
|------|----------|----------|
| Wastes 30+ min/day switching between planning and communication tools | Critical | Obstacle |
| Meeting decisions aren't connected to task follow-up | High | Undesired outcome |
| Doesn't know if team is on track until the weekly check-in | High | Risk |
| Feels overwhelmed by notification noise across 5 tools | Medium | Undesired outcome |

### Gains

Gains are outcomes and benefits customers want. Go beyond the obvious.

**Gain categories:**
- **Required gains:** Baseline expectations (solution must have these to be considered)
- **Expected gains:** Not strictly required, but customers expect them
- **Desired gains:** Things customers would love but don't expect
- **Unexpected gains:** Beyond what customers imagine — delighters

**Example gains:**

| Gain | Category |
|------|----------|
| All team work visible in one place | Required |
| Real-time progress tracking | Expected |
| AI that auto-surfaces blockers and risks | Desired |
| Insights showing team productivity patterns over time | Unexpected |

---

## Value Map (Left Side)

Design your product's value to directly address the customer profile.

### Products & Services

List the products, services, and features your value proposition is built around.

**Example:**
- Unified workspace (docs + tasks + chat)
- AI meeting summarization and task creation
- Auto-generated team dashboard
- Slack and GitHub integrations
- Weekly team insights report

### Pain Relievers

How your products and services alleviate specific customer pains. Map each pain reliever to a specific pain.

| Customer Pain | Pain Reliever |
|--------------|---------------|
| 30+ min/day switching between tools | Single workspace eliminates tool switching |
| Meeting decisions disconnected from tasks | AI auto-creates tasks from meeting summaries |
| Doesn't know team status until weekly check-in | Real-time dashboard shows progress continuously |
| Notification noise across 5 tools | Unified notification center with smart prioritization |

### Gain Creators

How your products and services create customer gains. Map each gain creator to a specific gain.

| Customer Gain | Gain Creator |
|--------------|-------------|
| All team work visible in one place | Unified workspace combines docs, tasks, and communication |
| Real-time progress tracking | Auto-generated dashboard from task data |
| AI surfaces blockers and risks | Smart alerts based on task dependencies and deadlines |
| Team productivity patterns | Weekly insights report with trends and recommendations |

---

## JTBD Integration

Jobs-to-Be-Done provides the language for writing precise job statements that drive the entire canvas.

### Job Statement Format

> "When [situation/context], I want to [motivation/action], so I can [expected outcome/benefit]."

### Writing Good Job Statements

**Rules:**
1. **Situation is specific** — not "in general" but "when [specific trigger]"
2. **Motivation is about progress** — what they're trying to achieve, not a feature
3. **Outcome is the real goal** — the why behind the motivation

| Bad Job Statement | Good Job Statement |
|-------------------|-------------------|
| "I want a project management tool" | "When I start my week, I want to see my team's priorities and blockers, so I can make sure we hit our sprint goals" |
| "I want better notifications" | "When a teammate is blocked, I want to know immediately, so I can unblock them before it delays the project" |
| "I need to track time" | "When reporting to leadership, I want accurate data on what my team spent time on, so I can justify our resource allocation" |

### Job Map

For complex jobs, break them down into stages:

```
Define → Locate → Prepare → Confirm → Execute → Monitor → Modify → Conclude
```

**Example: "Coordinate team work for the week"**

| Stage | Sub-Job |
|-------|---------|
| Define | Determine this week's priorities from backlog |
| Locate | Find who's available and who's overloaded |
| Prepare | Assign tasks based on priorities and capacity |
| Confirm | Ensure team understands assignments and deadlines |
| Execute | Team does the work |
| Monitor | Track progress, identify blockers |
| Modify | Reassign or reprioritize based on new information |
| Conclude | Review what was accomplished, update stakeholders |

Each stage is an opportunity for your product to create value.

---

## 6-Part Value Proposition Statement

Synthesize your canvas into a single powerful statement:

### Template

> For **[target customer]**,
> who **[statement of need or opportunity]**,
> our **[product name]** is a **[product category]**
> that **[key benefit / reason to buy]**.
> Unlike **[primary competitive alternative]**,
> we **[primary differentiation]**.

### Example

> For **remote engineering team leads managing 5-20 person teams**,
> who **waste 30+ minutes daily switching between disconnected planning, execution, and communication tools**,
> our **FocusFlow** is a **unified team workspace**
> that **eliminates tool sprawl by combining docs, tasks, and chat with AI-powered automation**.
> Unlike **Notion + Linear + Slack used together**,
> we **auto-connect meeting decisions to task follow-ups and generate real-time team dashboards without manual tracking**.

### Writing Tips

1. **Be specific about the target.** "Remote engineering team leads at startups" is better than "teams."
2. **State the need in their words.** Use language from actual user interviews.
3. **Name the category.** Helps customers understand what you are.
4. **One key benefit.** Not three — pick the single most compelling reason.
5. **Name the real alternative.** Usually the combination of tools they use today, not a single competitor.
6. **Differentiate on capabilities, not features.** "Auto-connect decisions to follow-ups" vs. "has AI integration."

---

## Fit Assessment

### Problem-Solution Fit

You've identified a real problem and have evidence that your solution concept addresses it.

**Indicators:**
- User interviews confirm the pain points (5+ users describe similar problems)
- Users express willingness to try a solution (behavioral signals, not just "sounds cool")
- Existing workarounds confirm the problem is real and worth solving
- Your solution concept addresses the top 1-2 pains

### Product-Market Fit

Users are actively using, paying for, and recommending your product.

**Indicators:**
- Organic growth (users referring others without prompting)
- Retention curves flatten (users keep coming back)
- Users resist when you try to take the product away (Sean Ellis test: 40%+ say "very disappointed")
- Revenue growing while churn is declining
- Pull from market (inbound demand exceeds what you can fulfill)

### Fit Progression

```
Problem-Solution Fit → Product-Market Fit → Scale
     (Discovery)          (Validation)       (Growth)
```

- **Discovery phase:** Validate Customer Profile — are the jobs, pains, and gains real?
- **Validation phase:** Validate FIT — does your Value Map address the Customer Profile?
- **Growth phase:** Scale what works — optimize channels, pricing, and operations

---

## Worked Example: FocusFlow

### Customer Profile

**Jobs:**
- Functional: Coordinate 5-20 person team's weekly work across time zones
- Social: Be seen as an organized, effective leader
- Emotional: Feel confident nothing falls through the cracks

**Pains:**
- 30+ min/day switching between tools (Critical)
- Meeting decisions don't connect to task follow-up (High)
- No real-time view of team progress (High)
- Notification overload from 5 tools (Medium)

**Gains:**
- Single view of all team work (Required)
- Real-time progress visibility (Expected)
- Automated blocker detection (Desired)
- Productivity pattern insights (Unexpected)

### Value Map

**Products & Services:** Unified workspace, AI meeting summarizer, auto-dashboard, integrations

**Pain Relievers:**
- Single workspace eliminates tool switching → addresses 30 min/day waste
- AI creates tasks from meetings → connects decisions to follow-up
- Real-time dashboard → continuous progress visibility
- Unified notifications → reduces noise

**Gain Creators:**
- All-in-one workspace → single view of work
- Live task tracking → real-time progress
- Smart alerts → automated blocker detection
- Weekly insights → productivity patterns

**FIT Assessment:** Pain Relievers map directly to top 3 pains. Gain Creators map to all gain categories. Strong theoretical fit — needs validation through user testing.
