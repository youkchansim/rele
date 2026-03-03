# StoreKit Updates

> Requires `@available(iOS 26, *)` for new features.

```swift
@available(iOS 26, *)
// Multiple entitlements check
let entitlements = await Transaction.currentEntitlements(for: groupID)

// Subscription offer view
SubscriptionOfferView(offer: specialOffer)

// Plan diversification via visibleRelationship
SubscriptionStoreView().visibleRelationship(.upgrade)
```
