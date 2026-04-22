#!/usr/bin/env node
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const project = path.basename(process.cwd());
const homeDir = process.env.HOME || process.env.USERPROFILE;
const skillsDir = path.join(homeDir, '.claude', 'skills');
const hooksDir  = path.join(homeDir, '.claude', 'hooks');
const gsdState  = path.join(homeDir, '.gsd', 'state.json');
const learnings = path.join(process.cwd(), '.claude', 'learnings.md');
const bootstrapFile = path.join(process.cwd(), '.claude', 'bootstrap-prompt.txt');
const onboardedFlag = path.join(homeDir, '.claude', '.onboarded');

let skillCount = 0, hookCount = 0;
try { skillCount = fs.readdirSync(skillsDir).filter(f => !f.startsWith('.')).length; } catch(e) {}
try { hookCount  = fs.readdirSync(hooksDir).filter(f => /\.(js|py|sh)$/.test(f)).length; } catch(e) {}

const hasGSD     = fs.existsSync(path.join(skillsDir, 'gsd-plan-phase'));
const hasCaveman = fs.existsSync(path.join(skillsDir, 'caveman-skill'));
const isFirstRun = !fs.existsSync(onboardedFlag);

let gsdPhase = 'plan', gsdTask = '', gsdSession = 1;
try {
    const s = JSON.parse(fs.readFileSync(gsdState, 'utf8'));
    if (s.current_project === project) {
        gsdPhase = s.current_phase || 'plan';
        gsdTask  = s.active_task   || '';
        gsdSession = s.session_count || 1;
    }
} catch(e) {}

let branch = 'no-git', lastCommit = '', dirty = false;
try {
    branch     = execSync('git branch --show-current 2>nul', { encoding: 'utf8' }).trim();
    lastCommit = execSync('git log --oneline -1 2>nul',      { encoding: 'utf8' }).trim();
    dirty = execSync('git status --short 2>nul', { encoding: 'utf8' }).trim().length > 0;
} catch(e) {}

let recentLearnings = [];
try {
    recentLearnings = fs.readFileSync(learnings, 'utf8')
        .split('\n').filter(l => l.startsWith('- [')).slice(-3);
} catch(e) {}

const bootstrapLines = [
    'Read CLAUDE.md fully.',
    fs.existsSync(learnings) ? 'Read .claude/learnings.md last 10 lines.' : null,
    `GSD state: phase=${gsdPhase}${gsdTask ? ', task=' + gsdTask : ''}`,
    'Run: git status && git log --oneline -5',
    'Report: current phase, active task, exact next action.',
    'No clarifying questions. Start immediately.'
].filter(Boolean).join('\n');

try {
    const claudeDir = path.join(process.cwd(), '.claude');
    if (!fs.existsSync(claudeDir)) fs.mkdirSync(claudeDir, { recursive: true });
    fs.writeFileSync(bootstrapFile, bootstrapLines, 'utf8');
} catch(e) {}

console.log('');
console.log('  ⚒️  ClaudeForge active');
console.log('  ' + [hasGSD?'GSD':null, hasCaveman?'Caveman':null, skillCount+' skills', hookCount+' hooks'].filter(Boolean).join(' | '));
console.log('');

if (isFirstRun) {
    fs.writeFileSync(onboardedFlag, new Date().toISOString());
    console.log('  ╔══════════════════════════════════════════════════╗');
    console.log('  ║  ClaudeForge kuruldu. Ozet:                      ║');
    console.log('  ╚══════════════════════════════════════════════════╝');
    console.log('');
    console.log('  NE YAPABILIRSIN:');
    console.log('  - Kod yaz, test et, deploy et  → GSD workflow');
    console.log('  - Token tasarrufu               → $caveman');
    console.log('  - Guvenlik taramasi             → otomatik (her edit)');
    console.log('  - Web scraping                  → "Scrape https://..."');
    console.log('  - PR review                     → /code-review');
    console.log('  - Yeni skill yarat              → "Create a skill for..."');
    console.log('  - Multi-dosya paralel           → swarm otomatik');
    console.log('');
    console.log('  BASLANGIC KOMUTLARI:');
    console.log('  npx codeburn     → token kullanim dashboard');
    console.log('  $caveman         → token tasarrufu ac');
    console.log('  /compact         → context sikistir');
    console.log('  /model           → model degistir (haiku/sonnet/opus)');
    console.log('  gsd plan         → sprint planla');
    console.log('');
    console.log('  CONTEXT TAKIP:');
    console.log('  claude-mem       → otomatik, localhost:37777');
    console.log('  npx codeburn     → manuel dashboard');
    console.log('  /context         → anlik % goster');
    console.log('');
    console.log('  YENI PROJEYE EKLE:');
    console.log('  .\\sync-skills.ps1 calistir → tum projelere dagitir');
    console.log('');
    console.log('  CLAUDE DESKTOP:');
    console.log('  claude.ai → Projects → Instructions → CLAUDE.md yapistir');
    console.log('  veya Desktop Commander MCP ile otomatik okur.');
    console.log('');
    console.log('  ─────────────────────────────────────────────────');
} else {
    console.log('  Project : ' + project + ' [' + branch + ']' + (dirty ? ' ! dirty' : ' ok'));
    console.log('  Session : #' + gsdSession + '  GSD: ' + gsdPhase + (gsdTask ? ' > ' + gsdTask : ''));
    if (lastCommit) console.log('  Last    : ' + lastCommit);
    if (recentLearnings.length) console.log('  Learned : ' + recentLearnings.length + ' entries');
    console.log('');
}

console.log('  Bootstrap:');
console.log('  ' + bootstrapLines.split('\n').join('\n  '));
console.log('');
