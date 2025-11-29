---
name: ios-fastlane-deploy
description: iOS 앱을 Fastlane으로 자동 빌드하고 App Store/TestFlight에 배포합니다. 대화형 마법사로 단계별 설정을 지원합니다.
version: 2.0.0
author: YouK Chan Sim
license: MIT
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
  - AskUserQuestion
tags:
  - ios
  - fastlane
  - deployment
  - automation
  - app-store
  - testflight
---

# iOS Fastlane 배포 Skill

iOS 앱의 자동 배포를 위한 완전한 솔루션입니다. **대화형 마법사**를 통해 단계별로 설정을 진행합니다.

---

## 🧙‍♂️ 대화형 설정 마법사

사용자가 "iOS 배포 설정해줘", "Fastlane 구축해줘" 등의 요청을 하면, 아래 단계별로 **AskUserQuestion** 도구를 사용하여 대화형으로 진행합니다.

### 📋 설정 흐름도

```
[STEP 1] 프로젝트 분석 (자동)
    ↓
[STEP 2] 배포 대상 선택
    ↓
[STEP 3] 메타데이터 관리 방식
    ↓
[STEP 4] 심사/릴리즈 옵션
    ↓
[STEP 5] 버전 관리 방식
    ↓
[STEP 6] CI/CD 설정
    ↓
[STEP 7] 고급 옵션
    ↓
[완료] 설정 파일 생성
```

---

## 📝 단계별 질문 가이드

Claude는 각 단계에서 AskUserQuestion 도구를 사용하여 사용자에게 질문합니다.

### STEP 1: 프로젝트 분석 (자동)

**Claude가 자동으로 수행:**
1. Xcode 프로젝트 파일 탐색 (`*.xcodeproj`)
2. Bundle ID 감지
3. Team ID 감지
4. 기존 fastlane 설정 확인
5. App Store Connect 연결 상태 확인

```bash
# 프로젝트 분석 명령어
find . -maxdepth 1 -name "*.xcodeproj" -type d
xcodebuild -project "*.xcodeproj" -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER
```

**분석 결과 출력:**
```
📊 프로젝트 분석 결과
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
프로젝트: YourApp.xcodeproj
Bundle ID: com.yourcompany.app
Team ID: XXXXXXXXXX
기존 Fastlane: ❌ 없음
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

### STEP 2: 배포 대상 선택

**질문:**
```
어디에 배포하시겠습니까?
```

**옵션:**
| 옵션 | 설명 |
|------|------|
| TestFlight만 | 베타 테스터에게만 배포 (내부 테스트) |
| App Store만 | 정식 출시만 (TestFlight 건너뜀) |
| 둘 다 | TestFlight + App Store 모두 지원 (권장) |

**설정 값:** `DEPLOY_TARGET` = `testflight` | `appstore` | `both`

---

### STEP 3: 메타데이터 관리 방식

**질문:**
```
앱 메타데이터(설명, 스크린샷 등)를 어디서 관리하시겠습니까?
```

**옵션:**
| 옵션 | 설명 |
|------|------|
| App Store Connect | 웹에서 직접 관리 (Fastlane은 건드리지 않음) |
| Fastlane (로컬) | Git으로 버전 관리, 자동 업로드 |
| 하이브리드 | 스크린샷만 Connect, 텍스트는 Fastlane |

**설정 값:**
```ruby
# App Store Connect 관리
skip_metadata: true
skip_screenshots: true

# Fastlane 관리
skip_metadata: false
skip_screenshots: false

# 하이브리드
skip_metadata: false
skip_screenshots: true
```

**추가 질문 (Fastlane 선택 시):**
```
기존 App Store 메타데이터를 다운로드하시겠습니까?
```
- 예: `fastlane deliver download_metadata` 실행
- 아니오: 빈 템플릿으로 시작

---

### STEP 4: 심사/릴리즈 옵션

**질문:**
```
App Store 심사 및 릴리즈를 어떻게 처리하시겠습니까?
```

**옵션:**
| 옵션 | 설명 |
|------|------|
| 완전 자동 | 업로드 → 심사 제출 → 승인 시 자동 릴리즈 |
| 심사만 자동 | 업로드 → 심사 제출 (릴리즈는 수동) |
| 업로드만 | 업로드만, 심사는 Connect에서 수동 |

**설정 값:**
```ruby
# 완전 자동
submit_for_review: true
automatic_release: true

