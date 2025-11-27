# rele

iOS 개발 자동화를 위한 개인 Skill 마켓플레이스입니다.

## 설치 방법

### 방법 1: Plugin으로 설치

```bash
# Claude Code에서 실행
/install-plugin youkchansim/rele
```

### 방법 2: 프로젝트에 직접 연결

각 프로젝트의 `.claude/settings.json`에 추가:

```json
{
  "pluginRepositories": ["youkchansim/rele"]
}
```

## 사용 가능한 Skill

| Skill | 설명 | 버전 |
|-------|------|------|
| [ios-fastlane-deploy](./skills/ios-fastlane-deploy) | iOS 앱 자동 배포 (App Store, TestFlight) | 1.0.0 |

## ios-fastlane-deploy 사용법

### 빠른 시작

```bash
# TestFlight 배포
fastlane beta

# App Store 배포
fastlane release

# 빌드만
fastlane build_only
```

### 새 프로젝트에 적용

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
