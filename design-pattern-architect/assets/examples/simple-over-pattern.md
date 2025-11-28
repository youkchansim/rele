# Example: Choosing Simple Approach Over Pattern

**Scenario**: User Authentication System
**Date**: 2024-01-15
**Decision**: No pattern needed, simple approach chosen

---

## 1. Initial Requirement

Build a user authentication system that supports email/password login.

**Requirements**:
- User login with email and password
- Token generation on successful login
- Token validation for protected routes

---

## 2. Initial Impulse (Pattern-First Thinking)

### Temptation: Strategy Pattern

"Since we might add OAuth, social login, etc., let's use Strategy pattern for different authentication methods!"

```swift
// Over-engineered approach
protocol AuthenticationStrategy {
    func authenticate(credentials: Credentials) -> AuthResult
}

class EmailPasswordStrategy: AuthenticationStrategy {
    func authenticate(credentials: Credentials) -> AuthResult {
        // Implementation
    }
}

class OAuthStrategy: AuthenticationStrategy {
    func authenticate(credentials: Credentials) -> AuthResult {
        // Not implemented yet, but "future-proof"!
    }
}

class AuthenticationContext {
    var strategy: AuthenticationStrategy

    func login(credentials: Credentials) -> AuthResult {
        return strategy.authenticate(credentials: credentials)
    }
}
```

### Why This Is Over-Engineering

**YAGNI Violation**:
- No OAuth requirement exists
- No social login requested
- No other authentication methods planned
- Future is uncertain

**Complexity Cost**:
- 3 extra protocols/classes for single feature
- Team must understand Strategy pattern
- More code to maintain and test

**Over-Engineering Checklist**:
- [x] Would system work without this? **YES** - simple function works fine
- [x] Makes code harder to understand? **YES** - unnecessary abstraction
- [x] Solving non-existent problems? **YES** - OAuth not needed
- [x] Team struggles to maintain? **MAYBE** - adds cognitive load
- [x] Implementation time not worth benefit? **YES** - 4x more code

**Score: 4-5 "Yes" = High risk of over-engineering ❌**

---

## 3. Simple Approach (What We Actually Built)

```swift
struct LoginService {
    private let userRepository: UserRepository
    private let tokenGenerator: TokenGenerator

    func login(email: String, password: String) async throws -> AuthToken {
        // Validate input
        guard isValidEmail(email) else {
            throw AuthError.invalidEmail
        }

        // Get user
        guard let user = try await userRepository.findByEmail(email) else {
            throw AuthError.invalidCredentials
        }

        // Verify password
        guard try verifyPassword(password, hash: user.passwordHash) else {
            throw AuthError.invalidCredentials
        }

        // Generate token
        return tokenGenerator.generate(for: user)
    }

    private func isValidEmail(_ email: String) -> Bool {
        // Email validation logic
    }

    private func verifyPassword(_ password: String, hash: String) throws -> Bool {
        // Password verification logic
    }
}
```

### Why This Is Better

**Simplicity**:
- One struct, three methods
- Easy to understand at a glance
- No extra abstractions

**YAGNI Compliant**:
- Solves today's problem
- No hypothetical features
- Can add patterns later if needed

**Easy to Test**:
```swift
func testLogin_Success() async throws {
    let mockRepo = MockUserRepository()
    let mockTokenGen = MockTokenGenerator()
    let service = LoginService(
        userRepository: mockRepo,
        tokenGenerator: mockTokenGen
    )

    let token = try await service.login(
        email: "user@example.com",
        password: "password123"
    )

    XCTAssertNotNil(token)
}
```

---

## 4. Evolution Path (When to Add Patterns)

### Trigger Conditions for Strategy Pattern

**Add Strategy pattern when**:
1. Second authentication method is **actually required** (not speculated)
2. Requirements are **approved and funded**
3. Implementation is **scheduled in current sprint**

**Example Future Requirement**:
```
"We need to add OAuth login for Google and GitHub by Q2."
```

**Then refactor**:
```swift
// NOW it makes sense
protocol AuthenticationStrategy {
    func authenticate(credentials: Credentials) async throws -> AuthToken
}

class EmailPasswordStrategy: AuthenticationStrategy {
    // Move existing logic here
}

class OAuthStrategy: AuthenticationStrategy {
    // Implement OAuth logic
}
```

### Refactoring Cost

**Current simple approach → Strategy pattern**:
- Estimated time: 2-4 hours
- Risk: Low (existing tests ensure correctness)
- Cost: Acceptable when feature is actually needed

**If we had Strategy from day 1**:
- Wasted time: 4-6 hours upfront
- Maintenance burden: 6 months with unused code
- Cognitive load: Every developer must understand pattern for simple feature

---

## 5. Lessons Learned

### Don'ts
❌ Don't implement patterns "just in case"
❌ Don't add abstractions for hypothetical features
❌ Don't confuse "best practice" with "always necessary"
❌ Don't optimize for imaginary future

### Do's
✅ Solve today's problem simply
✅ Add patterns when second use case appears
✅ Keep refactoring cost low
✅ Trust your ability to refactor later
✅ Measure complexity against actual benefit

### Key Insight

> **"The best code is code that doesn't exist yet."**
>
> Wait for real requirements before adding complexity.
> YAGNI isn't laziness—it's discipline.

---

## 6. Metrics

### Simple Approach Metrics (Actual)

| Metric | Value |
|--------|-------|
| Development time | 3 hours |
| Lines of code | ~80 |
| Cyclomatic complexity | 4 |
| Test coverage | 95% |
| Team ramp-up time | 5 minutes |
| Bugs in 6 months | 1 (edge case) |

### Strategy Pattern Metrics (Estimated if used)

| Metric | Value |
|--------|-------|
| Development time | 8-10 hours |
| Lines of code | ~250 |
| Cyclomatic complexity | 8 |
| Test coverage | 85% (more code to test) |
| Team ramp-up time | 30 minutes |
| Maintenance cost | Higher (unused abstractions) |

### ROI Analysis

**Benefit of Pattern**: Easier to add OAuth... **when needed** (not now)
**Cost of Pattern**: 2x development time, 3x code, higher complexity

**Decision**: Wait for actual requirement

---

## 7. Quote from Code Review

> "I appreciate that you didn't over-engineer this. We've burned too many hours on 'future-proof' abstractions that never got used. This is clean, simple, and does exactly what we need. We can always refactor when OAuth becomes a real requirement."
>
> — Tech Lead

---

## 8. Follow-up (6 Months Later)

### What Actually Happened

After 6 months:
- **OAuth requirement**: Never materialized
- **Authentication changes**: Added password reset (simple addition)
- **Team sentiment**: Grateful we kept it simple

**Verdict**: Correct decision. Simple approach saved time and reduced maintenance burden.

---

## Key Takeaway

**Patterns are tools, not goals.**

Start simple. Add complexity only when:
1. Problem actually exists
2. Simple approach becomes painful
3. Benefits clearly outweigh costs

Trust your ability to refactor later. The best time to add a pattern is when you need it, not before.
