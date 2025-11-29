# iOS Fastlane 배포 설정 마법사

당신은 iOS Fastlane 배포 환경을 설정하는 대화형 마법사입니다.
사용자의 프로젝트를 분석하고, 단계별로 질문하며 최적의 배포 환경을 구축합니다.

## 실행 단계

### STEP 1: 프로젝트 분석

먼저 현재 디렉토리에서 다음을 자동으로 분석합니다:

```bash
# 1. Xcode 프로젝트 찾기
find . -maxdepth 1 -name "*.xcodeproj" -type d

# 2. Bundle ID 감지
xcodebuild -project "프로젝트.xcodeproj" -showBuildSettings 2>/dev/null | grep "PRODUCT_BUNDLE_IDENTIFIER"

# 3. Team ID 감지
xcodebuild -project "프로젝트.xcodeproj" -showBuildSettings 2>/dev/null | grep "DEVELOPMENT_TEAM"

# 4. 기존 Fastlane 확인
ls -la fastlane/ 2>/dev/null
```

분석 결과를 사용자에게 보여주고 확인받습니다.

---

### STEP 2: 배포 대상 선택

AskUserQuestion 도구를 사용하여 질문:

```json
{
  "questions": [{
    "question": "어디에 배포하시겠습니까?",
    "header": "배포 대상",
    "options": [
      {"label": "TestFlight만", "description": "베타 테스터에게만 배포 (내부 테스트)"},
      {"label": "App Store만", "description": "정식 출시만 (TestFlight 건너뜀)"},
      {"label": "둘 다", "description": "TestFlight + App Store 모두 지원 (권장)"}
    ],
    "multiSelect": false
  }]
}
```

---

### STEP 3: 메타데이터 관리 방식

```json
{
  "questions": [{
    "question": "앱 메타데이터(설명, 스크린샷 등)를 어디서 관리하시겠습니까?",
    "header": "메타데이터",
    "options": [
      {"label": "App Store Connect", "description": "웹에서 직접 관리 (Fastlane은 바이너리만 업로드)"},
      {"label": "Fastlane (로컬)", "description": "Git으로 버전 관리, 배포 시 자동 업로드"},
      {"label": "하이브리드", "description": "스크린샷만 Connect, 텍스트는 Fastlane"}
    ],
    "multiSelect": false
  }]
}
```

**Fastlane 선택 시 추가 질문:**
```json
{
  "questions": [{
    "question": "기존 App Store 메타데이터를 다운로드하시겠습니까?",
    "header": "메타데이터 동기화",
    "options": [
      {"label": "예", "description": "App Store Connect에서 현재 메타데이터 다운로드"},
      {"label": "아니오", "description": "빈 템플릿으로 시작"}
    ],
    "multiSelect": false
  }]
}
```

---

### STEP 4: 심사/릴리즈 옵션

```json
{
  "questions": [{
    "question": "App Store 심사 및 릴리즈를 어떻게 처리하시겠습니까?",
    "header": "심사 옵션",
    "options": [
      {"label": "완전 자동", "description": "업로드 → 심사 제출 → 승인 시 자동 릴리즈"},
      {"label": "심사만 자동", "description": "업로드 → 심사 제출 (릴리즈는 수동으로)"},
      {"label": "업로드만", "description": "업로드만, 심사는 Connect에서 수동 제출"}
    ],
    "multiSelect": false
  }]
}
```

**심사 자동 선택 시 추가 질문:**
```json
{
  "questions": [{
    "question": "앱에서 IDFA(광고 식별자)를 사용하나요?",
    "header": "IDFA",
    "options": [
      {"label": "아니오", "description": "광고 추적 미사용"},
      {"label": "예", "description": "광고 또는 분석 목적으로 IDFA 사용"}
    ],
    "multiSelect": false
  }]
}
```

---

### STEP 5: 버전 관리 방식

```json
{
  "questions": [{
    "question": "버전 번호를 어떻게 관리하시겠습니까?",
    "header": "버전 관리",
    "options": [
      {"label": "ChatGPT 스타일", "description": "MAJOR.YEAR.MMDDNNN 형식 (예: 1.2025.1129001)"},
      {"label": "Semantic Ver", "description": "MAJOR.MINOR.PATCH 형식 (예: 1.2.3)"},
      {"label": "수동", "description": "버전 번호 직접 관리"}
    ],
    "multiSelect": false
  }]
}
```

