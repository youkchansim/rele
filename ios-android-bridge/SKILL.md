---
name: ios-android-bridge
description: Converts iOS (SwiftUI/Swift) code to Android (Jetpack Compose/Kotlin) equivalents. Use when you want to "Android 버전 만들어줘", "convert to Android", "port iOS code to Android", or "iOS를 Android로 바꿔줘". Translates @Observable ViewModel, Swift Concurrency, SwiftData, SwiftUI views, TCA, RevenueCat, and other iOS patterns to their Android counterparts.
version: 1.0.0
---

# iOS → Android Bridge

iOS 구현을 Android로 자동 변환합니다.

**Language Convention**: Respond in the user's input language.

---

## Workflow

### Phase 1: iOS 코드 분석

변환 전 반드시 파악할 것:

1. **아키텍처 패턴** — MVVM (`@Observable`), TCA, MV, Clean Architecture
2. **비동기 처리** — `async/await`, `async let`, `Task`, `@MainActor`
3. **데이터 레이어** — SwiftData, CoreData, UserDefaults, Keychain
4. **UI 레이어** — SwiftUI View, `@State`, `@Binding`, `@Environment`
5. **서드파티** — RevenueCat, Firebase, Alamofire 등

```
분석 체크리스트:
□ ViewModel/State 관리 방식
□ 네트워크 레이어 존재 여부
□ 데이터 영속성 방식
□ 네비게이션 패턴 (NavigationStack vs NavigationView)
□ DI(의존성 주입) 방식
□ 주요 서드파티 라이브러리
```

### Phase 2: 패턴 매핑 적용

`references/state-viewmodel.md` — ViewModel 변환
`references/concurrency.md` — 비동기 처리 변환
`references/persistence.md` — 데이터 레이어 변환
`references/ui-patterns.md` — UI 컴포넌트 변환
`references/architecture.md` — 아키텍처 변환
`references/third-party.md` — 서드파티 변환

### Phase 3: Android 프로젝트 구조 생성

```
android/
├── app/src/main/java/com/[package]/
│   ├── data/
│   │   ├── local/           # Room DB (SwiftData 대응)
│   │   │   ├── entity/
│   │   │   ├── dao/
│   │   │   └── AppDatabase.kt
│   │   └── repository/      # Repository 패턴
│   ├── domain/
│   │   └── usecase/         # UseCase (iOS Service 대응)
│   └── ui/
│       ├── [feature]/
│       │   ├── [Feature]ViewModel.kt
│       │   └── [Feature]Screen.kt
│       └── theme/           # Material3 테마
└── build.gradle.kts
```

---

## 핵심 변환 규칙

### 1. ViewModel / State 관리

**iOS `@Observable` → Android `@HiltViewModel`**

```swift
// iOS — SwiftUI + @Observable (Swift 5.9+)
import Observation

@Observable
final class PlanViewModel {
    var plans: [Plan] = []
    var isLoading = false
    var error: Error?

    func loadPlans() async {
        isLoading = true
        defer { isLoading = false }
        do {
            plans = try await planService.fetchPlans()
        } catch {
            self.error = error
        }
    }
}
```

```kotlin
// Android — Hilt + ViewModel + StateFlow
@HiltViewModel
class PlanViewModel @Inject constructor(
    private val planRepository: PlanRepository
) : ViewModel() {

    private val _uiState = MutableStateFlow(PlanUiState())
    val uiState: StateFlow<PlanUiState> = _uiState.asStateFlow()

    fun loadPlans() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true) }
            planRepository.fetchPlans()
                .onSuccess { plans ->
                    _uiState.update { it.copy(plans = plans, isLoading = false) }
                }
                .onFailure { error ->
                    _uiState.update { it.copy(error = error, isLoading = false) }
                }
        }
    }
}

data class PlanUiState(
    val plans: List<Plan> = emptyList(),
    val isLoading: Boolean = false,
    val error: Throwable? = null
)
```

**iOS ObservableObject (`@Published`) → StateFlow**

```swift
// iOS (구형 패턴 — iOS 16 이하)
class PlanViewModel: ObservableObject {
    @Published var plans: [Plan] = []
}
```

