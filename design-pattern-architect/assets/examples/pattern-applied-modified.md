# Example: Pattern Applied and Modified

**Scenario**: Payment Processing System
**Pattern**: Strategy Pattern (Modified)
**Date**: 2024-02-20
**Decision**: Pattern justified with practical modifications

---

## 1. Problem Statement

### 1.1 Context
E-commerce platform needs to support multiple payment methods with different processing flows.

### 1.2 Design Problems
1. **Multiple Payment Methods**: Credit card, PayPal, Apple Pay, cryptocurrency (4 methods, more planned)
2. **Different Processing Flows**: Each method has unique validation, processing, and error handling
3. **Frequent Changes**: Payment providers update APIs frequently
4. **Testing Complexity**: Need to test each payment method independently

### 1.3 Requirements
**Functional**:
- Support 4 payment methods initially
- Add Stripe and Google Pay in Q2 (confirmed)
- Each method has different validation rules
- Unified response format for client

**Non-Functional**:
- Process payment within 3 seconds
- Maintain 99.9% uptime
- Easy to add new payment methods
- Isolate payment method failures

---

## 2. Why Pattern Is Justified

### 2.1 Real Problem Evidence

**Current Situation** (Before Pattern):
```swift
func processPayment(method: String, amount: Double, details: [String: Any]) throws -> PaymentResult {
    switch method {
    case "credit_card":
        // 50 lines of credit card logic
    case "paypal":
        // 40 lines of PayPal logic
    case "apple_pay":
        // 45 lines of Apple Pay logic
    case "crypto":
        // 60 lines of crypto logic
    default:
        throw PaymentError.unsupportedMethod
    }
}
// Total: 195 lines in one function!
```

**Problems**:
- God function (195 lines)
- Violates SRP (handles 4+ payment methods)
- Violates OCP (must modify function for new methods)
- Hard to test (must mock all payment providers in each test)
- High cognitive complexity

### 2.2 Pattern Necessity Checklist

- [ ] Would system work without pattern? **NO** - current code is unmaintainable
- [ ] Makes code harder to understand? **NO** - makes it clearer
- [ ] Solving non-existent problems? **NO** - 4 methods exist, 2 more coming
- [ ] Team struggles to maintain? **NO** - team knows Strategy pattern
- [ ] Implementation time not worth benefit? **NO** - saves time long-term

**Score: 0 "Yes" = Low risk of over-engineering ✅**

### 2.3 Pattern Evaluation

| Criterion | Score (1-5) | Justification |
|-----------|-------------|---------------|
| Problem-Fit | 5 | Perfect fit: multiple algorithms, runtime selection |
| Simplicity | 4 | Well-known pattern, straightforward implementation |
| Team Familiarity | 5 | Team has used Strategy before |
| Future-Proof | 5 | Easy to add 2 more methods in Q2 |
| **Total** | **19/20** | Excellent fit ✅ |

---

## 3. Standard Strategy Pattern

### 3.1 Classic Implementation

```swift
// Standard Strategy pattern
protocol PaymentStrategy {
    func processPayment(amount: Double) throws -> PaymentResult
}

class CreditCardStrategy: PaymentStrategy {
    func processPayment(amount: Double) throws -> PaymentResult {
        // Implementation
    }
}

class Context {
    var strategy: PaymentStrategy

    func execute(amount: Double) throws -> PaymentResult {
        return try strategy.processPayment(amount: amount)
    }
}
```

---

## 4. Our Modified Version

### 4.1 Why Modifications Are Needed

**Standard pattern limitations for our use case**:
1. **Async Operations**: Payment APIs are async, standard pattern is sync
2. **Validation**: Each method needs validation before processing
3. **Retry Logic**: Some methods need retries, others don't
4. **Logging/Monitoring**: Need consistent logging across all methods
5. **Configuration**: Each method has different config needs

### 4.2 Modified Implementation

