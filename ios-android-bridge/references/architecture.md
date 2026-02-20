# 아키텍처 패턴 변환

## MVVM (가장 일반적)

### iOS @Observable MVVM

```
View → @Observable ViewModel → Service/Repository
         ↑ reads state directly via @Observable
```

### Android MVVM

```
Composable → ViewModel → Repository → DataSource
                ↓ StateFlow
             collectAsStateWithLifecycle()
```

---

## Clean Architecture

### iOS 레이어 구조

```
Presentation/
├── View/          (SwiftUI View)
└── ViewModel/     (@Observable class)

Domain/
├── UseCase/
└── Model/

Data/
├── Repository/    (Protocol + Implementation)
└── Service/       (Network, SwiftData, etc.)
```

### Android 레이어 구조

```
presentation/
├── ui/            (@Composable)
└── viewmodel/     (@HiltViewModel)

domain/
├── usecase/
└── model/

data/
├── repository/    (interface + impl)
├── local/         (Room)
└── remote/        (Retrofit)
```

---

## TCA → ViewModel 변환 가이드

### TCA 핵심 개념 매핑

| TCA | Android |
|-----|---------|
| `State` | `data class UiState` |
| `Action` | `sealed class Action` |
| `Reducer` | `ViewModel.send()` |
| `Effect` | `viewModelScope.launch {}` |
| `Store` | `ViewModel` (Hilt 주입) |
| `ViewStore` | `uiState.collectAsStateWithLifecycle()` |
| `WithViewStore` | `val state by viewModel.uiState.collectAsStateWithLifecycle()` |
| `Scope` | 별도 ViewModel 또는 중첩 StateFlow |

### 복잡한 TCA Effect 변환

```swift
// iOS — TCA Effect with cancellation
case .startPolling:
    return .run { send in
        for await _ in Timer.publish(every: 5, on: .main, in: .common).autoconnect().values {
            await send(.checkStatus)
        }
    }
    .cancellable(id: CancelID.polling)

case .stopPolling:
    return .cancel(id: CancelID.polling)
```

```kotlin
// Android — Coroutine Job cancellation
private var pollingJob: Job? = null

fun startPolling() {
    pollingJob = viewModelScope.launch {
        while (isActive) {
            checkStatus()
            delay(5000)
        }
    }
}

fun stopPolling() {
    pollingJob?.cancel()
}
```

### TCA 중첩 Reducer → ViewModel 분리

```swift
// iOS — 중첩 Reducer
@Reducer
struct AppFeature {
    struct State {
        var home: HomeFeature.State = .init()
        var profile: ProfileFeature.State = .init()
    }
    // ...
}
```

```kotlin
// Android — 각 화면별 ViewModel 분리 (권장)
// HomeViewModel, ProfileViewModel 각자 독립

// 또는 SharedViewModel로 공유 상태 관리
@HiltViewModel
class AppViewModel @Inject constructor(
    private val repository: AppRepository
) : ViewModel() {
    // 앱 전역 상태만 관리
    val userState: StateFlow<UserState> = ...
}
```

---

## Repository Pattern

```swift
// iOS — Protocol 기반
protocol PlanRepository {
    func fetchAll() async throws -> [Plan]
    func save(_ plan: Plan) async throws
    func delete(_ plan: Plan) async throws
}

final class PlanRepositoryImpl: PlanRepository {
    private let modelContext: ModelContext

    func fetchAll() async throws -> [Plan] {
        let descriptor = FetchDescriptor<Plan>()
        return try modelContext.fetch(descriptor)
    }
}
```

```kotlin
// Android — Interface + Implementation
interface PlanRepository {
    fun getAllPlans(): Flow<List<Plan>>
    suspend fun savePlan(plan: Plan)
    suspend fun deletePlan(plan: Plan)
}

class PlanRepositoryImpl @Inject constructor(
    private val planDao: PlanDao
) : PlanRepository {

    override fun getAllPlans(): Flow<List<Plan>> =
        planDao.getAllPlans().map { entities -> entities.map { it.toDomain() } }

    override suspend fun savePlan(plan: Plan) =
        planDao.insertPlan(plan.toEntity())

    override suspend fun deletePlan(plan: Plan) =
        planDao.deletePlan(plan.toEntity())
}
```

---

## UseCase 패턴

```swift
// iOS
struct CreatePlanUseCase {
    var execute: (String) async throws -> Plan
}

// DI 주입 방식 (TCA Environment 스타일)
extension CreatePlanUseCase {
    static let live = CreatePlanUseCase { title in
        try await PlanService.shared.create(title: title)
    }
}
```

```kotlin
// Android
class CreatePlanUseCase @Inject constructor(
    private val planRepository: PlanRepository
) {
    suspend operator fun invoke(title: String): Result<Plan> =
        runCatching { planRepository.createPlan(title) }
}

// ViewModel에서 사용
class PlanViewModel @Inject constructor(
    private val createPlanUseCase: CreatePlanUseCase
) : ViewModel() {
    fun createPlan(title: String) {
        viewModelScope.launch {
            createPlanUseCase(title)
                .onSuccess { plan -> /* update state */ }
                .onFailure { error -> /* handle error */ }
        }
    }
}
```
