#!/bin/bash
# 사용자 도메인(carnegie.jackyailabs.com) 연결
set -e
cd "$(dirname "$0")"
REPO=jackylabs26/today-carnegie
DOMAIN=carnegie.jackyailabs.com

echo "▶ 1/4  git 잠금 파일 정리"
find .git -name '*.lock' -delete 2>/dev/null || true
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true

echo "▶ 2/4  CNAME + 갱신된 index.html 커밋 & 푸시"
git add -A
git diff --cached --quiet || git commit -m "커스텀 도메인 $DOMAIN 연결"
git push

echo "▶ 3/4  DNS 확인"
if command -v dig >/dev/null; then
  dig +short CNAME "$DOMAIN" | grep -q . \
    && echo "   CNAME 응답 OK: $(dig +short CNAME "$DOMAIN")" \
    || echo "   ⚠ CNAME 응답 없음 — DNS 등록 후 다시 실행하세요"
fi

echo "▶ 4/4  GitHub Pages 커스텀 도메인 + HTTPS 설정"
gh api -X PUT "repos/$REPO/pages" -f cname="$DOMAIN" || true
sleep 5
gh api -X PUT "repos/$REPO/pages" -F https_enforced=true \
  || echo "   (인증서 발급 전입니다. 몇 분 뒤 이 스크립트를 다시 실행하거나 Settings > Pages 에서 Enforce HTTPS 를 켜세요)"

echo
echo "완료.  https://$DOMAIN/"