```swift
// Modified Strategy with async, validation, and retry support
protocol PaymentStrategy {
    // Basic info
    var methodName: String { get }
    var methodType: PaymentMethodType { get }

    // Validation (added)
    func validate(request: PaymentRequest) async throws

    // Core processing (modified to async)
    func processPayment(request: PaymentRequest) async throws -> PaymentResult

    // Retry configuration (added)
    var retryConfig: RetryConfig { get }

    // Timeout (added)
    var timeout: TimeInterval { get }
}

// Default implementations for common behavior
extension PaymentStrategy {
    var timeout: TimeInterval { 30.0 }

    var retryConfig: RetryConfig {
        RetryConfig(maxAttempts: 3, backoff: .exponential)
    }
}

// Context with enhanced error handling and monitoring
class PaymentProcessor {
    private let strategy: PaymentStrategy
    private let monitor: PaymentMonitor
    private let logger: Logger

    init(strategy: PaymentStrategy, monitor: PaymentMonitor, logger: Logger) {
        self.strategy = strategy
        self.monitor = monitor
        self.logger = logger
    }

    func process(request: PaymentRequest) async throws -> PaymentResult {
        let startTime = Date()

        // Log start
        logger.info("Processing payment", metadata: [
            "method": strategy.methodName,
            "amount": request.amount
        ])

        do {
            // Validate (added step)
            try await strategy.validate(request: request)

            // Process with timeout (modified)
            let result = try await withTimeout(strategy.timeout) {
                try await processWithRetry(request: request)
            }

            // Monitor success (added)
            monitor.recordSuccess(
                method: strategy.methodName,
                amount: request.amount,
                duration: Date().timeIntervalSince(startTime)
            )

            return result

        } catch {
            // Monitor failure (added)
            monitor.recordFailure(
                method: strategy.methodName,
                error: error,
                duration: Date().timeIntervalSince(startTime)
            )

            logger.error("Payment failed", error: error)
            throw error
        }
    }

    // Retry logic (added)
    private func processWithRetry(request: PaymentRequest) async throws -> PaymentResult {
        let config = strategy.retryConfig
        var lastError: Error?

        for attempt in 1...config.maxAttempts {
            do {
                return try await strategy.processPayment(request: request)
            } catch let error as RetryableError {
                lastError = error
                logger.warning("Payment attempt \(attempt) failed, retrying...")

                if attempt < config.maxAttempts {
                    try await Task.sleep(nanoseconds: config.backoff.delay(for: attempt))
                }
            } catch {
                // Non-retryable error, fail immediately
                throw error
            }
        }

        throw lastError ?? PaymentError.unknown
    }
}

// Concrete strategy example
class CreditCardStrategy: PaymentStrategy {
    let methodName = "Credit Card"
    let methodType = PaymentMethodType.creditCard
    let gateway: PaymentGateway

    // Custom timeout for credit cards
    var timeout: TimeInterval { 20.0 }

    // Custom retry config
    var retryConfig: RetryConfig {
        RetryConfig(maxAttempts: 2, backoff: .linear) // Less aggressive for credit cards
    }

    func validate(request: PaymentRequest) async throws {
        guard let cardDetails = request.cardDetails else {
            throw PaymentError.missingCardDetails
        }

        // Luhn algorithm
        guard isValidCardNumber(cardDetails.number) else {
            throw PaymentError.invalidCardNumber
        }

        // Expiry check
        guard !cardDetails.isExpired else {
            throw PaymentError.cardExpired
        }
    }

    func processPayment(request: PaymentRequest) async throws -> PaymentResult {
        return try await gateway.charge(
            cardNumber: request.cardDetails!.number,
            amount: request.amount,
            currency: request.currency
        )
    }

    private func isValidCardNumber(_ number: String) -> Bool {
        // Luhn algorithm implementation
    }
}

class PayPalStrategy: PaymentStrategy {
    let methodName = "PayPal"
    let methodType = PaymentMethodType.paypal
    let client: PayPalClient

    // PayPal is slower, needs longer timeout
    var timeout: TimeInterval { 45.0 }

    // PayPal benefits from more retries
    var retryConfig: RetryConfig {
        RetryConfig(maxAttempts: 5, backoff: .exponential)
    }

    func validate(request: PaymentRequest) async throws {
        guard let email = request.paypalEmail else {
            throw PaymentError.missingPayPalEmail
        }

        guard isValidEmail(email) else {
            throw PaymentError.invalidEmail
        }
    }

    func processPayment(request: PaymentRequest) async throws -> PaymentResult {
        return try await client.createPayment(
            email: request.paypalEmail!,
            amount: request.amount,
            currency: request.currency
        )
    }
}
```

### 4.3 Key Modifications

