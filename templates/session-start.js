#!/usr/bin/env node
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const project = path.basename(process.cwd());

// ClaudeForge banner
console.log('');
console.log('  ⚒️  ClaudeForge active');

// Count installed skills
const homeDir = process.env.HOME || process.env.USERPROFILE;
const skillsDir = path.join(homeDir, '.claude', 'skills');
const hooksDir = path.join(homeDir, '.claude', 'hooks');
let skillCount = 0;
let hookCount = 0;
try {
    skillCount = fs.readdirSync(skillsDir).filter(f => !f.startsWith('.')).length;
} catch(e) {}
try {
    hookCount = fs.readdirSync(hooksDir).filter(f => f.endsWith('.js') || f.endsWith('.py') || f.endsWith('.sh')).length;
} catch(e) {}

// Check key components
const hasGSD = fs.existsSync(path.join(skillsDir, 'gsd-plan-phase'));
const hasCaveman = fs.existsSync(path.join(skillsDir, 'caveman-skill'));
const hasSEO = fs.existsSync(path.join(skillsDir, 'claude-seo'));
const hasLearnings = fs.existsSync(path.join(process.cwd(), '.claude', 'learnings.md'));

let components = [];
if (hasGSD) components.push('GSD');
if (hasCaveman) components.push('Caveman');
if (hasSEO) components.push('SEO');
components.push(skillCount + ' skills');
components.push(hookCount + ' hooks');

console.log('  ' + components.join(' | '));
console.log('  Tips: $caveman=tokens | codeburn optimize=health | git clone skill=auto-detect');
console.log('');

// Git info
try {
    const branch = execSync('git branch --show-current 2>nul', { encoding: 'utf8' }).trim();
    const status = execSync('git status --short 2>nul', { encoding: 'utf8' }).trim();
    const log = execSync('git log --oneline -3 2>nul', { encoding: 'utf8' }).trim();
    console.log('  Project: ' + project + ' [' + branch + ']');
    if (status) console.log('  Changes: ' + status.split('\n').length + ' files');
    if (log) console.log('  Recent: ' + log.split('\n')[0]);
} catch(e) {
    console.log('  Project: ' + project + ' [no git]');
}

// Learnings
if (hasLearnings) {
    try {
        const lines = fs.readFileSync(path.join(process.cwd(), '.claude', 'learnings.md'), 'utf8')
            .split('\n').filter(l => l.startsWith('- [')).slice(-3);
        if (lines.length) {
            console.log('  Learnings: ' + lines.length + ' entries');
        }
    } catch(e) {}
}

console.log('');