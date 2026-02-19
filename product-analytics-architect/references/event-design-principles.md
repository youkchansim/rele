# Event Design Principles

Research-backed principles from engineering blogs at Airbnb, Uber, Duolingo, Notion, and Avo/Iteratively.

---

## The North Star Framework (Airbnb Principle)

**Core insight**: 8 core events can run an entire business. Design top-down from what matters.

### Step 1: Define the North Star Metric
Before adding any event, answer:
- What single metric best captures whether users are getting value?
- Examples:
  - Study planner: `study_sessions_completed_per_week`
  - Todo app: `tasks_completed_per_user`
  - Social app: `daily_active_collaborators`

### Step 2: Identify the Input Metrics
North Star breaks into 3–5 leading indicators:
```
North Star: study_sessions_completed_per_week
├── Acquisition: users_who_created_first_plan
├── Activation: users_who_completed_onboarding
├── Retention: users_returning_day_7
├── Revenue: subscribers_who_unlocked_premium
└── Engagement: avg_daily_study_minutes
```

### Step 3: Map Events to the Funnel
Every event must belong to one layer:
- **Acquisition**: First actions (onboarding, signup)
- **Activation**: "Aha moment" actions (first plan created, first task completed)
- **Retention**: Habit-forming actions (daily study, weekly review)
- **Revenue**: Purchase funnel (paywall_shown → purchase_completed)
- **Engagement**: Depth of use (features discovered, content consumed)

**Rule**: If an event doesn't fit any layer, skip it.

---

## The Schema-First Approach (Uber Principle)

**Core insight**: Generate code from shared schemas. Standardize interaction verbs.

### Standard Verb Library
Always prefer these verbs over inventing new ones:

| Verb | When to Use | Example |
|------|------------|---------|
| `viewed` | Screen/content appeared | `screen_viewed`, `plan_viewed` |
| `tapped` | User pressed button/link | `button_tapped`, `cta_tapped` |
| `created` | New entity saved | `plan_created`, `task_created` |
| `completed` | User finished a flow | `onboarding_completed`, `task_completed` |
| `started` | User initiated a flow | `timer_started`, `session_started` |
| `failed` | Action errored out | `sync_failed`, `purchase_failed` |
| `dismissed` | Modal/sheet closed | `paywall_dismissed`, `nudge_dismissed` |
| `shown` | UI element appeared | `paywall_shown`, `banner_shown` |
| `changed` | Setting or state updated | `theme_changed`, `filter_changed` |
| `deleted` | Entity removed | `plan_deleted`, `account_deleted` |

### Impression vs. Tap Pattern
For any interactive UI element, two events are the minimum:
- `{object}_shown` — element appeared
- `{object}_tapped` — element was tapped

Example: `paywall_shown` + `paywall_tapped` = conversion rate calculable.

---

## Funnel Analysis for Growth (Duolingo Principle)

**Core insight**: Funnel analysis + A/B testing drives 1%/week improvements.

### Critical Funnel Events
Every app needs these funnel checkpoints:

```
ACQUISITION
onboarding_started
onboarding_step_viewed (step_number, step_name)
onboarding_completed

ACTIVATION
first_[core_action]_created    # first plan, first task, first entry
[core_action]_created          # repeated creation

RETENTION
app_opened (days_since_last_open)
[core_action]_completed        # daily engagement

REVENUE
paywall_shown (source, trigger)
purchase_attempted
purchase_completed (product_id, price)
purchase_failed (error_code)
subscription_cancelled
```

### Drop-off Detection
Between each funnel step, the gap reveals where users drop off.
Add events dense enough to see the drop, sparse enough to keep the schema clean.

---

## Product-First Tracking (Notion Principle)

**Core insight**: Track meaningful activities, not raw interactions.

### The Meaning Test
Before adding an event, ask: "If this event doubled, would it be good news?"
- `task_completed` doubled → users are productive → GOOD ✓
- `error_shown` doubled → something is broken → BAD (good to track)
- `settings_opened` doubled → unclear → SKIP ✗

### Avoid Vanity Metrics
Skip events that look active but don't signal value:
- Raw page views without context
- Button taps that don't lead to outcomes
- Error events without actionable parameters

---

## Living Document Principle (Avo/Iteratively)

**Core insight**: Tracking plan is the single source of truth.

### Event Lifecycle
```
Proposed → Approved → Implemented → Validated → Active → Deprecated
```

### Schema Governance Rules
1. **New events need approval** before implementation
2. **Rename = new event** — never change a deployed event name
3. **Add parameters forward** — never remove parameters from live events
4. **Deprecate, don't delete** — mark old events but keep historical data flowing

---

## The 50-Event Rule

> "When you have more than 50 events, your analytics becomes a graveyard."

### Prevention Strategies
1. **Merge similar events** using a `source` parameter:
   - ❌ `task_created_from_home` + `task_created_from_search` + `task_created_from_share`
   - ✅ `task_created` with parameter `source: "home" | "search" | "share"`

2. **Replace taps with outcomes**:
   - ❌ `save_button_tapped`
   - ✅ `task_saved`

3. **One event, many properties** vs. many events, no properties:
   - ❌ `free_user_plan_created` + `premium_user_plan_created`
   - ✅ `plan_created` with `subscription_tier: "free" | "premium"`
