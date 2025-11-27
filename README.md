# rele

개인 사이드 프로젝트를 위한 Skills 마켓플레이스입니다.

## 설치 방법

### 방법 1: Plugin Marketplace로 설치 (권장)

```bash
# Claude Code에서 마켓플레이스 추가
/plugin marketplace add youkchansim/rele

# 스킬 설치
/plugin install ios-fastlane-deploy@rele
```

### 방법 2: 직접 스킬 복사

개인 스킬로 설치 (모든 프로젝트에서 사용):
```bash
cp -r ~/rele/skills/ios-fastlane-deploy ~/.claude/skills/
```

프로젝트 스킬로 설치 (팀 공유):
```bash
cp -r ~/rele/skills/ios-fastlane-deploy ./.claude/skills/
git add .claude/skills/ios-fastlane-deploy
git commit -m "Add ios-fastlane-deploy skill"
```

## 사용 가능한 Skill

| Skill | 설명 |
|-------|------|
| [ios-fastlane-deploy](./skills/ios-fastlane-deploy) | iOS 앱 자동 배포 (App Store, TestFlight) |

## ios-fastlane-deploy 사용법

### 빠른 시작 (새 프로젝트)

```bash
# 1. 대화형 설정 스크립트 실행 (권장!)
~/rele/skills/ios-fastlane-deploy/scripts/setup.sh /path/to/project

# 설정 스크립트가 자동으로:
# - Xcode 프로젝트 감지
# - Bundle ID, Team ID 자동 감지
# - API 키 설정
# - 기존 App Store 앱이면 메타데이터 다운로드
# - 템플릿 파일 복사 및 설정

# 2. 배포
fastlane beta       # TestFlight
fastlane release    # App Store
```

### 배포 명령어

```bash
fastlane beta           # TestFlight 배포
fastlane release        # App Store 배포 (심사 제출)
fastlane build_only     # 빌드만
fastlane sync_metadata  # App Store에서 메타데이터 다운로드
fastlane upload_metadata # 메타데이터만 업로드
```

### 수동 설정 (선택)

1. 템플릿 복사:
   ```bash
   cp ~/rele/skills/ios-fastlane-deploy/assets/Fastfile.template ./fastlane/Fastfile
   cp ~/rele/skills/ios-fastlane-deploy/assets/Appfile.template ./fastlane/Appfile
   cp ~/rele/skills/ios-fastlane-deploy/assets/ExportOptions.plist ./fastlane/
   ```

2. 설정 수정 (Fastfile):
   - `PROJECT`: Xcode 프로젝트 파일명
   - `SCHEME`: 빌드 Scheme 이름
   - `API_KEY`: App Store Connect API 키 정보

3. 검증:
   ```bash
   ~/rele/skills/ios-fastlane-deploy/scripts/validate.sh . YourApp
   ```

## 버전 형식

ChatGPT 스타일 자동 버전 관리:

```
MAJOR.YEAR.MMDDNNN

예시:
1.2025.1127001  → 2025년 11월 27일 첫 번째 빌드
1.2025.1127002  → 같은 날 두 번째 빌드
2.2025.1201001  → 메이저 버전 2, 12월 1일 첫 번째 빌드
```

## 추가 예정 Skill

- [ ] `ios-ci-github-actions` - GitHub Actions CI/CD
- [ ] `ios-screenshot-automation` - 스크린샷 자동화
- [ ] `ios-localization` - 다국어 지원 자동화

## 라이선스

MIT