```kotlin
// Android
private val _plans = MutableStateFlow<List<Plan>>(emptyList())
val plans: StateFlow<List<Plan>> = _plans.asStateFlow()
```

---

### 2. @MainActor / 비동기 처리

**`@MainActor async func` → `viewModelScope.launch(Dispatchers.Main)`**

```swift
// iOS
@MainActor
func updateUI() async {
    let result = await fetchData()
    self.data = result
}

// iOS — Task 생성
func onAppear() {
    Task {
        await loadData()
    }
}
```

```kotlin
// Android — ViewModel 내부
fun updateUI() {
    viewModelScope.launch(Dispatchers.Main) {
        val result = fetchData()
        _uiState.update { it.copy(data = result) }
    }
}

// Android — LaunchedEffect (View에서)
LaunchedEffect(Unit) {
    viewModel.loadData()
}
```

**`async let` 병렬 실행 → `async {}` + `awaitAll`**

```swift
// iOS — async let 병렬
async let users = fetchUsers()
async let products = fetchProducts()
let (u, p) = try await (users, products)
```

```kotlin
// Android — async + awaitAll
viewModelScope.launch {
    val usersDeferred = async { fetchUsers() }
    val productsDeferred = async { fetchProducts() }
    val users = usersDeferred.await()
    val products = productsDeferred.await()
    // 또는 awaitAll 사용
    val (users2, products2) = awaitAll(
        async { fetchUsers() },
        async { fetchProducts() }
    )
}
```

---

### 3. SwiftUI View → Jetpack Compose

**`@State` → `remember {}`**

```swift
// iOS
struct PlanView: View {
    @State private var isExpanded = false
    @State private var title = ""
    @Binding var selectedPlan: Plan?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack { ... }
    }
}
```

```kotlin
// Android
@Composable
fun PlanScreen(
    selectedPlan: Plan?,
    onDismiss: () -> Unit,
    viewModel: PlanViewModel = hiltViewModel()
) {
    val uiState by viewModel.uiState.collectAsStateWithLifecycle()
    var isExpanded by remember { mutableStateOf(false) }
    var title by remember { mutableStateOf("") }

    Column { ... }
}
```

**`@Binding` → 콜백 함수 + 상태 hoisting**

```swift
// iOS
@Binding var isOn: Bool
Toggle("옵션", isOn: $isOn)
```

```kotlin
// Android — State hoisting
@Composable
fun ToggleComponent(
    isOn: Boolean,
    onToggle: (Boolean) -> Unit
) {
    Switch(checked = isOn, onCheckedChange = onToggle)
}
```

**NavigationStack → NavHost**

```swift
// iOS
NavigationStack {
    PlanListView()
        .navigationDestination(for: Plan.self) { plan in
            PlanDetailView(plan: plan)
        }
}
```

```kotlin
// Android
NavHost(navController, startDestination = "plan_list") {
    composable("plan_list") { PlanListScreen(navController) }
    composable("plan_detail/{planId}") { backStackEntry ->
        val planId = backStackEntry.arguments?.getString("planId")
        PlanDetailScreen(planId = planId)
    }
}
```

---

### 4. SwiftData → Room

**`@Model` → `@Entity` + `@Dao` + `AppDatabase`**

```swift
// iOS — SwiftData
import SwiftData

@Model
final class Plan {
    var id: UUID
    var title: String
    var createdAt: Date
    var subjects: [Subject]

    init(title: String) {
        self.id = UUID()
        self.title = title
        self.createdAt = Date()
        self.subjects = []
    }
}

// 사용
let descriptor = FetchDescriptor<Plan>(sortBy: [SortDescriptor(\.createdAt)])
let plans = try context.fetch(descriptor)
```

