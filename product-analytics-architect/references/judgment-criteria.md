# Judgment Criteria: When to Add or Skip an Event

A systematic 3-question filter to prevent over-instrumentation while capturing everything that matters.

---

## The 3-Question Filter

Apply questions in order. Stop and skip at the first "skip" answer.

---

### Question 1: Duplicate Check

> **Does a similar event already exist in the EventType enum?**

**Process:**
1. Read the existing EventType enum file
2. Look for events with the same object, same action, or very close semantics
3. Check if an existing event could cover the new case with an additional parameter

**If YES** (similar event exists):
- Suggest adding a parameter instead of a new event
- Example: `task_created` already exists → add `source: "quick_add"` parameter instead of `quick_task_created`
- Output: `"Merge with existing \`task_created\` event — add \`source\` parameter"`

**If NO** (no similar event):
- Proceed to Question 2

---

### Question 2: North Star Connection

> **Does this action connect to a North Star metric or product funnel?**

**Funnel stages to check:**
```
ACQUISITION  → Does this happen near signup / first use?
ACTIVATION   → Does this represent the "aha moment"?
RETENTION    → Does this represent a habit-forming action?
REVENUE      → Is this part of the purchase/subscription funnel?
ENGAGEMENT   → Does this measure depth of feature use?
ERROR/HEALTH → Does this signal something broken that needs fixing?
```

**If YES** (connects to funnel):
- Proceed to Question 3

**If NO** (cannot be assigned to any funnel stage):
- **Skip** — avoid over-instrumentation
- Output: `"Skipping — cannot connect to North Star funnel"`
- Common NO cases:
  - Scrolling through a list with no outcome
  - Tooltip/hint shown
  - Sort order changed in UI only
  - Keyboard appeared/dismissed

---

### Question 3: Business Significance Test

> **Is this a pure UI interaction with no business significance?**

**Definition of "pure UI interaction":**
- The action doesn't change state
- The action doesn't represent a decision
- If doubled, it wouldn't be informative (positive or negative)
- No product decision would change based on seeing this event

**If YES** (pure UI, no business significance):
- **Skip**
- Output: `"Skipping — pure UI interaction, no business signal"`

**If NO** (has business significance):
- **Recommend adding the event**
- Move to event design + code generation

---

## Decision Reference Table

| Action | Q1 | Q2 | Q3 | Decision |
|--------|----|----|----|----|
| User creates first study plan | No dup | Activation | Business sig | ✅ Add `plan_created` |
| User taps "X" to close a sheet | No dup | No funnel | — | ❌ Skip (Q2) |
| User scrolls past 3rd item | No dup | No funnel | — | ❌ Skip (Q2) |
| User opens settings screen | No dup | Engagement | Maybe | ⚠️ Add only if feature needs measurement |
| Error in sync | No dup | Error/Health | Business sig | ✅ Add `sync_failed` |
| User taps "subscribe" on paywall | No dup | Revenue | Business sig | ✅ Add `purchase_attempted` |
| User views paywall | No dup | Revenue | Business sig | ✅ Add `paywall_shown` |
| User changes notification ringtone | Dup: settings_changed | — | — | ❌ Add `sound` param to existing event |
| User taps "+" to open add flow | No dup | Activation | Borderline | ⚠️ Merge with `task_created` if creation always follows |
| App launches | No dup | Acquisition | Business sig | ✅ Add (use `app_opened` UserProperty if recurring) |

---

## Special Cases

### Error Events — Always Add
Errors are always business-significant. Any `catch`, `onError`, `onFailure` block for a user-facing operation should be tracked.

Required properties for error events:
```swift
"error_code": error.code         // numeric or string code
"error_message": error.message   // human-readable (no PII)
"context": "sync_upload"         // where the error occurred
```

### Purchase Funnel — Track Every Step
The purchase funnel is always worth full instrumentation:
```
paywall_shown (trigger: "onboarding" | "feature_gate" | "settings")
    ↓
purchase_attempted (product_id, price)
    ↓
purchase_completed (product_id, price, is_trial)
  OR
purchase_failed (error_code)
  OR
purchase_cancelled
```

### Screen Views — Use Judgment
Not every screen view needs an event. Track screen views when:
- It's a key funnel step (onboarding screen, paywall, key feature entry)
- You need to measure conversion (X% who saw screen Y performed action Z)
- You want to detect drop-off in a flow

Skip screen views for:
- Settings sub-screens with no actions
- Informational screens (about, legal)
- Screens the user passes through instantly

### UserProperty Changes — Track the Transition
When subscription tier, permission state, or onboarding status changes, update UserProperties:
```swift
Logger.set(userProperties: ["subscription_tier": newTier.rawValue])
```
Do NOT fire an event just for a setting change unless the change itself is a funnel signal.

---

## Anti-Patterns to Avoid

| Anti-Pattern | Example | Fix |
|-------------|---------|-----|
| Event per button | `home_plus_tapped`, `list_plus_tapped` | `task_creation_started` with `source` param |
| Mirrored events | `task_started` when `task_created` is the same thing | Pick one |
| State dump | Fire 10 events on app launch to capture all state | Use UserProperties |
| Double counting | `plan_created` AND `plan_saved` for same action | Pick the terminal event |
| PII in properties | `user_email`, `user_name` in parameters | Forbidden — remove |
