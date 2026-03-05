# rele

개인 사이드 프로젝트를 위한 Skills 마켓플레이스

## 설치 방법

### 방법 1: Plugin Marketplace로 설치 (권장)

```bash
# Claude Code에서 마켓플레이스 추가
/plugin marketplace add youkchansim/rele

# 플러그인 설치
/plugin install ios-fastlane-deploy@rele
```

### 방법 2: 직접 스킬 복사

개인 스킬로 설치 (모든 프로젝트에서 사용):
```bash
cp -r ~/rele/ios-fastlane-deploy ~/.claude/skills/
```

프로젝트 스킬로 설치 (팀 공유):
```bash
cp -r ~/rele/ios-fastlane-deploy ./.claude/skills/
git add .claude/skills/ios-fastlane-deploy
git commit -m "Add ios-fastlane-deploy skill"
```

## 플러그인 (마켓플레이스 등록 5개)

| 플러그인 | 설명 |
|---------|------|
| [ios-fastlane-deploy](./ios-fastlane-deploy) | iOS 앱 자동 배포 (App Store, TestFlight) |
| [android-fastlane-deploy](./android-fastlane-deploy) | Android 앱 자동 배포 (Google Play) |
| [product-analytics-architect](./product-analytics-architect) | 분석 이벤트 설계 및 코드 생성 (Firebase + Amplitude) |
| [design-pattern-architect](./design-pattern-architect) | 디자인 패턴 분석 및 추천 (과잉 설계 방지) |
| [product-team](./product-team) | 가상 제품팀 (6명 에이전트 협업) |

## 독립 스킬 (마켓플레이스 미등록 2개)

| 스킬 | 설명 |
|------|------|
| [ios-android-bridge](./ios-android-bridge) | iOS → Android 코드 변환 |
| [claude-md-manager](./claude-md-manager) | CLAUDE.md 최적화 및 관리 |

## product-team 상세 (v1.4.0)

가상 제품팀 플러그인으로, 6명의 에이전트가 협업하여 제품 기획부터 출시까지 지원합니다.

### 에이전트 (6명)

| 에이전트 | 역할 | 모델 |
|---------|------|------|
| PO-A (데이터 기반) | 데이터 중심 의사결정 | Opus |
| PO-B (직관 기반) | 직관 중심 의사결정 | Opus |
| App Designer | 앱 디자인 | Opus |
| iOS Developer | iOS 개발 | Opus |
| Data Analyst | 데이터 분석 | Sonnet |
| Marketer | 마케팅 전략 | Sonnet |

### 커맨드 (8개)

| 커맨드 | 설명 |
|--------|------|
| `/ask-po` | PO 의견 빠른 수집 |
| `/po-debate` | PO 3라운드 구조적 토론 |
| `/feature-review` | 6명 다각도 Go/No-Go 리뷰 |
| `/hypothesis-test` | 가설 검증 계획 수립 |
| `/design-handoff` | 디자인→개발 핸드오프 문서 |
| `/growth-audit` | AARRR 펀넬 성장 기회 분석 |
| `/team-sprint` | 팀 스프린트 계획 |
| `/product-pipeline` | 아이디어→출시까지 전체 파이프라인 |

### 스킬 (9개)

| 스킬 | 설명 |
|------|------|
| apple-latest-apis | 최신 Apple API 활용 |
| competitor-analysis | 경쟁사 분석 |
| decision-log | 의사결정 기록 (ADR) |
| design-system-ios | iOS 디자인 시스템 |
| event-taxonomy | 분석 이벤트 분류 체계 |
| hypothesis-framework | 가설 프레임워크 |
| sprint-planning | 스프린트 계획 |
| user-data-analysis | 사용자 데이터 분석 |
| viral-feature-finder | 바이럴 기능 탐색 |

## 라이선스

MIT
