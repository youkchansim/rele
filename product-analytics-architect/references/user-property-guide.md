# UserProperty vs. Event Property Guide

Understanding the difference between UserProperties and Event Properties is critical to getting useful analytics segments.

---

## Core Distinction

| Dimension | UserProperty | Event Property |
|-----------|-------------|----------------|
| **What it captures** | Persistent user state | Moment-specific context |
| **When to use** | State that describes WHO the user is | Context that describes WHAT happened |
| **Lifetime** | Persists until explicitly changed | Attached to single event |
| **Used for** | Audience segments, cohort analysis | Funnel analysis, debugging |
| **Example** | `subscription_tier: "premium"` | `plan_type: "spaced_repetition"` |

---

## UserProperties: Describing WHO the User Is

UserProperties answer: "What kind of user is this?"

They are set via `Logger.set(userProperties:)` (iOS) or `Logger.setUserProperty()` (Android).

### Standard UserProperties to Maintain

| Property Key | Values | When to Update |
|-------------|--------|----------------|
| `subscription_tier` | `"free"` / `"premium"` / `"trial"` | On purchase, restore, expiry |
| `onboarding_completed` | `"true"` / `"false"` | After onboarding flow completes |
| `plan_count` | `"0"` / `"1"` / `"2+"` | After plan create/delete |
| `notification_enabled` | `"true"` / `"false"` | After permission grant/deny |
| `app_locale` | `"en"` / `"ko"` / `"ja"` | On first launch |
| `days_since_install` | Bucketed: `"0"` / `"1-7"` / `"8-30"` / `"30+"` | On session start |

### iOS Code Pattern

**RelePlanner (static Logger):**
```swift
// On subscription change
Logger.set(userProperties: [
    "subscription_tier": newTier.rawValue
])

// On onboarding complete
Logger.set(userProperties: [
    "onboarding_completed": "true"
])
```

**Nagger (shared instance):**
```swift
// On subscription change
Logger.shared.set(userProperties: [
    "subscription_tier": tier.rawValue
])
```

### Android Code Pattern
```kotlin
// On subscription change
Logger.setUserProperty("subscription_tier", tier.name.lowercase())

// Multiple at once
Logger.setUserProperties(mapOf(
    "subscription_tier" to tier.name.lowercase(),
    "onboarding_completed" to "true"
))
```

---

## Event Properties: Describing WHAT Happened

Event Properties answer: "What was the context when this happened?"

They are passed as the `parameters` dictionary in `Logger.log()`.

### Essential Properties Per Category

#### Creation Events
```swift
// plan_created
"subject_count": Int
"plan_type": String         // "spaced_repetition" | "custom"
"source": String            // "onboarding" | "home" | "ai_planner"
```

#### Completion Events
```swift
// task_completed
"time_spent_minutes": Int
"completion_streak": Int    // how many in a row
"was_delayed": Bool
```

#### Error Events
```swift
// sync_failed
"error_code": String | Int
"retry_count": Int
"context": String           // "upload" | "download" | "initial"
```

#### Purchase Events
```swift
// purchase_completed
"product_id": String        // RevenueCat product ID
"price_usd": Double
"is_trial": Bool
"source": String            // "onboarding_paywall" | "settings" | "feature_gate"
```

#### Screen View Events (when tracked)
```swift
// screen_viewed
"screen_name": String       // consistent identifier
"previous_screen": String   // for flow analysis
```

---

## Decision Flowchart

```
New data to capture?
        │
        ▼
Does it describe WHO the user IS?
(persists across sessions, changes infrequently)
        │
    YES ▼                    NO
UserProperty          Does it describe WHAT happened?
Set via               (specific to this one event)
set(userProperties:)          │
                          YES ▼
                      Event Property
                      Pass in parameters: [...]
```

### Gray Area Examples

| Data | Classification | Reason |
|------|---------------|--------|
| `subscription_tier` | UserProperty | Changes rarely, describes WHO user is |
| `plan_count` | UserProperty | Describes user's profile |
| `subject_count` at time of creation | Event Property | Context for THAT creation moment |
| `is_trial` on purchase | Event Property | Specific to purchase event |
| `notification_enabled` | UserProperty | Persistent permission state |
| `was_notification_enabled_when_creating` | Event Property | Moment context (if needed) |

---

## Common Mistakes

### Mistake 1: Using Event Properties as UserProperties
```swift
// ❌ Wrong — passing user state as event property every time
Logger.log(.init(type: .planCreated, parameters: [
    "subscription_tier": currentTier.rawValue  // This belongs in UserProperty
]))

// ✅ Right — set UserProperty when tier changes, not on every event
Logger.set(userProperties: ["subscription_tier": tier.rawValue])
```

### Mistake 2: Re-setting UserProperties on Every Event
```swift
// ❌ Wrong — setting UserProperty on each event call
func logPlanCreated() {
    Logger.set(userProperties: ["subscription_tier": tier.rawValue])  // Redundant
    Logger.log(.init(type: .planCreated, ...))
}

// ✅ Right — set UserProperty only when state changes
func onSubscriptionChanged(to newTier: SubscriptionTier) {
    Logger.set(userProperties: ["subscription_tier": newTier.rawValue])
}
```

### Mistake 3: PII in Any Property
```swift
// ❌ Forbidden — PII in event properties
Logger.log(.init(type: .loginSuccess, parameters: [
    "email": user.email,          // PII
    "display_name": user.name     // PII
]))

// ✅ Allowed — non-identifying identifiers
Logger.log(.init(type: .loginSuccess, parameters: [
    "auth_method": "apple",
    "is_new_user": isNewUser
]))
```
