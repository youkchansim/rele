# Naming Conventions

Standard naming rules for analytics events and properties across all platforms.

---

## Event Name Format

### Rule: `object_action` in `snake_case`

```
✅ plan_created
✅ timer_started
✅ paywall_shown
✅ sync_failed
✅ onboarding_completed

❌ createPlan          (camelCase — forbidden)
❌ create_plan         (verb first — forbidden)
❌ PlanCreated         (PascalCase — forbidden)
❌ plan-created        (kebab-case — forbidden)
❌ planCreation        (noun form — forbidden)
```

### Object = the thing being acted upon
- Concrete nouns: `plan`, `task`, `timer`, `session`, `paywall`, `banner`, `screen`
- Avoid generic objects: `item`, `thing`, `object`, `data`
- Prefer the domain term your team uses daily

### Action = what happened (PAST TENSE)
- Always past tense: `created`, `completed`, `started`, `failed`, `dismissed`
- Never present tense: `create`, `complete`, `start`, `fail`
- Never imperative: `save`, `delete`, `open`

### Length Limit: Max 3 words
```
✅ plan_created                     (2 words)
✅ timer_started                    (2 words)
✅ paywall_shown                    (2 words)
✅ onboarding_step_viewed           (3 words — acceptable)
❌ review_plan_item_created         (4 words — too long)
❌ shared_study_plan_join_confirmed (5 words — way too long)
```

If 3 words aren't enough, use a parameter:
```
❌ shared_study_plan_created
✅ study_plan_created (parameters: { type: "shared" })
```

---

## Property Name Format

### Rule: `snake_case`, lowercase, descriptive

```
✅ subject_count
✅ plan_type
✅ subscription_tier
✅ source
✅ error_code

❌ subjectCount       (camelCase)
❌ SubjectCount       (PascalCase)
❌ cnt                (abbreviation)
❌ sc                 (too short)
```

### Property Value Format

**String values**: lowercase snake_case or enum-safe strings
```swift
// ✅
"subscription_tier": "free"
"subscription_tier": "premium"

// ❌
"subscription_tier": "Free User"
"subscription_tier": "PREMIUM"
```

**Enum values**: use `.rawValue` (Swift) or `.name` (Kotlin)
```swift
// Swift
"plan_type": plan.type.rawValue   // → "spaced_repetition"

// Kotlin
"plan_type" to planType.name      // → "SPACED_REPETITION"
```

**Numeric values**: raw numbers, not strings
```swift
"subject_count": 5       // ✅ Int
"subject_count": "5"     // ❌ String
```

---

## Platform-Specific Enum Naming

### iOS (Swift) — camelCase enum cases
EventType enum cases use Swift's camelCase convention.
The `name` computed property converts to snake_case at runtime.

```swift
enum EventType: String {
    case planCreated          // → "plan_created" (auto-converted)
    case timerStarted         // → "timer_started"
    case paywallShown         // → "paywall_shown"
    case onboardingCompleted  // → "onboarding_completed"
}
```

**RelePlanner pattern**: uses `@SnakeCase` property wrapper on `LogEvent.name`
**Nagger pattern**: uses `var name: String` computed property with manual conversion

### Android (Kotlin) — SCREAMING_SNAKE_CASE enum constants
EventType enum constants use Kotlin/Java convention.

```kotlin
enum class EventType {
    PLAN_CREATED,
    TIMER_STARTED,
    PAYWALL_SHOWN,
    ONBOARDING_COMPLETED
}
```

The `toSnakeCase()` function converts `PLAN_CREATED` → `plan_created` at runtime.

---

## UserProperty Naming

UserProperties follow the same `snake_case` convention:

```
subscription_tier          → "free" | "premium"
onboarding_completed       → "true" | "false"
plan_count                 → numeric string
notification_enabled       → "true" | "false"
app_locale                 → "en" | "ko" | "ja"
```

UserProperty keys must be:
- Lowercase snake_case
- Stable (don't rename — historical data breaks)
- Describing persistent user state, not moment context

---

## Reserved Names (Do Not Use)

These conflict with Firebase/Amplitude auto-tracking or reserved namespaces:

```
❌ screen_view       (Firebase auto-tracks this)
❌ session_start     (Amplitude auto-tracks this)
❌ session_end       (Amplitude auto-tracks this)
❌ app_open          (Firebase auto-tracks this)
❌ first_open        (Firebase auto-tracks this)
❌ user_id           (Firebase reserved)
❌ firebase_*        (Firebase reserved prefix)
❌ ga_*              (Google Analytics reserved prefix)
```

---

## Naming Checklist

Before finalizing any event name:

- [ ] `object_action` format?
- [ ] All lowercase?
- [ ] Underscores (no hyphens/spaces)?
- [ ] Past tense verb?
- [ ] 3 words or fewer?
- [ ] Not a reserved name?
- [ ] Swift: camelCase enum case → auto snake_case at runtime
- [ ] Kotlin: SCREAMING_SNAKE_CASE enum → auto snake_case at runtime
