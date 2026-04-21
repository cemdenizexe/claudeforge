# 09 — Video Pipeline

## Overview

Fully automated AI video production: research → script → visuals → render → publish.

## Stack

| Stage | Tool | Role |
|-------|------|------|
| Research | Claude + connectors (web search, LunarCrush, MT Newswires) | Topic research, data gathering |
| Script | Claude + Claude SEO + Marketing Skills | SEO-optimized script writing |
| Visuals | Seedance 2.0 via Higgsfield API | AI video clip generation |
| Voiceover | ElevenLabs API or Qwen3-TTS | Text-to-speech |
| Assembly | Remotion (React-based) | Programmatic video rendering |
| Thumbnails | Claude + canvas-design skill | AI thumbnail generation |
| Upload | Playwright | Automated YouTube upload |
| SEO | Claude YouTube skill | Title, description, tags optimization |
| Distribution | n8n workflows | Cross-platform posting |

## Project Setup

```powershell
cd D:\Dev
npx create-video@latest   # Select "prompt-to-video" template
cd ai-video-channel
npm run dev                # Preview at localhost:3000
```

## Rendering

```powershell
npx remotion render src/index.ts MyComposition out/video.mp4
```

## Seedance 2.0 Prompts

The seedance2-skill generates optimized prompts for Higgsfield:
- Camera movements (pan, zoom, orbit)
- Style references (cinematic, anime, documentary)
- Motion intensity control
- Scene transitions

## Content Series: "Vibe Coding Survival Guide"

10-episode series where the pipeline produces itself:

| Ep | Topic | Skills demonstrated |
|----|-------|-------------------|
| 1 | Claude Code basics | /init, /login, first project |
| 2 | Skills system | SKILL.md, Caveman demo |
| 3 | MCP & Connectors | Filesystem access, Supabase |
| 4 | CLAUDE.md engineering | Global vs local, self-learning |
| 5 | Workflow skills | Feature Forge, Spec Miner, The Fool |
| 6 | Security | Vibe coding dangers, real examples |
| 7 | Multi-project | RuFlo swarm, sync scripts |
| 8 | Video pipeline | This pipeline making this video (meta) |
| 9 | Dashboard project | Trade-Bot with connectors live |
| 10 | GitHub repo | Community toolkit launch |