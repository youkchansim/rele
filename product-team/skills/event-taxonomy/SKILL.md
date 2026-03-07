---
name: event-taxonomy
description: >
  This skill should be used when designing analytics event taxonomy, naming
  events, applying the 3-Question filter, or auditing existing event structure.
  Useful for "design event taxonomy", "name this event", "audit existing events",
  "3-Question filter", "event naming conventions", "should we track this".
user-invocable: false
---

# Event Taxonomy Design

Data Analyst exclusive skill. Design and maintain the app's analytics event system.

## Core Principles

1. **North Star Connection**: Every event must connect to a core metric
2. **10-15 Core Events**: Airbnb principle — the events that run the business are few
3. **Object_Action Pattern**: `plan_created`, not `create_plan`
4. **Past Tense**: `created`, `completed`, `failed`
5. **50+ = Unmanageable**: Quality over quantity

## 3-Question Filter (Mandatory)

Apply to every new event proposal:

```
Q1. Does a similar event already exist?
    -> YES: Propose adding parameters to existing event
    -> NO: Proceed to Q2

Q2. Connected to North Star metric or funnel?
    -> YES: Proceed to Q3
    -> NO: SKIP — prevent over-instrumentation

Q3. Pure UI interaction with no business meaning?
    -> YES: SKIP
    -> NO: Recommend the event
```

## Taxonomy Structure

```markdown
## Event Taxonomy: [App Name]

### North Star: [Core Metric]

### Event Categories

#### Acquisition
| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| `app_opened` | First app launch | source, campaign | Install -> Active |
| `onboarding_completed` | Onboarding done | step_count, skip | Activation Rate |

#### Activation
| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| `{core_action}_completed` | First core feature use | type | Aha Moment |

#### Retention
| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| `session_started` | Session start | day_since_install | DAU/MAU |

#### Revenue
| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| `paywall_shown` | Paywall displayed | trigger, placement | Trial Start Rate |
| `purchase_completed` | Purchase done | product_id, price | Revenue |

#### Referral
| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| `content_shared` | Content shared | type, destination | K-factor |
```

## Naming Rules

| Rule | Correct | Incorrect |
|------|---------|-----------|
| Object_Action | `plan_created` | `create_plan` |
| Past tense | `button_tapped` | `button_tap` |
| snake_case | `screen_viewed` | `screenViewed` |
| Max 3 words | `plan_created` | `review_plan_item_created` |
| Specific | `schedule_created` | `item_added` |

## Property Rules

- **Segment-enabling**: `plan_type`, `source`, `is_premium`
- **No PII**: No email, name, or user ID
- **Enum-safe strings**: `"free"` / `"premium"` (not DB raw values)
- **Include measurement unit**: `duration_seconds`, `count`

## Existing Event Scan

When analyzing, first check the project's existing event system:
```
Glob: **/Logger.swift, **/EventType*, **/Analytics*
Grep: "case " in EventType files
```

## Deliverable

Save taxonomy document to `docs/decisions/YYYY-MM-DD-event-taxonomy.md`.
