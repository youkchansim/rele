---
name: ios-fastlane-deploy
description: iOS 앱을 Fastlane으로 자동 빌드하고 App Store/TestFlight에 배포합니다. 버전 자동화(ChatGPT 스타일), 위젯 Extension 포함, API 키 인증을 지원합니다.
version: 1.0.0
author: YouK Chan Sim
license: MIT
allowed-tools:
  - Bash
  - Read
  - Write
  - Edit
  - Glob
  - Grep
tags:
  - ios
  - fastlane
  - deployment
  - automation
  - app-store
  - testflight
---

# iOS Fastlane 배포 Skill

iOS 앱의 자동 배포를 위한 완전한 솔루션입니다.

## 기능

- **자동 초기 설정**: 대화형 설정 스크립트로 빠른 구성
- **메타데이터 동기화**: App Store에서 앱 설명, 스크린샷 자동 다운로드
- **App Store 배포**: 빌드 → 업로드 → 심사 제출 자동화
- **TestFlight 베타**: 테스터에게 빠른 배포
- **자동 버전 관리**: ChatGPT 스타일 (`MAJOR.YEAR.MMDDNNN`)
- **스마트 릴리즈노트**: 기본값, 파일, AI 생성 지원
- **위젯 Extension**: 메인 앱과 함께 자동 빌드
- **API 키 인증**: 2FA 없이 안정적인 배포

## 버전 형식

```
MAJOR.YEAR.MMDDNNN
예시: 1.2025.1127001 (2025년 11월 27일 첫 번째 빌드)
      1.2025.1127002 (같은 날 두 번째 빌드)
```

## 사용법

### 초기 설정 (새 프로젝트)

```bash
# 대화형 설정 스크립트 실행 (권장)
~/rele/skills/ios-fastlane-deploy/scripts/setup.sh /path/to/project

# 설정 스크립트가 수행하는 작업:
# 1. Xcode 프로젝트 자동 감지
# 2. Bundle ID, Team ID 자동 감지
# 3. API 키 설정
# 4. 기존 App Store 앱이면 메타데이터 다운로드
# 5. 템플릿 파일 복사 및 설정
```

### 배포 명령어

```bash
# App Store 배포 (기본 릴리즈노트: "안정성을 개선하였어요")
fastlane release

# App Store 배포 (커스텀 릴리즈노트)
fastlane release notes:"새로운 기능이 추가되었어요!"

# TestFlight 베타 배포
fastlane beta

# 빌드만 (업로드 없이)
fastlane build_only

# 메타데이터 다운로드 (App Store에서)
fastlane sync_metadata

# 메타데이터 업로드 (바이너리 없이)
fastlane upload_metadata
```

## 릴리즈노트 작성

### 옵션 1: 기본값 (파라미터 없이)
```bash
fastlane release
# → "안정성을 개선하였어요." (한국어)
# → "Improved stability and performance." (영어)
```

### 옵션 2: 직접 지정
```bash
fastlane release notes:"새로운 AI 플래너 기능이 추가되었어요!"
```

### 옵션 3: 파일로 작성 (다국어 지원)

`fastlane/release_notes.txt` 파일 생성:
```
[ko]
새로운 기능이 추가되었어요!
- AI 플래너 기능
- 복습 알림 개선

[en-US]
New features added!
- AI Planner feature
- Improved review notifications
```

배포 후 파일은 자동 삭제됩니다.

### 옵션 4: AI가 자동 생성 (Claude Code 연동)

Claude Code에서 배포 요청 시:
```
"최근 커밋 내용을 분석해서 사용자 친화적인 릴리즈노트를 작성하고 배포해줘"
```

Claude가 다음을 수행:
1. `git log`로 최근 변경사항 분석
2. 사용자 관점의 릴리즈노트 작성
3. `fastlane/release_notes.txt`에 저장
4. `fastlane release` 실행

### 수동 설정 (선택)

1. **템플릿 복사**
   ```bash
   cp ~/rele/skills/ios-fastlane-deploy/assets/Fastfile.template ./fastlane/Fastfile
   cp ~/rele/skills/ios-fastlane-deploy/assets/Appfile.template ./fastlane/Appfile
   cp ~/rele/skills/ios-fastlane-deploy/assets/ExportOptions.plist ./fastlane/
   ```

2. **설정 수정**
   - `Appfile`: Bundle ID, Apple ID, Team ID 입력
   - `Fastfile`: PROJECT, SCHEME, MAJOR_VERSION 수정

3. **API 키 설정**
   - App Store Connect → Users and Access → Keys
   - .p8 파일 다운로드 → `fastlane/AuthKey_XXXXX.p8`
   - Fastfile에 key_id, issuer_id 입력

## 선행 조건

### 필수
- Xcode 설치
- Fastlane 설치 (`gem install fastlane`)
- Apple Developer 계정
- App Store Connect API 키 (권장)

### 권장
- Git 저장소 (변경사항 추적)
- Automatic Signing 설정

## 문제 해결

### API 키 인증 오류
```
undefined method 'app_store_connect_api_key'
```
→ `app_store_connect_api_key`는 **Fastfile**에서만 사용 (Appfile ❌)

### 빌드 실패
```bash
# 의존성 업데이트
xcodebuild -resolvePackageDependencies

# DerivedData 삭제
rm -rf ~/Library/Developer/Xcode/DerivedData
```

### 버전 충돌
```
This build already exists
```
→ 같은 빌드 번호로 재업로드 시 발생. 자동 버전 관리 사용 시 발생하지 않음.

### 위젯 미포함
```bash
# IPA 확인
unzip -l ./build/App.ipa | grep -i widget
```
→ scheme에 위젯 Extension이 포함되어 있는지 확인

## 검증

배포 전 검증 스크립트 실행:
```bash
./scripts/validate.sh /path/to/project ProjectName
```

## 참고 자료

- [Fastlane 공식 문서](https://docs.fastlane.tools)
- [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi)
- [Xcode 빌드 가이드](https://developer.apple.com/documentation/xcode)
