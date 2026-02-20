# SwiftUI → Jetpack Compose UI 패턴

## 기본 레이아웃

| SwiftUI | Compose |
|---------|---------|
| `VStack` | `Column` |
| `HStack` | `Row` |
| `ZStack` | `Box` |
| `Spacer()` | `Spacer()` |
| `ScrollView` | `LazyColumn` / `LazyRow` |
| `List` | `LazyColumn` |
| `GeometryReader` | `BoxWithConstraints` |
| `overlay` | `Box` with Z ordering |

## 버튼 & 인터랙션

```swift
// iOS
Button("저장") { save() }
    .buttonStyle(.borderedProminent)

// 아이콘 버튼
Button { action() } label: {
    Image(systemName: "plus")
}
```

```kotlin
// Android
Button(onClick = { save() }) { Text("저장") }

// 아이콘 버튼
IconButton(onClick = { action() }) {
    Icon(Icons.Default.Add, contentDescription = "추가")
}
```

## 리스트

```swift
// iOS
List(plans) { plan in
    PlanRow(plan: plan)
}
.listStyle(.plain)
```

```kotlin
// Android
LazyColumn {
    items(plans, key = { it.id }) { plan ->
        PlanRow(plan = plan)
    }
}
```

## 폼 & 입력

```swift
// iOS
Form {
    Section("기본 정보") {
        TextField("제목", text: $title)
        Toggle("활성화", isOn: $isActive)
        DatePicker("날짜", selection: $date)
    }
}
```

```kotlin
// Android
Column(modifier = Modifier.padding(16.dp)) {
    Text("기본 정보", style = MaterialTheme.typography.titleMedium)
    OutlinedTextField(
        value = title,
        onValueChange = { title = it },
        label = { Text("제목") }
    )
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text("활성화")
        Switch(checked = isActive, onCheckedChange = { isActive = it })
    }
}
```

## 시트 & 모달

```swift
// iOS
.sheet(isPresented: $showDetail) {
    DetailView()
}

.fullScreenCover(isPresented: $showOnboarding) {
    OnboardingView()
}

.confirmationDialog("삭제할까요?", isPresented: $showConfirm) {
    Button("삭제", role: .destructive) { delete() }
    Button("취소", role: .cancel) {}
}
```

```kotlin
// Android
if (showDetail) {
    ModalBottomSheet(onDismissRequest = { showDetail = false }) {
        DetailContent()
    }
}

// Full screen
if (showOnboarding) {
    Dialog(
        onDismissRequest = {},
        properties = DialogProperties(usePlatformDefaultWidth = false)
    ) {
        OnboardingContent()
    }
}

// AlertDialog
if (showConfirm) {
    AlertDialog(
        onDismissRequest = { showConfirm = false },
        title = { Text("삭제할까요?") },
        confirmButton = {
            TextButton(onClick = { delete(); showConfirm = false }) {
                Text("삭제", color = MaterialTheme.colorScheme.error)
            }
        },
        dismissButton = {
            TextButton(onClick = { showConfirm = false }) { Text("취소") }
        }
    )
}
```

## 커스텀 뷰 수정자

```swift
// iOS — ViewModifier
struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.background)
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardStyle())
    }
}
```

```kotlin
// Android — Modifier extension
fun Modifier.cardStyle() = this
    .padding(16.dp)
    .background(
        color = MaterialTheme.colorScheme.surface,
        shape = RoundedCornerShape(12.dp)
    )
    .shadow(elevation = 4.dp, shape = RoundedCornerShape(12.dp))
```

## 애니메이션

```swift
// iOS
withAnimation(.spring(response: 0.3)) {
    isExpanded.toggle()
}

// 트랜지션
if isVisible {
    View()
        .transition(.opacity.combined(with: .scale))
}
```

```kotlin
// Android
// 상태 변화 애니메이션
val scale by animateFloatAsState(
    targetValue = if (isExpanded) 1.2f else 1f,
    animationSpec = spring(dampingRatio = Spring.DampingRatioMediumBouncy)
)

// 가시성 애니메이션
AnimatedVisibility(
    visible = isVisible,
    enter = fadeIn() + scaleIn(),
    exit = fadeOut() + scaleOut()
) {
    Content()
}
```

## 탭 뷰

```swift
// iOS
TabView {
    HomeView().tabItem {
        Label("홈", systemImage: "house")
    }
    ProfileView().tabItem {
        Label("프로필", systemImage: "person")
    }
}
```

```kotlin
// Android
var selectedTab by remember { mutableIntStateOf(0) }
val tabs = listOf("홈" to Icons.Default.Home, "프로필" to Icons.Default.Person)

Scaffold(
    bottomBar = {
        NavigationBar {
            tabs.forEachIndexed { index, (label, icon) ->
                NavigationBarItem(
                    selected = selectedTab == index,
                    onClick = { selectedTab = index },
                    icon = { Icon(icon, contentDescription = label) },
                    label = { Text(label) }
                )
            }
        }
    }
) { padding ->
    when (selectedTab) {
        0 -> HomeScreen(modifier = Modifier.padding(padding))
        1 -> ProfileScreen(modifier = Modifier.padding(padding))
    }
}
```

## 테마 / 색상

```swift
// iOS
Color.accentColor
Color(.systemBackground)
Color(.secondarySystemBackground)
.foregroundStyle(.primary)
.foregroundStyle(.secondary)
```

```kotlin
// Android
MaterialTheme.colorScheme.primary
MaterialTheme.colorScheme.background
MaterialTheme.colorScheme.surfaceVariant
MaterialTheme.colorScheme.onBackground
MaterialTheme.colorScheme.onSurfaceVariant
```