| Modification | Reason | Impact |
|--------------|--------|--------|
| **Async/await** | Payment APIs are async | Modern, clean async handling |
| **validate()** | Each method has different validation | Early failure, better UX |
| **retryConfig** | Some methods need retries | Resilience, customizable per method |
| **timeout** | Different methods need different timeouts | Prevents hanging requests |
| **Context enhancements** | Need monitoring and logging | Production-ready, observable |
| **Default implementations** | Reduce boilerplate | DRY, easier to add new strategies |

---

## 5. Why Modifications Are Justified

### 5.1 Async/Await Addition

**Problem**: Standard pattern is synchronous, payment APIs are async

**Without modification**:
```swift
// Blocking, bad for server performance
func processPayment(amount: Double) throws -> PaymentResult {
    let semaphore = DispatchSemaphore(value: 0)
    var result: PaymentResult?

    gateway.charge(amount: amount) { response in
        result = response
        semaphore.signal()
    }

    semaphore.wait()
    return result!
}
```

**With modification**:
```swift
// Non-blocking, modern Swift
func processPayment(request: PaymentRequest) async throws -> PaymentResult {
    return try await gateway.charge(amount: request.amount)
}
```

**Benefit**: Cleaner code, better performance, idiomatic Swift

### 5.2 Validation Addition

**Problem**: Payment errors are expensive (fees, customer frustration)

**Impact**:
- Catch invalid cards before API call (save $0.10 per attempt)
- Better error messages for users
- Reduced load on payment gateways

**ROI**: 10,000 failed payments/month × $0.10 = $1,000/month saved

### 5.3 Retry Logic Addition

**Problem**: Payment gateways have transient failures

**Statistics from our logs**:
- 5% of payments fail due to network issues
- 80% of those succeed on retry
- Lost revenue: 4% of transactions

**Impact**:
- Recover 4% of failed transactions
- $50K/month in additional revenue

**Trade-off**: Slightly more complex, but pays for itself immediately

---

## 6. Results

### 6.1 Before Pattern (God Function)

| Metric | Value |
|--------|-------|
| Function length | 195 lines |
| Cyclomatic complexity | 24 |
| Time to add new method | 2-3 days |
| Test coverage | 68% |
| Bugs in 3 months | 7 |
| Payment success rate | 91.5% |

### 6.2 After Pattern (Modified Strategy)

| Metric | Value |
|--------|-------|
| Average strategy length | 45 lines |
| Cyclomatic complexity | 6 (per strategy) |
| Time to add new method | 4 hours |
| Test coverage | 94% |
| Bugs in 3 months | 1 |
| Payment success rate | 95.8% (+4.3%) |

### 6.3 Business Impact

**Revenue Impact**:
- Increased success rate: +4.3%
- Monthly transaction volume: $2M
- Additional revenue: **$86K/month**

**Development Impact**:
- 85% reduction in time to add payment method
- 85% reduction in bugs
- Better test coverage

**ROI**: Pattern modifications paid for themselves in first month

---

## 7. Lessons Learned

### What Worked Well
✅ **Modifications were justified**: Async, validation, retry all had clear ROI
✅ **Default implementations**: Reduced boilerplate, easy to add strategies
✅ **Production concerns**: Monitoring and logging built-in
✅ **Real requirements**: 4 methods exist, 2 more coming soon

### What We'd Do Differently
⚠️ **Initially over-complicated retry logic**: Simplified after seeing usage patterns
⚠️ **Too many configuration options**: Removed rarely-used options

### Key Insights

> **"Patterns are starting points, not endpoints."**
>
> Modify patterns to fit your context. Don't cargo-cult the textbook version.

> **"Production concerns matter."**
>
> Standard patterns don't include monitoring, logging, timeouts, retries.
> Add them—that's where real value lies.

---

## 8. Evolution Path

### Future Enhancements (When Needed)

**When transaction volume > 1M/month**:
- Add circuit breaker pattern
- Implement fallback strategies

**When methods > 10**:
- Add strategy factory
- Implement strategy selection algorithm

**Not Now Because**:
- Current volume: 100K/month (10x headroom)
- Only 6 methods planned (4x headroom)

---

## Key Takeaway

**Patterns should be modified to fit your needs.**

Standard Strategy pattern was the right choice, but practical modifications made it production-ready:
- Async for modern Swift
- Validation to save costs
- Retries to increase revenue
- Monitoring for observability

Don't be dogmatic. Adapt patterns to your context.