```kotlin
// Android — Room
@Entity(tableName = "plans")
data class PlanEntity(
    @PrimaryKey val id: String = UUID.randomUUID().toString(),
    val title: String,
    val createdAt: Long = System.currentTimeMillis()
)

@Dao
interface PlanDao {
    @Query("SELECT * FROM plans ORDER BY createdAt DESC")
    fun getAllPlans(): Flow<List<PlanEntity>>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertPlan(plan: PlanEntity)

    @Delete
    suspend fun deletePlan(plan: PlanEntity)

    @Update
    suspend fun updatePlan(plan: PlanEntity)
}

@Database(entities = [PlanEntity::class], version = 1)
abstract class AppDatabase : RoomDatabase() {
    abstract fun planDao(): PlanDao

    companion object {
        @Volatile private var instance: AppDatabase? = null

        fun getInstance(context: Context): AppDatabase =
            instance ?: synchronized(this) {
                Room.databaseBuilder(context, AppDatabase::class.java, "app_db")
                    .build().also { instance = it }
            }
    }
}
```

**1:N 관계 (`@Relationship`) → Room `@Relation`**

```swift
// iOS
@Model
final class Plan {
    @Relationship(deleteRule: .cascade)
    var subjects: [Subject] = []
}
```

```kotlin
// Android — Room 관계
data class PlanWithSubjects(
    @Embedded val plan: PlanEntity,
    @Relation(
        parentColumn = "id",
        entityColumn = "planId"
    )
    val subjects: List<SubjectEntity>
)
```

---

### 5. TCA (The Composable Architecture) → ViewModel + StateFlow

**TCA Reducer → ViewModel + sealed class Action**

```swift
// iOS — TCA
@Reducer
struct PlanFeature {
    struct State: Equatable {
        var plans: [Plan] = []
        var isLoading = false
    }

    enum Action {
        case loadPlans
        case plansLoaded([Plan])
        case deletePlan(Plan)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadPlans:
                state.isLoading = true
                return .run { send in
                    let plans = try await planService.fetchPlans()
                    await send(.plansLoaded(plans))
                }
            case .plansLoaded(let plans):
                state.plans = plans
                state.isLoading = false
                return .none
            case .deletePlan(let plan):
                state.plans.removeAll { $0.id == plan.id }
                return .run { _ in try await planService.delete(plan) }
            }
        }
    }
}
```

```kotlin
// Android — ViewModel + sealed class (TCA 스타일 유지)
@HiltViewModel
class PlanViewModel @Inject constructor(
    private val planRepository: PlanRepository
) : ViewModel() {

    private val _state = MutableStateFlow(PlanState())
    val state: StateFlow<PlanState> = _state.asStateFlow()

    sealed class Action {
        object LoadPlans : Action()
        data class PlansLoaded(val plans: List<Plan>) : Action()
        data class DeletePlan(val plan: Plan) : Action()
    }

    fun send(action: Action) {
        when (action) {
            is Action.LoadPlans -> {
                _state.update { it.copy(isLoading = true) }
                viewModelScope.launch {
                    val plans = planRepository.fetchPlans()
                    send(Action.PlansLoaded(plans))
                }
            }
            is Action.PlansLoaded -> {
                _state.update { it.copy(plans = action.plans, isLoading = false) }
            }
            is Action.DeletePlan -> {
                _state.update { it.copy(plans = it.plans - action.plan) }
                viewModelScope.launch { planRepository.delete(action.plan) }
            }
        }
    }
}

data class PlanState(
    val plans: List<Plan> = emptyList(),
    val isLoading: Boolean = false
)
```

---

### 6. 의존성 주입

**iOS (생성자 주입 / Environment) → Hilt**

```swift
// iOS — 직접 주입
let viewModel = PlanViewModel(planService: PlanService())

// iOS — Environment
@Environment(PlanViewModel.self) var viewModel
```

```kotlin
// Android — Hilt 모듈
@Module
@InstallIn(SingletonComponent::class)
object AppModule {

    @Provides @Singleton
    fun provideDatabase(@ApplicationContext ctx: Context): AppDatabase =
        AppDatabase.getInstance(ctx)

    @Provides @Singleton
    fun providePlanDao(db: AppDatabase): PlanDao = db.planDao()

    @Provides @Singleton
    fun providePlanRepository(dao: PlanDao): PlanRepository =
        PlanRepositoryImpl(dao)
}
```

---

### 7. UserDefaults → DataStore

```swift
// iOS
UserDefaults.standard.set(true, forKey: "isOnboardingCompleted")
let value = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")

// iOS — @AppStorage
@AppStorage("isOnboardingCompleted") var isCompleted = false
```

