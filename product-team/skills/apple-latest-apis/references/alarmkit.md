# AlarmKit (Alarms & Timers)

> Requires `@available(iOS 26, *)`.

```swift
@available(iOS 26, *)
import AlarmKit

// Alarm manager
let manager = AlarmManager()

// One-time alarm
let alarm = Alarm(date: targetDate, presentation: .alert(title: "Reminder"))
try await manager.schedule(alarm)

// Countdown timer
let timer = CountdownTimer(duration: .minutes(5))
try await manager.schedule(timer)

// Live Activities integration (Dynamic Island, Lock Screen)
```
