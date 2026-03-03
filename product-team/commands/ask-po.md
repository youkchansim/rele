---
description: PO A/B에게 아이디어에 대한 빠른 의견을 구합니다
argument-hint: 의견이 필요한 아이디어 (예: "위젯 추가", "온보딩 개선")
---

# Ask PO

PO A (Data-Driven)와 PO B (Intuitive)에게 아이디어에 대한 빠른 의견을 구합니다.

**Topic**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("ask-po")`
2. Spawn both PO agents **simultaneously** via Agent tool with `team_name: "ask-po"`:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
3. Create tasks:

```
TaskCreate: "PO-A 데이터 관점 의견" — PO-A가 데이터/비즈니스 관점에서 의견 제시
TaskCreate: "PO-B 사용자 관점 의견" — PO-B가 사용자/시장 관점에서 의견 제시
TaskCreate: "Lead 의견 요약" — Lead가 양쪽 의견 정리 (blockedBy: [1, 2])
```

Assign Task 1 to PO-A, Task 2 to PO-B.

---

## Round 1: 의견 수렴 (병렬)

### PO-A Task (SendMessage)
> 다음 아이디어에 대해 데이터/비즈니스 관점에서 간략한 의견을 주세요: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics and North Star
> 2. 비즈니스 임팩트 직감 평가
> 3. ICE 직감 점수 (각 1-10, 근거 한 줄)
> 4. 추천 방향 (추진 / 보류 / 검증 필요)
> 5. 간결하게 (500자 이내)

### PO-B Task (SendMessage)
> 다음 아이디어에 대해 사용자/시장 관점에서 간략한 의견을 주세요: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. 사용자 니즈 적합성 평가
> 3. 경쟁사 참고 (유사 기능이 있는지)
> 4. 추천 방향 (추진 / 보류 / 검증 필요)
> 5. 간결하게 (500자 이내)

---

## 요약

Lead가 PO-A와 PO-B의 의견을 수신하면 (Task 3 시작):

```markdown
# Quick PO Opinion: [Topic]

## PO A (Data) 의견
[요약]
- ICE 직감: I=? C=? E=? (총 ?)
- 추천: [추진/보류/검증 필요]

## PO B (Intuitive) 의견
[요약]
- 추천: [추진/보류/검증 필요]

## 종합
- **공통점**: [양쪽이 동의하는 부분]
- **차이점**: [의견이 갈리는 부분]
- **추천 방향**: [Lead의 종합 판단]
```

---

## 후속 옵션 안내

요약 마지막에 다음 안내를 포함:

> **다음 단계 옵션:**
> - 더 깊이 토론 → `/po-debate "$ARGUMENTS"`
> - 가설화 → `/hypothesis-test "$ARGUMENTS"`
> - 전체 파이프라인 → `/product-pipeline "$ARGUMENTS"`

---

## Cleanup

1. 모든 팀원에게 `shutdown_request` 전송 (SendMessage type: "shutdown_request")
2. `shutdown_response` 확인
3. `TeamDelete` 호출
