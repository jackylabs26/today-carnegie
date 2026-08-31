#!/bin/bash
# 변경사항을 carnegie.jackyailabs.com 으로 반영
set -e
cd "$(dirname "$0")"

echo "▶ 1/5  샌드박스가 남긴 git 잠금 파일 정리"
find .git -name '*.lock' -delete 2>/dev/null || true
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true

echo "▶ 2/5  변경사항 커밋"
git add -A
if git diff --cached --quiet; then
  echo "   (커밋할 변경사항 없음)"
else
  git commit -m "${1:-콘텐츠 업데이트}"
fi

echo "▶ 3/5  원격 변경사항 가져오기"
git fetch origin main
if ! git merge-base --is-ancestor origin/main HEAD; then
  echo "   원격에 새 커밋이 있어 병합합니다"
  git merge --no-edit origin/main || {
    echo
    echo "   ⚠ 병합 충돌이 발생했습니다. 충돌 파일을 정리한 뒤"
    echo "     git add -A && git commit && git push 를 실행하세요."
    exit 1
  }
fi

echo "▶ 4/5  push"
git push origin main

echo "▶ 5/5  반영 확인"
echo "   커밋: $(git rev-parse --short HEAD)"
echo "   index.html: $(wc -c < index.html) bytes"
echo
echo "1~2분 뒤 반영됩니다:  https://carnegie.jackyailabs.com/"
echo "   (캐시가 남아 있으면 주소 뒤에 ?v=2 를 붙여 확인하세요)"
