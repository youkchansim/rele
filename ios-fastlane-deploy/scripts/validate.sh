#!/bin/bash
# iOS 배포 전 검증 스크립트
# 사용법: ./validate.sh /path/to/project ProjectName

set -e

PROJECT_ROOT="${1:-.}"
PROJECT_NAME="${2:-App}"

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔍 iOS 배포 검증 시작"
echo "   프로젝트: $PROJECT_NAME"
echo "   경로: $PROJECT_ROOT"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

ERRORS=0

# 1. Xcode 프로젝트 확인
echo "1️⃣  Xcode 프로젝트 확인..."
if [ -d "$PROJECT_ROOT/$PROJECT_NAME.xcodeproj" ]; then
    echo "   ✅ 프로젝트 발견: $PROJECT_NAME.xcodeproj"
else
    echo "   ❌ 프로젝트 없음: $PROJECT_NAME.xcodeproj"
    ERRORS=$((ERRORS + 1))
fi

# 2. Fastlane 설치 확인
echo ""
echo "2️⃣  Fastlane 설치 확인..."
if command -v fastlane &> /dev/null; then
    FASTLANE_VERSION=$(fastlane --version 2>/dev/null | head -1)
    echo "   ✅ Fastlane 설치됨"
else
    echo "   ❌ Fastlane 미설치"
    echo "      설치: gem install fastlane"
    ERRORS=$((ERRORS + 1))
fi

# 3. Fastlane 설정 파일 확인
echo ""
echo "3️⃣  Fastlane 설정 파일 확인..."
if [ -f "$PROJECT_ROOT/fastlane/Fastfile" ]; then
    echo "   ✅ Fastfile 존재"
else
    echo "   ❌ Fastfile 없음"
    ERRORS=$((ERRORS + 1))
fi

if [ -f "$PROJECT_ROOT/fastlane/Appfile" ]; then
    echo "   ✅ Appfile 존재"
else
    echo "   ⚠️  Appfile 없음 (선택)"
fi

# 4. API 키 파일 확인
echo ""
echo "4️⃣  API 키 파일 확인..."
API_KEY_FILES=$(find "$PROJECT_ROOT/fastlane" -name "AuthKey_*.p8" 2>/dev/null | wc -l)
if [ "$API_KEY_FILES" -gt 0 ]; then
    echo "   ✅ API 키 파일 발견 ($API_KEY_FILES개)"
else
    echo "   ⚠️  API 키 파일 없음"
    echo "      App Store Connect에서 다운로드 필요"
fi

# 5. Git 상태 확인
echo ""
echo "5️⃣  Git 상태 확인..."
cd "$PROJECT_ROOT"
if git rev-parse --is-inside-work-tree &> /dev/null; then
    UNCOMMITTED=$(git status --porcelain 2>/dev/null | wc -l)
    if [ "$UNCOMMITTED" -eq 0 ]; then
        echo "   ✅ Git 상태 깨끗함"
    else
        echo "   ⚠️  커밋되지 않은 변경사항: $UNCOMMITTED개"
    fi
else
    echo "   ⚠️  Git 저장소 아님"
fi

# 6. 빌드 테스트 (선택)
echo ""
echo "6️⃣  빌드 가능 여부 확인..."
if [ -d "$PROJECT_ROOT/$PROJECT_NAME.xcodeproj" ]; then
    if xcodebuild -project "$PROJECT_ROOT/$PROJECT_NAME.xcodeproj" \
        -scheme "$PROJECT_NAME" \
        -configuration Release \
        -showBuildSettings &> /dev/null; then
        echo "   ✅ 빌드 설정 유효"
    else
        echo "   ⚠️  빌드 설정 확인 필요"
    fi
fi

# 결과 출력
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
if [ $ERRORS -eq 0 ]; then
    echo "✅ 검증 완료: 배포 준비됨"
else
    echo "❌ 검증 실패: $ERRORS개 오류"
    exit 1
fi
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
