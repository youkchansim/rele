# Tracking Plan

Living document — single source of truth for all analytics events.
Update this file whenever events are added, modified, or deprecated.

**Last Updated**: <!-- Update date here -->
**North Star Metric**: <!-- Define your app's North Star -->
**Total Events**: <!-- Count -->

---

## UserProperties

| Property Key | Type | Possible Values | When Updated | Owner |
|-------------|------|-----------------|-------------|-------|
| `subscription_tier` | String | `"free"`, `"premium"`, `"trial"` | On purchase/expiry | Backend |
| `onboarding_completed` | String | `"true"`, `"false"` | After onboarding | iOS/Android |
| `plan_count` | String | `"0"`, `"1"`, `"2+"` | On plan create/delete | iOS/Android |
| `notification_enabled` | String | `"true"`, `"false"` | After permission request | iOS/Android |
| `app_locale` | String | `"en"`, `"ko"`, `"ja"` | On first launch | iOS/Android |

---

## Events

### Acquisition

| Event Name | Object | Action | Funnel Stage | Previous Event | Properties | Owner | Added |
|-----------|--------|--------|-------------|----------------|------------|-------|-------|
| `onboarding_started` | onboarding | started | Acquisition | app_installed | `entry_source` | iOS/Android | |
| `onboarding_step_viewed` | onboarding_step | viewed | Acquisition | onboarding_started | `step_number`, `step_name` | iOS/Android | |
| `onboarding_completed` | onboarding | completed | Acquisition | onboarding_step_viewed | `total_steps_viewed`, `time_spent_seconds` | iOS/Android | |

### Activation

| Event Name | Object | Action | Funnel Stage | Previous Event | Properties | Owner | Added |
|-----------|--------|--------|-------------|----------------|------------|-------|-------|
| <!-- first_[core_action] --> | | created | Activation | onboarding_completed | `is_first`, `source` | | |

### Retention

| Event Name | Object | Action | Funnel Stage | Previous Event | Properties | Owner | Added |
|-----------|--------|--------|-------------|----------------|------------|-------|-------|
| <!-- session_started --> | | started | Retention | | `day_of_week`, `time_of_day` | | |

### Revenue

| Event Name | Object | Action | Funnel Stage | Previous Event | Properties | Owner | Added |
|-----------|--------|--------|-------------|----------------|------------|-------|-------|
| `paywall_shown` | paywall | shown | Revenue | (any trigger) | `source`, `trigger` | iOS/Android | |
| `purchase_attempted` | purchase | attempted | Revenue | paywall_shown | `product_id`, `price_usd` | iOS/Android | |
| `purchase_completed` | purchase | completed | Revenue | purchase_attempted | `product_id`, `price_usd`, `is_trial`, `source` | iOS/Android | |
| `purchase_failed` | purchase | failed | Revenue | purchase_attempted | `error_code`, `product_id` | iOS/Android | |
| `paywall_dismissed` | paywall | dismissed | Revenue | paywall_shown | `source`, `time_spent_seconds` | iOS/Android | |

### Errors & Health

| Event Name | Object | Action | Funnel Stage | Previous Event | Properties | Owner | Added |
|-----------|--------|--------|-------------|----------------|------------|-------|-------|
| `sync_failed` | sync | failed | Health | sync_started | `error_code`, `context`, `retry_count` | iOS/Android | |

---

## Deprecated Events

| Event Name | Deprecated Date | Replaced By | Reason |
|-----------|----------------|-------------|--------|
| | | | |

---

## Pending Events (Proposed, Not Yet Implemented)

| Event Name | Proposed By | Reason | Status |
|-----------|------------|--------|--------|
| | | | |

---

## Event Property Definitions

Shared property definitions for consistency across events.

| Property Key | Type | Allowed Values | Description |
|-------------|------|----------------|-------------|
| `source` | String | `"onboarding"`, `"home"`, `"settings"`, `"deep_link"`, `"notification"` | Where the action originated |
| `subscription_tier` | String | `"free"`, `"premium"`, `"trial"` | User's tier at time of event |
| `error_code` | String | Any | Machine-readable error identifier |
| `is_first` | Bool | `true`, `false` | Whether this is user's first time doing action |
| `step_number` | Int | 1+ | Position in multi-step flow |
| `product_id` | String | RevenueCat product IDs | Subscription product identifier |

---

## Governance

- **Adding events**: Apply 3-question judgment filter → PR with tracking plan row update
- **Renaming events**: Create new event + deprecate old one (never rename deployed events)
- **Removing properties**: Never remove — deprecate by setting to `null` or default value
- **Review cadence**: Monthly — remove events with <10 occurrences/day after 30 days
