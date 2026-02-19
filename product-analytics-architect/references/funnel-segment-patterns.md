# Funnel & Segment Patterns

Practical patterns for designing analytics around funnels, cohorts, and A/B testing.

---

## The Universal App Funnel

Every consumer app has this funnel. Map your events to each stage.

```
ACQUISITION
    ↓ [app_installed — auto-tracked by Firebase]
    ↓ onboarding_started
    ↓ onboarding_step_viewed (step: 1, 2, 3...)
    ↓ onboarding_completed

ACTIVATION (Aha Moment)
    ↓ [first_[core_object]_created]
    ↓ [first_[core_action]_completed]

RETENTION (Habit Loop)
    ↓ [daily: core_action_completed]
    ↓ [weekly: session_started, session_completed]
    ↓ [milestone: streak_achieved, goal_met]

REVENUE
    ↓ paywall_shown (source, trigger)
    ↓ purchase_attempted
    ↓ purchase_completed | purchase_failed | purchase_cancelled

RE-ENGAGEMENT
    ↓ notification_received (type)
    ↓ notification_tapped (type)
    ↓ [return visit after N days]
```

---

## Funnel Stage Assignment

### Acquisition Events
Track volume and source of new users entering the product.

```swift
// onboarding_started — fires on first app open when onboarding is shown
Logger.log(.init(type: .onboardingStarted, parameters: [
    "entry_source": "organic" | "push_notification" | "deep_link"
]))

// onboarding_step_viewed — fires each time a step appears
Logger.log(.init(type: .onboardingStepViewed, parameters: [
    "step_number": 1,
    "step_name": "welcome" | "permissions" | "plan_setup"
]))

// onboarding_completed — fires when user exits onboarding
Logger.log(.init(type: .onboardingCompleted, parameters: [
    "total_steps_viewed": 4,
    "time_spent_seconds": 45
]))
```

### Activation Events
The "aha moment" — when users first experience core value.

```swift
// First core action — fires once per user lifetime
// (Guard with: "was this their FIRST time?")
Logger.log(.init(type: .planCreated, parameters: [
    "is_first": true,            // true only on first creation
    "source": "onboarding",
    "subject_count": 3
]))
```

### Retention Events
Habits that bring users back.

```swift
// Session pattern: started → [core actions] → completed
Logger.log(.init(type: .studySessionStarted, parameters: [
    "day_of_week": "monday",
    "time_of_day": "morning" | "afternoon" | "evening" | "night"
]))

// Milestone: rewarding streaks
Logger.log(.init(type: .streakAchieved, parameters: [
    "streak_days": 7
]))
```

### Revenue Events
Full purchase funnel — track every step.

```swift
// 1. Paywall appears
Logger.log(.init(type: .paywallShown, parameters: [
    "source": "onboarding" | "feature_gate" | "settings" | "nudge",
    "trigger": "plan_limit_reached" | "timer_feature" | "manual"
]))

// 2. User taps purchase (before system dialog)
Logger.log(.init(type: .purchaseAttempted, parameters: [
    "product_id": "premium_monthly",
    "price_usd": 4.99
]))

// 3a. Purchase succeeds
Logger.log(.init(type: .purchaseCompleted, parameters: [
    "product_id": "premium_monthly",
    "price_usd": 4.99,
    "is_trial": false,
    "source": "onboarding"
]))

// 3b. Purchase fails
Logger.log(.init(type: .purchaseFailed, parameters: [
    "error_code": "payment_declined",
    "product_id": "premium_monthly"
]))

// 3c. User cancels (dismisses paywall without buying)
Logger.log(.init(type: .paywallDismissed, parameters: [
    "source": "onboarding",
    "time_spent_seconds": 12
]))
```

---

## Segment Analysis Patterns

Segments allow filtering event data by user characteristics.

### Key Segments (via UserProperties)

```
Subscription Tier:    subscription_tier = "free" vs "premium"
Onboarding Status:    onboarding_completed = "true" vs "false"
User Maturity:        days_since_install buckets
Plan Count:           plan_count = "0" vs "1" vs "2+"
Notification:         notification_enabled = "true" vs "false"
```

### Segment Query Examples (in Amplitude/Firebase)

**Conversion by onboarding completion:**
```
Event: purchase_completed
Segment: onboarding_completed = "true" vs "false"
Insight: Completed-onboarding users convert 3x more → optimize onboarding
```

**Feature adoption by tier:**
```
Event: ai_planner_started
Segment: subscription_tier = "free" vs "premium"
Insight: 80% of AI planner starts are free users → good upsell signal
```

**Retention by first week activity:**
```
Event: app_opened (day 7+)
Segment: study_sessions_completed in first week > 3 vs ≤ 3
Insight: Users with 3+ sessions in week 1 retain at 2x rate → activation metric
```

---

## A/B Testing Event Design

When running A/B tests, add experiment context to relevant events.

```swift
// Add experiment parameters to key funnel events
Logger.log(.init(type: .paywallShown, parameters: [
    "source": "onboarding",
    "experiment_id": "paywall_v2",
    "variant": "control" | "treatment_a" | "treatment_b"
]))

// Also set as UserProperty for persistent segmentation
Logger.set(userProperties: [
    "active_experiment": "paywall_v2_treatment_a"
])
```

**Rules for A/B test events:**
1. Add experiment context to the conversion event (not every event)
2. Use UserProperty to track which variant the user is in
3. Remove experiment parameters after test concludes

---

## Cohort Analysis Patterns

Cohorts group users by first-occurrence of a key event.

### First-Use Cohorts
```swift
// Tag creation source on first event only
Logger.log(.init(type: .planCreated, parameters: [
    "is_first": userHasNoPreviousPlans,    // enables "first plan created" cohort
    "source": "onboarding" | "home" | "ai"
]))
```

### Milestone Cohorts
```swift
// Tag meaningful milestones
Logger.log(.init(type: .taskCompleted, parameters: [
    "lifetime_task_count": totalCompletedTasks,  // enables milestone cohorts
    "is_milestone": totalCompletedTasks == 10 || totalCompletedTasks == 100
]))
```

---

## Drop-off Analysis

To find where users drop in a flow, you need events at each transition.

### Minimum Coverage Rule
For any multi-step flow, instrument:
1. **Entry point** — user starts the flow
2. **Each decision point** — user makes a choice
3. **Completion** — user finishes
4. **Abandonment** — user exits without completing (dismissal event)

### Example: Study Plan Creation Flow
```
plan_creation_started    (entry)
    ↓
plan_title_entered       (decision: has title)
    ↓
plan_subjects_added      (decision: added at least 1 subject)
    ↓
plan_schedule_configured (decision: set schedule)
    ↓
plan_created             (completion)
 OR
plan_creation_abandoned  (abandonment — back button without saving)
```

Funnel: `started` → `title_entered` → `subjects_added` → `created`
Drop-off: `started` - `created` = abandonment rate