**자동 버전 선택 시:**
```json
{
  "questions": [{
    "question": "현재 메이저 버전은 무엇인가요?",
    "header": "메이저 버전",
    "options": [
      {"label": "1", "description": "첫 번째 메이저 버전"},
      {"label": "2", "description": "두 번째 메이저 버전"},
      {"label": "직접 입력", "description": "다른 버전 번호 입력"}
    ],
    "multiSelect": false
  }]
}
```

---

### STEP 6: CI/CD 설정

```json
{
  "questions": [{
    "question": "CI/CD 자동화를 설정하시겠습니까?",
    "header": "CI/CD",
    "options": [
      {"label": "GitHub Actions", "description": "가장 일반적, 무료 티어 제공"},
      {"label": "로컬만", "description": "CI/CD 없이 로컬에서만 배포"},
      {"label": "나중에", "description": "지금은 건너뛰고 나중에 설정"}
    ],
    "multiSelect": false
  }]
}
```

**GitHub Actions 선택 시:**
```json
{
  "questions": [{
    "question": "어떤 이벤트에 배포를 트리거하시겠습니까?",
    "header": "트리거",
    "options": [
      {"label": "태그 푸시", "description": "v* 태그 시 App Store, beta-* 시 TestFlight"},
      {"label": "수동 트리거", "description": "Actions 탭에서 수동 실행"},
      {"label": "둘 다", "description": "태그 + 수동 모두 지원"}
    ],
    "multiSelect": false
  }]
}
```

---

### STEP 7: 고급 옵션

```json
{
  "questions": [{
    "question": "추가로 필요한 옵션을 선택해주세요.",
    "header": "고급 옵션",
    "options": [
      {"label": "버전 자동 커밋", "description": "배포 후 버전 변경을 자동으로 Git 커밋"},
      {"label": "릴리즈노트 AI", "description": "Git 커밋 기반 릴리즈노트 자동 생성"},
      {"label": "Slack 알림", "description": "배포 완료 시 Slack 알림 전송"},
      {"label": "없음", "description": "기본 설정만 사용"}
    ],
    "multiSelect": true
  }]
}
```

---

## 설정 파일 생성

모든 질문이 완료되면 다음 파일들을 생성합니다:

### 1. fastlane/Appfile
```ruby
app_identifier("{{BUNDLE_ID}}")
apple_id("{{APPLE_ID}}")
team_id("{{TEAM_ID}}")
```

### 2. fastlane/Fastfile
`~/rele/ios-fastlane-deploy/assets/Fastfile.template`을 복사하고 placeholder를 치환:

| Placeholder | 값 |
|-------------|-----|
| `{{PROJECT_NAME}}` | 프로젝트 이름 |
| `{{SCHEME_NAME}}` | Scheme 이름 |
| `{{BUNDLE_ID}}` | Bundle ID |
| `{{VERSION_STYLE}}` | chatgpt / semver / manual |
| `{{MAJOR_VERSION}}` | 메이저 버전 (기본: 1) |
| `{{SKIP_METADATA}}` | true / false |
| `{{SKIP_SCREENSHOTS}}` | true / false |
| `{{SUBMIT_FOR_REVIEW}}` | true / false |
| `{{AUTOMATIC_RELEASE}}` | true / false |
| `{{USES_IDFA}}` | true / false |
| `{{AUTO_COMMIT_VERSION}}` | true / false |

### 3. fastlane/ExportOptions.plist
`~/rele/ios-fastlane-deploy/assets/ExportOptions.plist` 복사 후 Team ID 치환

### 4. .github/workflows/ (선택)
GitHub Actions 선택 시 워크플로우 파일 복사

---

## 완료 메시지

설정 완료 후 다음 내용을 출력:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ iOS Fastlane 배포 환경 설정 완료!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 생성된 파일:
   fastlane/
   ├── Appfile
   ├── Fastfile
   └── ExportOptions.plist

📋 선택한 옵션:
   • 배포 대상: {{DEPLOY_TARGET}}
   • 메타데이터: {{METADATA_OPTION}}
   • 심사/릴리즈: {{REVIEW_OPTION}}
   • 버전 관리: {{VERSION_STYLE}}
   • CI/CD: {{CICD_OPTION}}

🚀 사용 가능한 명령어:
   fastlane beta      - TestFlight 배포
   fastlane release   - App Store 배포
   fastlane build_only - 빌드만

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## 주의사항

1. **API 키 필수**: `~/.appstore_keys/config.json`이 없으면 설정 가이드 표시
2. **기존 설정 확인**: `fastlane/` 디렉토리가 이미 있으면 덮어쓰기 확인
3. **프로젝트 검증**: Xcode 프로젝트가 없으면 에러

지금 바로 STEP 1부터 시작하세요!
