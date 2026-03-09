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

## 플러그인 (마켓플레이스 등록 3개)

| 플러그인 | 설명 |
|---------|------|
| [ios-fastlane-deploy](./ios-fastlane-deploy) | iOS 앱 빌드 및 App Store/TestFlight 자동 배포 (Fastlane 기반, 인터랙티브 설정 위자드) |
| [android-fastlane-deploy](./android-fastlane-deploy) | Android 앱 빌드 및 Google Play 자동 배포 (Fastlane 기반, 스크린샷 자동화) |
| [product-team](./product-team) | 가상 제품팀 — 6명 에이전트 협업 (PO, 디자이너, 개발자, 분석가, 마케터) |

## 독립 스킬 (마켓플레이스 미등록 1개)

| 스킬 | 설명 |
|------|------|
| [ios-android-bridge](./ios-android-bridge) | iOS (SwiftUI/Swift) → Android (Jetpack Compose/Kotlin) 코드 변환 |

## product-team 상세 (v1.6.0)

가상 제품팀 플러그인으로, 6명의 에이전트가 협업하여 제품 기획부터 출시까지 지원합니다.

### 에이전트 (6명)

| 에이전트 | 역할 | 모델 |
|---------|------|------|
| PO-A (데이터 기반) | 데이터 중심 의사결정, 우선순위 프레임워크 (ICE/RICE/Kano/MoSCoW) | Opus |
| PO-B (직관 기반) | 직관 중심 의사결정, 디스커버리 (OST/Assumption Mapping) | Opus |
| App Designer | 앱 디자인, 디자인 시스템, 스크린샷→SwiftUI 분석 | Opus |
| iOS Developer | iOS 개발, 구현 가능성 평가, 아키텍처 분석 | Opus |
| Data Analyst | 데이터 분석, 퍼널/리텐션/LTV, A/B 테스트 | Sonnet |
| Marketer | 마케팅 전략, ASO, 그로스 루프, Product Hunt | Sonnet |

### 커맨드 (9개)

| 커맨드 | 설명 |
|--------|------|
| `/ask-po` | PO 의견 빠른 수집 |
| `/po-debate` | PO 3라운드 구조적 토론 |
| `/feature-review` | 6명 다각도 Go/No-Go 리뷰 |
| `/growth-audit` | AARRR 펀넬 성장 기회 분석 |
| `/product-pipeline` | 아이디어→출시까지 전체 파이프라인 |
| `/discover` | 제품 기회 발굴 (OST, Assumption Mapping) |
| `/strategy` | Strategy Canvas 기반 제품 전략 수립 |
| `/design-recommend` | 데이터 기반 iOS SwiftUI 디자인 시스템 추천 |
| `/design-from-screenshot` | 레퍼런스 스크린샷 분석 → 디자인 토큰 추출 + SwiftUI 코드 생성 |

### 스킬 (21개)

| 스킬 | 설명 |
|------|------|
| apple-latest-apis | 최신 Apple API (iOS 26, Swift 6.2, Liquid Glass, Foundation Models) |
| competitor-analysis | 경쟁사 분석 및 차별화 기회 탐색 |
| create-prd | PRD 작성 및 리스크 분석 (Pre-mortem) |
| data-visualization | 차트 선택, 대시보드 설계, 시각화 베스트 프랙티스 |
| decision-log | 의사결정 기록 (ADR 형식) |
| design-recommend-ios | iOS 앱 카테고리별 디자인 스타일/색상/타이포 추천 |
| design-system-ios | iOS 디자인 시스템 일관성 감사, HIG 준수 확인 |
| event-taxonomy | 분석 이벤트 분류 체계 설계, 3-Question 필터 |
| hypothesis-framework | ICE 스코어 기반 비즈니스 가설 구조화 |
| market-analysis | 시장 분석 (SWOT, Porter, TAM/SAM/SOM) |
| metrics-tracking | North Star 지표 정의, 메트릭 계층 구조, OKR |
| performance-analytics | 마케팅 채널 성과, ASO, 어트리뷰션 분석 |
| prioritization-frameworks | 기능 우선순위 프레임워크 (RICE, ICE, Kano, MoSCoW) |
| product-discovery | 제품 기회 발굴 (OST, Assumption Mapping, Mom Test) |
| product-strategy | 제품 전략 수립 (Strategy/Lean/Value Proposition Canvas) |
| screenshot-to-swiftui | 스크린샷 분석 → 디자인 토큰 추출 + SwiftUI 코드 |
| sprint-planning | 스프린트 계획, 백로그 정리, 용량 추정 |
| statistical-analysis | A/B 테스트 해석, 이상치 탐지, 통계적 유의성 |
| user-data-analysis | 사용자 행동 데이터, 퍼널, 리텐션, LTV 분석 |
| user-research-synthesis | 사용자 리서치 종합, 테마 분석, 페르소나 구축 |
| viral-feature-finder | 바이럴 루프 설계, K-factor, Build in Public |

## 라이선스

MIT
