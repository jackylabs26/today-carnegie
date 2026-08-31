# 배포 안내

## 현재 구성

| 항목 | 값 |
|---|---|
| 서비스 주소 | https://carnegie.jackyailabs.com/ |
| 저장소 | github.com/jackylabs26/today-carnegie (public) |
| 브랜치 | main / 루트 |
| 호스팅 | GitHub Pages |

## 최초 도메인 연결 (1회)

### 1단계 — DNS 레코드 추가

jackyailabs.com 도메인의 DNS 관리 화면에서:

| Type | Name | Value | TTL |
|---|---|---|---|
| CNAME | carnegie | jackylabs26.github.io | 자동(또는 3600) |

> Value 끝에 점(`.`)을 요구하는 서비스도 있습니다: `jackylabs26.github.io.`
> A 레코드가 아니라 **CNAME** 입니다.

### 2단계 — 스크립트 실행

```bash
~/project/today-carnegie/set-domain.sh
```

CNAME 파일 푸시 → DNS 확인 → GitHub Pages 커스텀 도메인 + HTTPS 설정까지 처리합니다.

인증서 발급에 몇 분 걸리므로 "Enforce HTTPS" 단계가 실패하면
잠시 후 스크립트를 다시 실행하거나 Settings > Pages 에서 직접 체크하세요.

## 이후 콘텐츠 업데이트

```bash
~/project/today-carnegie/push.sh "원칙 9~12 추가"
```

1~2분 뒤 반영됩니다.

## 확인 방법

```bash
dig +short CNAME carnegie.jackyailabs.com     # jackylabs26.github.io 가 나와야 정상
curl -sI https://carnegie.jackyailabs.com/    # 200
```

카톡 링크 미리보기가 옛 이미지로 뜨면 카카오가 캐시를 갖고 있는 것입니다.
시간이 지나면 갱신되며, 급하면 URL 뒤에 `?v=2` 를 붙여 보내면 새로 읽어 갑니다.
