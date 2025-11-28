# Project Analysis Checklist

## Phase 1: Tech Stack Detection

### iOS/macOS

| Indicator | Detection |
|-----------|-----------|
| `.xcodeproj` | Xcode project |
| `.xcworkspace` | Xcode workspace (CocoaPods/SPM) |
| `Package.swift` | Swift Package Manager |
| `Podfile` | CocoaPods |
| `Cartfile` | Carthage |
| `Tuist/` | Tuist project |
| `project.yml` | XcodeGen |

**Framework Detection**:
- `import SwiftUI` → SwiftUI
- `import UIKit` → UIKit
- `import ComposableArchitecture` → TCA
- `import RxSwift` → RxSwift
- `import Combine` → Combine

### Android

| Indicator | Detection |
|-----------|-----------|
| `build.gradle` | Gradle project |
| `build.gradle.kts` | Kotlin DSL |
| `AndroidManifest.xml` | Android app |
| `settings.gradle` | Multi-module |

**Framework Detection**:
- `Jetpack Compose` imports → Compose UI
- `ViewModel` usage → MVVM
- `Hilt`/`Dagger` → DI framework

### Web/Node

| Indicator | Detection |
|-----------|-----------|
| `package.json` | Node.js project |
| `tsconfig.json` | TypeScript |
| `vite.config.*` | Vite |
| `next.config.*` | Next.js |
| `nuxt.config.*` | Nuxt.js |

**Framework Detection**:
- `react` dependency → React
- `vue` dependency → Vue
- `@angular` dependency → Angular
- `svelte` dependency → Svelte

### Backend

| Indicator | Detection |
|-----------|-----------|
| `requirements.txt` | Python |
| `pyproject.toml` | Modern Python |
| `go.mod` | Go |
| `Cargo.toml` | Rust |
| `pom.xml` | Java Maven |
| `build.gradle` (no Android) | Java/Kotlin Gradle |

---

## Phase 2: Build Tools Detection

### CI/CD

| Path | Platform |
|------|----------|
| `.github/workflows/` | GitHub Actions |
| `.gitlab-ci.yml` | GitLab CI |
| `Jenkinsfile` | Jenkins |
| `.circleci/` | CircleCI |
| `bitbucket-pipelines.yml` | Bitbucket |
| `.travis.yml` | Travis CI |

### Deployment Tools

| Path | Tool |
|------|------|
| `fastlane/` | Fastlane |
| `Fastfile` | Fastlane |
| `firebase.json` | Firebase |
| `vercel.json` | Vercel |
| `netlify.toml` | Netlify |
| `docker-compose.yml` | Docker |
| `Dockerfile` | Docker |
| `kubernetes/`, `k8s/` | Kubernetes |

---

## Phase 3: Existing Documentation

### Common Locations

```
project/
├── README.md
├── CONTRIBUTING.md
├── CHANGELOG.md
├── DESIGN_GUIDELINES.md
├── DESIGN_SYSTEM.md
├── ARCHITECTURE.md
├── API.md
├── docs/
│   ├── *.md
│   └── api/
└── wiki/ (if exists)
```

### Documentation Quality Assessment

| Aspect | Check |
|--------|-------|
| Completeness | Does it cover the topic fully? |
| Currency | Last updated recently? |
| Accuracy | Matches current code? |
| Structure | Well-organized sections? |
| Usability | Easy to reference? |

**Decision Matrix**:
- High quality → @ import directly
- Medium quality → @ import + supplement
- Low quality → Generate new, suggest migration

---

## Phase 4: Code Pattern Detection

### Architecture Patterns

**iOS**:
```swift
// TCA Detection
@Reducer struct
StoreOf<
WithViewStore

// MVVM Detection
class *ViewModel
@Published var
ObservableObject

// Clean Architecture
UseCase
Repository
protocol *Repository
```

**Android**:
```kotlin
// MVVM
ViewModel
StateFlow
LiveData

// Clean Architecture
UseCase
Repository
```

### Design System Detection

**iOS**:
- `Assets.xcassets/Colors/` → Color assets
- `*.colorset` files → Named colors
- `Theme.swift`, `Colors.swift` → Custom theme
- `Typography.swift`, `Fonts.swift` → Custom fonts

**Web**:
- `theme.ts/js` → Theme config
- `tokens/` directory → Design tokens
- `tailwind.config.*` → Tailwind theme
- CSS variables in `:root`

---

## Phase 5: Document Needs Assessment

### Decision Tree

```
Does project have existing DESIGN_GUIDELINES.md?
├── Yes → @ import it, don't create coding-standards
└── No → Create coding-standards.md

Does project have complex architecture (>10 features/modules)?
├── Yes → Create architecture.md
└── No → Brief description in main CLAUDE.md

Does project have build tools (fastlane, npm scripts, etc.)?
├── Yes → Create commands.md
└── No → Skip or minimal

Does project have CI/CD or deployment configs?
├── Yes → Create deployment.md
└── No → Skip

Does project have API endpoints?
├── Yes → Create api.md or reference existing
└── No → Skip
```

### Minimum Viable CLAUDE.md

Every project needs at minimum:
1. Project name + description
2. Response language rule
3. @ import to coding-standards (or existing guidelines)

Everything else is optional based on project complexity.
