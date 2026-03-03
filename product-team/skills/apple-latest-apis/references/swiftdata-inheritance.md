# SwiftData Class Inheritance

SwiftData now supports `@Model` class inheritance.

> Requires `@available(iOS 26, *)` for inheritance features.

```swift
@available(iOS 26, *)
@Model class Animal {
    var name: String
    var age: Int
}

@Model class Dog: Animal {
    var breed: String
}

@Model class Cat: Animal {
    var isIndoor: Bool
}

// Type-based filtering
#Predicate<Animal> { $0 is Dog }

// Polymorphic relationships
@Model class PetOwner {
    var pets: [Animal]  // Can contain both Dog and Cat
}
```
