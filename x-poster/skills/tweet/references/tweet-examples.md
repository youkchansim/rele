# 카테고리별 트윗 예시

실제 커밋 데이터 기반으로 생성된 트윗 예시. SKILL.md에서 참조용으로 사용.

---

## Build in Public — 주간 로그

```
Week 12 building Scheduler in public:

✅ Voice input for quick event creation
✅ Fixed recurring event deletion bug
✅ Localization quality improvements
🔧 AI provider abstraction layer

7 commits. 0 crashes. 1 very stubborn bug.

What's your biggest win this week?
```

## 제품 쇼케이스 — 새 기능

```
Just shipped: voice input for Scheduler ✨

Tap the mic → speak your event → done.

"Meeting with Sarah tomorrow at 3pm" → parsed, scheduled, notified.

No typing. No tapping through forms. Just talk.

What feature saves you the most time in your scheduling app?
```

## ADHD/생산성 인사이트

```
ADHD scheduling truth:

Your best deep work hours aren't 9-5.
They're scattered. Unpredictable. Personal.

That's why I built Scheduler to track your energy patterns and suggest when to do what.

Your body already knows your ideal schedule.
You just need the data to see it.

When do you do your best work?
```

## 기술 결정 공유

```
Why I moved from a single AI provider to a pluggable architecture:

1. Users want choice (OpenAI vs Claude vs on-device)
2. API costs vary wildly
3. On-device = privacy + speed

Result: 40% fewer API calls, happier users.

How do you handle AI provider switching in your apps?
```

## 버그 수정 — 고난 스토리

```
Spent 2 hours debugging a recurring event deletion bug.

The issue: deleting "every Tuesday meeting" was killing ALL occurrences instead of just the selected one.

The fix: find the exact occurrence by date before deleting.

Literally 3 lines of code. 2 hours of confusion.

What's your "3 lines, 2 hours" story?
```

## UI/UX — 비포/애프터

```
Small design change, huge impact:

Changed the default calendar view from monthly → weekly.

Why: Most people plan day-by-day, not month-by-month. Weekly view shows today's schedule immediately.

Sometimes the best feature is removing a tap.

Monthly or weekly — which do you default to?
```

## Apple Intelligence 인사이트

```
On-device AI tip for iOS devs:

Don't send everything to the cloud.

Our AI scheduling suggestions run entirely on-device using Apple Intelligence. Result:
→ Zero latency
→ Zero API cost
→ Full privacy

The trade-off? Smaller model = simpler prompts.

Are you building with on-device AI yet?
```

---

## 스레드 예시 (4개 트윗)

```
🧵 I'm building a scheduling app for ADHD brains. Here's why:

1/4
```

```
Most scheduling apps assume you work like a neurotypical person.

Fixed hours. Consistent energy. Linear task flow.

ADHD doesn't work that way. And that's not a bug — it's just different wiring.

2/4
```

```
Scheduler tracks your energy patterns using HealthKit data.

Sleep quality → morning energy prediction
Activity levels → focus window suggestions
Heart rate → stress-adjusted scheduling

Your body is already telling you when to work. Most apps just don't listen.

3/4
```

```
Now in beta. Built by a solo dev with ADHD, for people with ADHD.

Would love your feedback — what's the ONE thing a scheduling app must get right for you?

4/4
```
