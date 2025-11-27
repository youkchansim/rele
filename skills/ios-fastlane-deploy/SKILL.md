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

- **App Store 배포**: 빌드 → 업로드 → 심사 제출 자동화
- **TestFlight 베타**: 테스터에게 빠른 배포
- **자동 버전 관리**: ChatGPT 스타일 (`MAJOR.YEAR.MMDDNNN`)
- **위젯 Extension**: 메인 앱과 함께 자동 빌드
- **API 키 인증**: 2FA 없이 안정적인 배포

## 버전 형식

```
MAJOR.YEAR.MMDDNNN
예시: 1.2025.1127001 (2025년 11월 27일 첫 번째 빌드)
      1.2025.1127002 (같은 날 두 번째 빌드)
```

## 사용법

### 배포 명령어

```bash
# App Store 배포 (심사 제출 포함)
fastlane release

# TestFlight 베타 배포
fastlane beta

# 빌드만 (업로드 없이)
fastlane build_only
```

### 새 프로젝트에 적용

1. **Fastlane 초기화**
   ```bash
   cd /path/to/project
   fastlane init
   ```

2. **템플릿 복사**
   - `assets/Fastfile.template` → `fastlane/Fastfile`
   - `assets/Appfile.template` → `fastlane/Appfile`
   - `assets/ExportOptions.plist` → `fastlane/ExportOptions.plist`

3. **설정 수정**
   - `Appfile`: Bundle ID, Apple ID, Team ID 입력
   - `Fastfile`: PROJECT, SCHEME, MAJOR_VERSION 수정

4. **API 키 설정**
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
