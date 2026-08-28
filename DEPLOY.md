# 배포 명령어

맥 터미널(실제 셸)에서 아래를 그대로 붙여넣으세요.

## A. GitHub Pages

```bash
cd ~/project/today-carnegie
gh repo create today-carnegie --public --source=. --push
gh api -X POST "repos/$(gh api user -q .login)/today-carnegie/pages" \
  -f "source[branch]=main" -f "source[path]=/"
echo "https://$(gh api user -q .login).github.io/today-carnegie/"
```

`gh` 가 없으면: `brew install gh && gh auth login`

## B. Vercel

```bash
cd ~/project/today-carnegie
npx vercel --prod --yes --name today-carnegie
```

로그인이 안 돼 있으면 `npx vercel login` 을 먼저 실행합니다.

## 배포 후

확정된 주소를 알려주시면 `index.html` 상단의 아래 3곳을 그 주소로 맞춰 드립니다.
(카톡 링크 미리보기 이미지가 뜨려면 절대 주소여야 합니다)

- `<link rel="canonical" href="...">`
- `<meta property="og:url" content="...">`
- `<meta property="og:image" content=".../og.png">`
