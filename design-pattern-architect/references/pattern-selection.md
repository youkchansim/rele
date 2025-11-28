# Design Pattern Selection Guide

## Decision Framework

### Step 1: Is a Pattern Necessary?

Ask these questions FIRST:
- Can this be solved with basic OOP principles?
- Is the problem complex enough to justify pattern overhead?
- Will the team understand and maintain this?

**If NO to any**: Consider pattern-less design.

---

## Problem-to-Pattern Mapping

### 🏗️ Object Creation Complexity

#### Problem: Complex object construction logic
**Symptoms**:
- Constructor with many parameters
- Object creation requires multiple steps
- Different representations of same data

**Candidate Patterns**:
- **Builder**: Complex construction with many optional parameters
- **Factory Method**: Single product, vary creation logic
- **Abstract Factory**: Multiple related products (product families)

**Simple Alternative**:
- Use designated initializers with default parameters
- Create multiple constructors for common cases

**Example Decision Tree**:
```
Complex construction?
├─ Single object with many params → Builder (or default params)
├─ Multiple related objects → Abstract Factory (or simple factory)
└─ Single object with variants → Factory Method (or polymorphism)
```

#### Problem: Ensure only one instance exists
**Symptoms**:
- Global state needed
- Resource must be shared (e.g., configuration, logger)
- Multiple instances would cause issues

**Candidate Patterns**:
- **Singleton**: Controlled global access

**Simple Alternative**:
- Dependency injection with single instance
- Module-level constant

**Warning**: Singletons often indicate design smell. Consider if dependency injection would be cleaner.

---

### 🔌 Interface Adaptation

#### Problem: Incompatible interfaces
**Symptoms**:
- Third-party library has wrong interface
- Legacy code doesn't match new interface
- Need to integrate incompatible systems

**Candidate Patterns**:
- **Adapter**: Convert one interface to another
- **Facade**: Simplify complex subsystem interface

**Simple Alternative**:
- Extension methods/protocols
- Wrapper function

**Example Decision**:
```
Interface mismatch?
├─ Need to simplify complex API → Facade
├─ Need to match specific interface → Adapter
└─ Simple conversion → Extension/Wrapper function
```

---

### 🎨 Runtime Behavior Modification

#### Problem: Behavior changes at runtime
**Symptoms**:
- Need to add/remove responsibilities dynamically
- Behavior varies based on state
- Different algorithms for same operation

**Candidate Patterns**:
- **Decorator**: Add responsibilities without subclassing
- **Strategy**: Swap algorithms at runtime
- **State**: Behavior changes based on internal state

**Simple Alternative**:
- Higher-order functions
- Closures/lambdas
- Simple boolean flags (if only 2 states)

**Example Decision Tree**:
```
Need runtime behavior change?
├─ Add/remove features → Decorator (or composition)
├─ Swap algorithms → Strategy (or function parameters)
└─ State-dependent behavior → State (or switch statement if simple)
```

#### Problem: Define family of algorithms
**Symptoms**:
- Multiple ways to do same thing
- Need to switch algorithms dynamically
- Algorithm selection is complex

**Candidate Patterns**:
- **Strategy**: Encapsulate algorithms, make them interchangeable

**Simple Alternative**:
- Function/closure parameters
- Dictionary of functions

---

### 📡 Object Communication

#### Problem: One-to-many dependencies
**Symptoms**:
- Object state changes need to notify others
- Multiple observers of same object
- Loosely coupled notification needed

**Candidate Patterns**:
- **Observer**: Publish-subscribe mechanism

**Simple Alternative**:
- Callbacks
- Delegation (if one-to-one)
- Native reactive frameworks (Combine, RxSwift)

**Warning**: Don't implement Observer from scratch if platform provides it (Combine, NotificationCenter, etc.).

#### Problem: Complex request handling
**Symptoms**:
- Multiple objects can handle request
- Handler not known in advance
- Need to add handlers dynamically

**Candidate Patterns**:
- **Chain of Responsibility**: Pass request along chain until handled

**Simple Alternative**:
- Array of handlers with loop
- Middleware pattern

---

### 🏛️ Structure & Organization

#### Problem: Simplify complex subsystem
**Symptoms**:
- Subsystem has many classes
- Clients need simple interface
- Reduce coupling to subsystem