# 심사만 자동
submit_for_review: true
automatic_release: false

# 업로드만
submit_for_review: false
automatic_release: false
```

**추가 질문 (심사 자동 선택 시):**
```
앱에서 IDFA(광고 식별자)를 사용하나요?
```
- 예: `add_id_info_uses_idfa: true`
- 아니오: `add_id_info_uses_idfa: false`

---

### STEP 5: 버전 관리 방식

**질문:**
```
버전 번호를 어떻게 관리하시겠습니까?
```

**옵션:**
| 옵션 | 설명 | 예시 |
|------|------|------|
| ChatGPT 스타일 (권장) | MAJOR.YEAR.MMDDNNN | 1.2025.1129001 |
| Semantic Versioning | MAJOR.MINOR.PATCH | 1.2.3 |
| 수동 | 직접 관리 | - |

**설정 값:** `VERSION_STYLE` = `chatgpt` | `semver` | `manual`

**추가 질문 (ChatGPT/SemVer 선택 시):**
```
현재 메이저 버전은 무엇인가요? (기본값: 1)
```

---

### STEP 6: CI/CD 설정

**질문:**
```
CI/CD 자동화를 설정하시겠습니까?
```

**옵션:**
| 옵션 | 설명 |
|------|------|
| GitHub Actions | 가장 일반적, 무료 티어 제공 |
| 로컬만 | CI/CD 없이 로컬에서만 배포 |
| 나중에 | 지금은 건너뛰고 나중에 설정 |

**추가 질문 (GitHub Actions 선택 시):**
```
어떤 이벤트에 배포를 트리거하시겠습니까?
```
| 옵션 | 설명 |
|------|------|
| 태그 푸시 | `v*` 태그 시 App Store, `beta-*` 태그 시 TestFlight |
| 수동 트리거 | Actions 탭에서 수동 실행 |
| 둘 다 | 태그 + 수동 모두 지원 |

---

### STEP 7: 고급 옵션

**질문 (다중 선택):**
```
추가로 필요한 옵션을 선택해주세요. (다중 선택 가능)
```

**옵션:**
| 옵션 | 설명 | 설정 |
|------|------|------|
| 위젯 Extension | 메인 앱과 위젯 함께 빌드 | scheme 확인 |
| 버전 자동 커밋 | 배포 후 버전 변경 자동 커밋 | `skip_commit: false` |
| 릴리즈노트 자동 생성 | Git 커밋 기반 AI 생성 | Claude 연동 |
| 빌드 캐시 | DerivedData 캐싱 (CI용) | GitHub Actions cache |
| Slack 알림 | 배포 완료 시 Slack 알림 | `slack` action 추가 |

---

## 🔧 설정 옵션 전체 목록

### 배포 옵션 (upload_to_app_store)

| 옵션 | 타입 | 기본값 | 설명 |
|------|------|--------|------|
| `skip_metadata` | bool | false | 메타데이터 업로드 건너뛰기 |
| `skip_screenshots` | bool | false | 스크린샷 업로드 건너뛰기 |
| `skip_binary_upload` | bool | false | 바이너리 업로드 건너뛰기 |
| `submit_for_review` | bool | true | 심사 자동 제출 |
| `automatic_release` | bool | true | 승인 후 자동 릴리즈 |
| `run_precheck_before_submit` | bool | false | 제출 전 precheck 실행 |
| `force` | bool | true | 확인 없이 진행 |

### 심사 정보 (submission_information)

| 옵션 | 타입 | 기본값 | 설명 |
|------|------|--------|------|
| `add_id_info_uses_idfa` | bool | false | IDFA 사용 여부 |
| `export_compliance_uses_encryption` | bool | false | 암호화 사용 여부 |
| `export_compliance_platform` | string | - | 암호화 플랫폼 |

### 빌드 옵션 (build_app)

| 옵션 | 타입 | 기본값 | 설명 |
|------|------|--------|------|
| `configuration` | string | "Release" | 빌드 구성 |
| `export_method` | string | "app-store" | 내보내기 방식 |
| `clean` | bool | true | 빌드 전 클린 |
| `include_symbols` | bool | true | dSYM 포함 |
| `include_bitcode` | bool | false | Bitcode 포함 (deprecated) |

### TestFlight 옵션 (upload_to_testflight)

| 옵션 | 타입 | 기본값 | 설명 |
|------|------|--------|------|
| `skip_waiting_for_build_processing` | bool | true | 빌드 처리 대기 건너뛰기 |
| `distribute_external` | bool | false | 외부 테스터에게 배포 |
| `groups` | array | - | 배포할 테스터 그룹 |
| `changelog` | string | - | 테스터용 변경 로그 |

---

## 📁 생성되는 파일 구조

```
project/
├── fastlane/
│   ├── Appfile              # 앱 식별 정보
│   ├── Fastfile             # 배포 레인 정의
│   ├── ExportOptions.plist  # IPA 내보내기 옵션
│   ├── metadata/            # (선택) 메타데이터
│   │   ├── ko/
│   │   │   ├── description.txt
│   │   │   ├── keywords.txt
│   │   │   └── release_notes.txt
│   │   └── en-US/
│   │       └── ...
│   └── screenshots/         # (선택) 스크린샷
│       ├── ko/
│       └── en-US/
└── .github/workflows/       # (선택) CI/CD
    ├── ios-deploy.yml
    └── ios-test.yml
