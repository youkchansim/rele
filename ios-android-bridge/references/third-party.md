# 서드파티 라이브러리 변환 가이드

## RevenueCat

API가 iOS/Android 거의 동일합니다.

```swift
// iOS
import RevenueCat

Purchases.configure(withAPIKey: "appl_xxx")
Purchases.shared.getOfferings { offerings, error in
    if let pkg = offerings?.current?.monthly {
        Purchases.shared.purchase(package: pkg) { _, info, error, _ in
            if info?.entitlements["premium"]?.isActive == true {
                // 구매 완료
            }
        }
    }
}

// Paywall 체크
let isActive = try await Purchases.shared.customerInfo()
    .entitlements["premium"]?.isActive == true
```

```kotlin
// Android
import com.revenuecat.purchases.*

Purchases.configure(PurchasesConfiguration.Builder(context, "goog_xxx").build())

Purchases.sharedInstance.getOfferingsWith(
    onError = { error -> /* handle */ },
    onSuccess = { offerings ->
        val pkg = offerings.current?.monthly
        pkg?.let {
            Purchases.sharedInstance.purchaseWith(
                PurchaseParams.Builder(activity, it).build(),
                onError = { error, _ -> },
                onSuccess = { _, customerInfo ->
                    if (customerInfo.entitlements["premium"]?.isActive == true) {
                        // 구매 완료
                    }
                }
            )
        }
    }
)

// Coroutines 버전
val customerInfo = Purchases.sharedInstance.awaitCustomerInfo()
val isActive = customerInfo.entitlements["premium"]?.isActive == true
```

---

## Firebase

```swift
// iOS — Analytics
Analytics.logEvent("plan_created", parameters: ["type": "weekly"])

// iOS — Firestore
let db = Firestore.firestore()
try await db.collection("plans").document(id).setData(["title": title])

// iOS — Auth
let result = try await Auth.auth().signIn(withEmail: email, password: password)
```

```kotlin
// Android — Analytics
Firebase.analytics.logEvent("plan_created") {
    param("type", "weekly")
}

// Android — Firestore
val db = Firebase.firestore
db.collection("plans").document(id).set(mapOf("title" to title)).await()

// Android — Auth
val result = Firebase.auth.signInWithEmailAndPassword(email, password).await()
```

---

## 이미지 로딩

```swift
// iOS — Kingfisher
KFImage(URL(string: imageUrl))
    .placeholder { ProgressView() }
    .resizable()
    .aspectRatio(contentMode: .fill)
```

```kotlin
// Android — Coil3
AsyncImage(
    model = imageUrl,
    contentDescription = null,
    contentScale = ContentScale.Crop,
    placeholder = painterResource(R.drawable.placeholder)
)

// build.gradle
implementation("io.coil-kt.coil3:coil-compose:3.0.4")
implementation("io.coil-kt.coil3:coil-network-okhttp:3.0.4")
```

---

## Keychain → EncryptedSharedPreferences

```swift
// iOS — Keychain
KeychainSwift().set(token, forKey: "auth_token")
let token = KeychainSwift().get("auth_token")
```

```kotlin
// Android — EncryptedSharedPreferences
val masterKey = MasterKey.Builder(context)
    .setKeyScheme(MasterKey.KeyScheme.AES256_GCM)
    .build()

val prefs = EncryptedSharedPreferences.create(
    context,
    "secret_prefs",
    masterKey,
    EncryptedSharedPreferences.PrefKeyEncryptionScheme.AES256_SIV,
    EncryptedSharedPreferences.PrefValueEncryptionScheme.AES256_GCM
)

prefs.edit().putString("auth_token", token).apply()
val token = prefs.getString("auth_token", null)
```

---

## Lottie

```swift
// iOS
LottieView(animation: .named("loading"))
    .playing()
    .loopMode(.loop)
```

```kotlin
// Android
val composition by rememberLottieComposition(
    LottieCompositionSpec.RawRes(R.raw.loading)
)
LottieAnimation(
    composition = composition,
    iterations = LottieConstants.IterateForever
)

// build.gradle
implementation("com.airbnb.android:lottie-compose:6.6.0")
```

---

## Alamofire → OkHttp/Retrofit

```swift
// iOS — Alamofire 멀티파트
AF.upload(
    multipartFormData: { $0.append(imageData, withName: "image", fileName: "photo.jpg", mimeType: "image/jpeg") },
    to: "https://api.example.com/upload"
).responseDecodable(of: UploadResponse.self) { response in }
```

```kotlin
// Android — Retrofit 멀티파트
@Multipart
@POST("upload")
suspend fun uploadImage(@Part image: MultipartBody.Part): UploadResponse

// 호출
val requestFile = imageBytes.toRequestBody("image/jpeg".toMediaType())
val part = MultipartBody.Part.createFormData("image", "photo.jpg", requestFile)
val response = apiService.uploadImage(part)
```
