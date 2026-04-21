#!/usr/bin/env node
/**
 * session-start.js — SessionStart hook (Windows compatible)
 * Replaces bash-based session start that fails on Windows
 */
const { execSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const project = path.basename(process.cwd());

console.log('=== SESSION START ===');
console.log('[ Project ]', project);

try {
    const branch = execSync('git branch --show-current 2>nul', { encoding: 'utf8' }).trim();
    console.log('[ Git ]', branch);
    const status = execSync('git status --short 2>nul', { encoding: 'utf8' }).trim();
    if (status) console.log(status.split('\n').slice(0, 8).join('\n'));
    const log = execSync('git log --oneline -5 2>nul', { encoding: 'utf8' }).trim();
    console.log('[ Recent commits ]');
    console.log(log);
} catch (e) {
    console.log('[ Git ] not initialized');
}

const learningsPath = path.join(process.cwd(), '.claude', 'learnings.md');
if (fs.existsSync(learningsPath)) {
    const lines = fs.readFileSync(learningsPath, 'utf8').split('\n');
    console.log('[ Learnings ]');
    console.log(lines.slice(-10).join('\n'));
}

console.log('=== READY ===');