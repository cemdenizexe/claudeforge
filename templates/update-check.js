#!/usr/bin/env node
/**
 * update-check.js — SessionStart hook
 * Checks GitHub for new ClaudeForge version weekly.
 * Zero cost if no update. Minimal network call.
 */
const https = require('https');
const fs = require('fs');
const path = require('path');

const VERSION_FILE = path.join(process.env.USERPROFILE || process.env.HOME, '.claude', '.claudeforge-version');
const REPO = 'cemdenizexe/claudeforge';
const CHECK_INTERVAL = 7 * 24 * 60 * 60 * 1000; // 7 days

// Check if we should check (throttle)
let lastCheck = 0;
try {
    const data = JSON.parse(fs.readFileSync(VERSION_FILE, 'utf8'));
    lastCheck = data.lastCheck || 0;
} catch (e) { /* first run */ }

if (Date.now() - lastCheck < CHECK_INTERVAL) {
    process.exit(0); // Too soon, skip
}

// Fetch latest commit SHA from GitHub API
const options = {
    hostname: 'api.github.com',
    path: `/repos/${REPO}/commits/main`,
    headers: { 'User-Agent': 'ClaudeForge-UpdateCheck' },
    timeout: 3000
};

const req = https.get(options, (res) => {
    let body = '';
    res.on('data', chunk => body += chunk);
    res.on('end', () => {
        try {
            const data = JSON.parse(body);
            const remoteSha = data.sha ? data.sha.substring(0, 7) : null;
            const remoteMsg = data.commit ? data.commit.message.split('\n')[0] : '';
            const remoteDate = data.commit ? data.commit.committer.date.split('T')[0] : '';
            
            // Read local version
            let localSha = '';
            try {
                const vData = JSON.parse(fs.readFileSync(VERSION_FILE, 'utf8'));
                localSha = vData.sha || '';
            } catch (e) { /* first run */ }
            
            // Save check timestamp + current sha
            fs.writeFileSync(VERSION_FILE, JSON.stringify({
                lastCheck: Date.now(),
                sha: remoteSha,
                localSha: localSha || remoteSha
            }));
            
            // Alert if different
            if (localSha && remoteSha && localSha !== remoteSha) {
                console.log(`[ ClaudeForge Update Available ]`);
                console.log(`  ${remoteDate}: ${remoteMsg}`);
                console.log(`  Run: cd ~/.claude && git clone --depth 1 https://github.com/${REPO}.git cf-update && powershell -File cf-update/scripts/setup.ps1`);
            }
        } catch (e) { /* ignore parse errors */ }
    });
});

req.on('error', () => process.exit(0)); // Network fail = silent skip
req.on('timeout', () => { req.destroy(); process.exit(0); });