**Candidate Patterns**:
- **Facade**: Unified interface to subsystem

**Simple Alternative**:
- Service class with high-level methods
- Module with public API

#### Problem: Shared state across many objects
**Symptoms**:
- Many similar objects with shared data
- Memory optimization needed
- Large number of objects

**Candidate Patterns**:
- **Flyweight**: Share common state

**Simple Alternative**:
- Value types (structs)
- Reference counting
- Only apply if memory is actual problem (measure first!)

---

### 🔄 Process & Workflow

#### Problem: Encapsulate requests as objects
**Symptoms**:
- Need to queue/log operations
- Support undo/redo
- Parameterize objects with operations

**Candidate Patterns**:
- **Command**: Encapsulate request as object

**Simple Alternative**:
- Closures/lambdas (if no undo needed)
- Simple operation queue

#### Problem: Access elements of collection
**Symptoms**:
- Need uniform way to traverse
- Hide internal structure
- Support multiple traversals

**Candidate Patterns**:
- **Iterator**: Sequential access to collection

**Simple Alternative**:
- Built-in iterators (for-in, map, filter)
- Generator functions

**Warning**: Most languages provide iterators built-in. Don't reinvent the wheel.

---

## Anti-Pattern Recognition

### Red Flags That Suggest Simpler Approach

1. **"I'll use X pattern"** without identifying problem
   - **Fix**: Start with problem, not pattern

2. **Patterns for trivial problems**
   - **Fix**: Use simple if-else, functions, or basic OOP

3. **Mixing multiple patterns**
   - **Fix**: One pattern at a time; justify each

4. **Pattern because "it's best practice"**
   - **Fix**: Best practice for whom? In what context?

5. **Premature abstraction**
   - **Fix**: Wait for 3+ use cases before abstracting

---

## Pattern Evaluation Checklist

Before committing to a pattern, evaluate:

### Complexity Cost
- [ ] Implementation effort < expected benefit?
- [ ] Team comfortable with this pattern?
- [ ] Pattern is simpler than alternatives?

### Maintenance Cost
- [ ] Future developers will understand this?
- [ ] Documentation burden is acceptable?
- [ ] Testing complexity is manageable?

### Problem-Fit
- [ ] Pattern directly addresses core problem?
- [ ] Problem is recurring, not one-off?
- [ ] Simple alternatives have been considered?

**If 2+ items unchecked**: Reconsider pattern necessity.

---

## Pattern Combinations (Advanced)

Some patterns work well together:

### Builder + Factory
- **When**: Complex objects with families
- **Example**: UI component builders for different themes

### Strategy + Factory
- **When**: Selecting algorithms based on context
- **Example**: Compression algorithms chosen by file type

### Observer + Command
- **When**: Notifying about operations with undo
- **Example**: Document editor with change notifications

### Decorator + Strategy
- **When**: Adding features to swappable algorithms
- **Example**: Caching layer for different data sources

**Warning**: Pattern combinations increase complexity exponentially. Only combine when problem genuinely requires it.

---

## Language-Specific Considerations

### Swift
- **Use protocols** instead of abstract classes
- **Value types** (structs) change pattern applicability
- **Protocol extensions** can replace some structural patterns
- **First-class functions** simplify Strategy, Command

### TypeScript/JavaScript
- **Duck typing** reduces need for interfaces
- **First-class functions** simplify behavioral patterns
- **Prototypal inheritance** affects classical patterns
- **Async/await** changes concurrency patterns

### Python
- **Duck typing** reduces adapter needs
- **Decorators** (language feature) replace Decorator pattern
- **Context managers** replace some resource patterns
- **Generators** replace Iterator pattern

---

## Quick Reference: Problem → Pattern

| Problem | Pattern | Alternative |
|---------|---------|-------------|
| Complex construction | Builder | Default params |
| One instance only | Singleton | DI + single instance |
| Interface mismatch | Adapter | Wrapper function |
| Simplify subsystem | Facade | Service class |
| Add responsibilities | Decorator | Composition |
| Swap algorithms | Strategy | Function param |
| State-based behavior | State | Switch statement |
| Notify changes | Observer | Platform framework |
| Chain handlers | Chain of Responsibility | Handler array |
| Encapsulate operation | Command | Closure |

**Remember**: "Alternative" is often the better choice for simple cases.
