# Video pipeline

## Akış
```
Research (web search + connector'lar)
  → Script (Claude + SEO optimizasyonu)
  → Görsel üretimi (Seedance 2.0 → Higgsfield)
  → Seslendirme (ElevenLabs veya Qwen3-TTS)
  → Video montaj (Remotion — React tabanlı)
  → Upload + SEO (Playwright + YouTube skill)
  → Dağıtım (n8n → sosyal medya)
```

## Kurulum
```powershell
npx create-video@latest   # "prompt-to-video" template seç
cd ai-video-channel
npm run dev                # localhost:3000'de önizleme
```

## Render
```powershell
npx remotion render src/index.ts VideoComp out/video.mp4
```

## Skill'ler
| Skill | Ne yapar |
|-------|---------|
| seedance2-skill | Higgsfield için optimum video prompt'ları |
| claude-seo | Video SEO, meta tag, schema |
| claude-youtube | Kanal audit, script, thumbnail, retention |
| marketingskills | İçerik stratejisi, copywriting |
| playwright | Otomatik YouTube upload |