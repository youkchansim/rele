---
name: product-analytics-architect
description: Designs analytics events using real startup principles and generates architecture-agnostic code. Use when adding new screens, business logic, or user interactions that need event tracking. Evaluates whether an event is worth adding, generates EventType enum cases and Logger.log() calls for both iOS and Android. Also triggers automatically via hooks when new View/Screen/UseCase files are created.
---

# Product Analytics Architect

Design analytics events using startup principles. Generate architecture-agnostic code for Firebase + Amplitude.

**Language Convention**: Respond in the user's input language.

## Core Philosophy

- **North Star first**: Every event must connect to a metric that matters
- **10–15 core events** run a business (Airbnb principle) — resist adding more
- **Object_Action pattern** (Uber): `plan_created`, not `create_plan`
- **Past tense always**: something happened, not something to do
- **50+ events = unmanageable** — quality over quantity
- **UserProperty ≠ Event**: persistent state vs. moment context

---

## Workflow

### Phase 1: Context Gathering

Before designing any event, read:

1. **Existing EventType enum** — load all current events to check for duplicates
2. **File being modified** — understand what new logic was added
3. **North Star metric** — what does this app optimize for?

```
iOS EventType locations:
- RelePlanner: ReviewApp/Service/Logger.swift
- Nagger: Nagger/Core/Analytics/Logger.swift

Android EventType locations:
- RelePlanner: Service/Log.kt
```

### Phase 2: Judgment (Apply Before Every Event)

Load `references/judgment-criteria.md` and apply the 3-question filter:

```
Q1. Does a similar event already exist?
    → YES: Suggest adding a parameter instead
    → NO: Proceed to Q2

Q2. Does this action connect to a North Star metric or funnel?
    → YES: Proceed to Q3
    → NO: Skip — avoid over-instrumentation

Q3. Is this pure UI interaction with no business significance?
    → YES: Skip
    → NO: Recommend the event
```

**Always show reasoning**: "Skipping `X` because Q3 — pure UI, no business impact."

### Phase 3: Event Design

Load `references/naming-conventions.md` and `references/event-design-principles.md`.

**Naming rules (enforced)**:
- Format: `object_action` (snake_case)
- Verb: past tense only — `created`, `completed`, `failed`, `tapped`
- Max 3 words: `plan_created` ✓ `review_plan_item_created` ✗

**Property rules**:
- Include context that enables segmentation: `plan_type`, `subject_count`
- No PII: no emails, names, user IDs in event properties
- Prefer enum-safe strings: `"free"` / `"premium"` not raw DB values

### Phase 4: Code Generation

**Detect platform** from file extension or explicit request:
- `.swift` → iOS
- `.kt` → Android

#### iOS — Two Logger patterns

**Pattern A: RelePlanner (static Logger)**
```swift
// 1. Add to EventType enum (Logger.swift)
case planCreated

// 2. Call site
Logger.log(.init(type: .planCreated, parameters: [
    "subject_count": plan.subjects.count,
    "plan_type": plan.type.rawValue
]))
```

**Pattern B: Nagger (shared instance Logger)**
```swift
// 1. Add to EventType enum (Logger.swift)
case todoCreate

// 2. Call site
Logger.shared.log(LogEvent(.todoCreate, parameters: [
    "source": "main_list"
]))
// Or no-parameter shorthand:
Logger.shared.log(.todoCreate)
```

**iOS UserProperty:**
```swift
// RelePlanner (static)
Logger.set(userProperties: ["subscription_tier": tier.rawValue])

// Nagger (instance)
Logger.shared.set(userProperties: ["subscription_tier": tier])
```

#### Android — Object Logger

```kotlin
// 1. Add to EventType enum (Log.kt)
PLAN_CREATED,

// 2. Call site
Logger.log(EventType.PLAN_CREATED, mapOf(
    "subject_count" to plan.subjects.size,
    "plan_type" to plan.type.name
))

// No-parameter shorthand:
Logger.log(LogEvent(EventType.PLAN_CREATED))
```

**Android UserProperty:**
```kotlin
Logger.setUserProperty("subscription_tier", tier.name)
// or multiple:
Logger.setUserProperties(mapOf(
    "subscription_tier" to tier.name,
    "plan_count" to planCount
))
```

### Phase 5: Tracking Plan Update

When adding a new event, append a row to the tracking plan.
Load `assets/templates/tracking-plan.md` as the template.

Provide the completed row:
```
| plan_created | Plan | Created | Business | onboarding_completed | subject_count, plan_type | Backend Engineer | 2026-01-15 |
```

---

## Hook Trigger Behavior

When this skill is triggered by a hook (new file created or business logic modified), follow this abbreviated flow:

1. **Read the new/modified file** — identify what changed
2. **Load existing EventType enum** — check for duplicates
3. **Apply 3-question judgment** — skip if fails Q2 or Q3
4. **If event warranted**: output in this exact format:

```
📊 Analytics Check

New file/logic detected: [filename]

Suggested event: `object_action`
Reason: [one sentence connecting to North Star]

Skip reason (if skipping): [Q2/Q3 filter explanation]

Code to add:
[EventType enum case]
[Logger.log() call at appropriate location]
```

If no event is needed: output a single line — `📊 Analytics: No new event needed (Q3 — pure UI interaction).`

---

## Event Categories Reference

| Category | Trigger Pattern | Example Events |
|----------|----------------|----------------|
| Screen | New `*View.swift`, `*Screen.kt`, `*Fragment.kt` | `screen_viewed` |
| User Action | Button handler, tap, gesture, navigation | `button_tapped`, `tab_selected` |
| Business Logic | UseCase, Service, Manager new method | `plan_created`, `sync_completed` |
| Completion | `.done`, `onSuccess`, success callback | `task_completed`, `timer_finished` |
| Error | `onError`, `catch`, failure handler | `sync_failed`, `purchase_failed` |
| Purchase | RevenueCat, paywall, subscribe | `paywall_shown`, `purchase_completed` |
| State Change | Subscription tier, onboarding complete | UserProperty update |

---

## Output Format

Always structure responses as:

```
## Analytics Design: [Feature Name]

### Events to Add
[List with reasoning]

### Events to Skip
[List with Q2/Q3 reasoning]

### Code Changes

**[Platform] — EventType enum:**
[code block]

**[Platform] — Call site ([file]:[line]):**
[code block]

### Tracking Plan Entry
[table row]
```