```kotlin
// Android — DataStore (Proto 또는 Preferences)
val Context.dataStore: DataStore<Preferences> by preferencesDataStore(name = "settings")

val IS_ONBOARDING_COMPLETED = booleanPreferencesKey("is_onboarding_completed")

// 읽기
val isCompleted: Flow<Boolean> = context.dataStore.data
    .map { prefs -> prefs[IS_ONBOARDING_COMPLETED] ?: false }

// 쓰기
suspend fun setOnboardingCompleted(completed: Boolean) {
    context.dataStore.edit { prefs ->
        prefs[IS_ONBOARDING_COMPLETED] = completed
    }
}
```

---

### 8. 네트워크 (Alamofire/URLSession → Retrofit)

```swift
// iOS — Alamofire
AF.request("https://api.example.com/plans")
    .responseDecodable(of: [Plan].self) { response in
        // handle
    }

// iOS — URLSession + async/await
let (data, _) = try await URLSession.shared.data(from: url)
let plans = try JSONDecoder().decode([Plan].self, from: data)
```

```kotlin
// Android — Retrofit
interface PlanApiService {
    @GET("plans")
    suspend fun getPlans(): List<PlanDto>
}

@Provides @Singleton
fun provideRetrofit(): Retrofit = Retrofit.Builder()
    .baseUrl("https://api.example.com/")
    .addConverterFactory(GsonConverterFactory.create())
    .build()

@Provides @Singleton
fun providePlanApiService(retrofit: Retrofit): PlanApiService =
    retrofit.create(PlanApiService::class.java)
```

---

## 의존성 (Gradle)

변환 시 필요한 표준 의존성:

```kotlin
// build.gradle.kts (app)
dependencies {
    // Compose
    implementation(platform("androidx.compose:compose-bom:2024.12.01"))
    implementation("androidx.compose.ui:ui")
    implementation("androidx.compose.material3:material3")
    implementation("androidx.activity:activity-compose:1.9.3")

    // ViewModel + Lifecycle
    implementation("androidx.lifecycle:lifecycle-viewmodel-compose:2.8.7")
    implementation("androidx.lifecycle:lifecycle-runtime-compose:2.8.7")

    // Hilt
    implementation("com.google.dagger:hilt-android:2.51.1")
    kapt("com.google.dagger:hilt-android-compiler:2.51.1")
    implementation("androidx.hilt:hilt-navigation-compose:1.2.0")

    // Room
    implementation("androidx.room:room-runtime:2.6.1")
    implementation("androidx.room:room-ktx:2.6.1")
    kapt("androidx.room:room-compiler:2.6.1")

    // DataStore
    implementation("androidx.datastore:datastore-preferences:1.1.1")

    // Navigation
    implementation("androidx.navigation:navigation-compose:2.8.5")

    // Retrofit
    implementation("com.squareup.retrofit2:retrofit:2.11.0")
    implementation("com.squareup.retrofit2:converter-gson:2.11.0")
    implementation("com.squareup.okhttp3:logging-interceptor:4.12.0")

    // Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.8.1")
}
```

---

## 서드파티 변환

자세한 변환 가이드는 `references/third-party.md` 참고.

| iOS | Android |
|-----|---------|
| RevenueCat iOS SDK | RevenueCat Android SDK (API 동일) |
| Firebase iOS | Firebase Android (동일 패턴) |
| Alamofire | Retrofit + OkHttp |
| Kingfisher | Coil3 |
| Lottie iOS | Lottie Android |
| Sentry iOS | Sentry Android |

---

## 출력 형식

```
## iOS → Android 변환: [기능명]

### 변환 요약
- 아키텍처: [iOS 패턴] → [Android 패턴]
- 데이터: [SwiftData/etc] → [Room/etc]
- 비동기: [async/await] → [Coroutines]

### 변환된 파일
1. `[Feature]ViewModel.kt`
[코드 블록]

2. `[Feature]Screen.kt`
[코드 블록]

3. `[Entity].kt` (Room)
[코드 블록]

### 필요한 Gradle 의존성
[의존성 목록]

### 주의사항
[iOS와 Android의 차이점, 주의할 부분]
```
