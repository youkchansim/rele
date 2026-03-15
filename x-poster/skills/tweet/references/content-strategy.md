# 콘텐츠 전략 가이드 — Scheduler 앱 X 마케팅

## 앱 포지셔닝

Scheduler는 ADHD 사용자를 위한 AI 기반 일정 관리 앱이다. Apple Intelligence와 HealthKit을 활용하여 개인의 에너지 패턴에 맞는 최적 스케줄을 추천한다.

**핵심 키워드:** ADHD, productivity, AI scheduling, Apple Intelligence, energy management, indie dev, Build in Public

**타겟 오디언스:**
- ADHD/neurodivergent 커뮤니티
- 생산성 도구 매니아
- iOS/Apple 생태계 사용자
- 인디 개발자 커뮤니티

---

## 커밋 → 콘텐츠 매핑 규칙

커밋 메시지의 패턴을 분석하여 적합한 콘텐츠 유형을 자동 선택한다.

### 1. 새 기능 추가 (feat, 구현, 추가)
**콘텐츠 유형:** 제품 쇼케이스
**톤:** 흥분된, 자랑스러운
**구조:** 기능 설명 → 왜 만들었는지 → 사용자 가치
**예시 훅:** "Just shipped:", "New feature drop:", "You asked, I built:"

### 2. 버그 수정 (fix, 수정, 해결)
**콘텐츠 유형:** Build in Public (고난 스토리)
**톤:** 솔직한, 유머러스한
**구조:** 문제 발견 → 삽질 과정 → 해결 → 교훈
**예시 훅:** "Spent 3 hours debugging", "The bug that humbled me", "Sometimes the fix is one line"

### 3. 성능 개선 (개선, 최적화, 리팩토링)
**콘텐츠 유형:** 기술 결정 공유
**톤:** 교육적, 분석적
**구조:** 문제 → 선택지들 → 왜 이걸 선택했는지 → 결과
**예시 훅:** "Why I refactored X to Y", "Performance tip:", "Before vs After:"

### 4. UI/UX 변경 (UI, 디자인, 뷰, View)
**콘텐츠 유형:** 비포/애프터 쇼케이스
**톤:** 시각적, 비교 중심
**구조:** Before → After → 왜 바꿨는지
**예시 훅:** "Small design change, huge impact", "UI glow-up:", "Details matter:"

### 5. AI 관련 (AI, 파싱, 프롬프트, LLM)
**콘텐츠 유형:** Apple Intelligence 인사이트
**톤:** 기술적이면서 접근 가능
**구조:** 기술적 도전 → 해결 방법 → 사용자 경험 변화
**예시 훅:** "On-device AI tip:", "What I learned building with Apple Intelligence:", "AI ≠ magic, here's what it actually takes:"

### 6. HealthKit 관련 (HealthKit, 건강, 에너지, 수면)
**콘텐츠 유형:** ADHD/에너지 인사이트
**톤:** 공감적, 인사이트 중심
**구조:** ADHD 관련 관찰 → 데이터로 검증 → 앱이 어떻게 도움
**예시 훅:** "Your body knows your schedule", "ADHD + data =", "Energy tracking changed everything:"

### 7. 다수 커밋 (주간 종합)
**콘텐츠 유형:** Build in Public 주간 로그
**톤:** 요약적, 투명한
**구조:** 이번 주 한 일 → 숫자들 → 다음 주 계획
**예시 훅:** "Week X building in public:", "This week's indie dev log:", "7 days of shipping:"

---

## 콘텐츠 카테고리 상세

### BIP (Build in Public)
- 개발 과정의 투명한 공유
- 실패와 성공 모두 포함
- 숫자와 구체적 사실 강조
- 커뮤니티 연결감 형성

### Showcase (제품 쇼케이스)
- 구체적 기능 하나에 집중
- 사용자 관점의 가치 강조
- 가능하면 스크린샷/영상 언급
- 직접적 CTA 피하기 (관심 유도만)

### Insight (ADHD/생산성 인사이트)
- 개인 경험 기반
- 데이터로 뒷받침
- ADHD 커뮤니티 공감 유발
- 앱 자체보다 인사이트에 집중

### Tech (기술 결정 공유)
- 개발자 대상
- 구체적 기술 선택 이유
- 코드 스니펫 또는 아키텍처 결정
- 교육적 가치 제공

---

## X 알고리즘 최적화 규칙 (viral-content-writer 에이전트 기반)

### 가중치
- 리플: ×13.5
- RT: ×20
- 프로필 클릭: ×12
- 북마크: ×10
- 원작자 답변: ×75

### 최적화 전략
1. **길이:** 71-100자 최적 (또는 스레드 4-8개)
2. **리플 유도:** 항상 질문으로 끝내기
3. **해시태그:** 1-2개만 (3개+ = 스팸)
4. **외부 링크:** 최소화 (알고리즘 억제)
5. **미디어:** 이미지 ×2-3, 영상 ×10 참여도
6. **첫 트윗:** 충격적 숫자나 대담한 주장

### 포스팅 시간 (KST)
- **최적:** 수요일 오후 11시 (미국 동부 오전)
- **차선:** 화/목 오후 10시~자정

### 금지 사항
- 외부 링크 남발
- 해시태그 3개 이상
- "Buy my app" 직접적 판매 어조
- 다른 트윗 복사/변형