```

---

## 🚀 사용법

### 초기 설정 (대화형 마법사)

사용자 요청 예시:
```
"iOS 배포 설정해줘"
"Fastlane 구축 도와줘"
"App Store 배포 자동화하고 싶어"
```

Claude가 위 STEP 1~7을 순서대로 진행합니다.

### 배포 명령어

```bash
# TestFlight 배포
fastlane beta

# App Store 배포 (기본 릴리즈노트)
fastlane release

# App Store 배포 (커스텀 릴리즈노트)
fastlane release notes:"새로운 기능이 추가되었어요!"

# 메타데이터만 업로드
fastlane upload_metadata

# 빌드만 (업로드 없이)
fastlane build_only
```

### 릴리즈노트 작성

**옵션 1: 기본값**
```bash
fastlane release
# → "안정성을 개선하였어요."
```

**옵션 2: 직접 지정**
```bash
fastlane release notes:"AI 플래너 기능 추가!"
```

**옵션 3: 파일 사용**
```
# fastlane/release_notes.txt
[ko]
새로운 기능이 추가되었어요!
- AI 플래너

[en-US]
New features added!
- AI Planner
```

**옵션 4: Claude AI 자동 생성**
```
"최근 커밋 분석해서 릴리즈노트 만들고 배포해줘"
```

---

## 📌 버전 형식

### ChatGPT 스타일 (기본값)
```
MAJOR.YEAR.MMDDNNN
예: 1.2025.1129001 (2025년 11월 29일 첫 번째 빌드)
    1.2025.1129002 (같은 날 두 번째 빌드)
```

### Semantic Versioning
```
MAJOR.MINOR.PATCH
예: 1.0.0 → 1.0.1 → 1.1.0 → 2.0.0
```

---

## ⚠️ 문제 해결

### API 키 인증 오류
```
undefined method 'app_store_connect_api_key'
```
→ `app_store_connect_api_key`는 **Fastfile**에서만 사용 (Appfile ❌)

### IAP Precheck 오류
```
Precheck cannot check In-app purchases with API Key
```
→ `run_precheck_before_submit: false` 설정 필요

### 편집 가능한 버전 없음
```
Could not find an editable version
```
→ 이전 버전이 심사 중. `submit_for_review: false`로 변경 후 수동 제출

### 위젯 미포함
```bash
unzip -l ./build/App.ipa | grep -i widget
```
→ Scheme에 위젯 Extension이 포함되어 있는지 확인

---

## 🔗 참고 자료

- [Fastlane 공식 문서](https://docs.fastlane.tools)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [deliver 옵션](https://docs.fastlane.tools/actions/deliver/)
- [pilot 옵션](https://docs.fastlane.tools/actions/pilot/)
