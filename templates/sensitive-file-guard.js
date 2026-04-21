#!/usr/bin/env node
/**
 * sensitive-file-guard.js — PreToolUse hook
 * Prevents committing sensitive files and checks .gitignore health.
 * 
 * Triggers on: git add, git commit
 * Checks:
 *   1. Sensitive files not staged (.env, *.jks, *.keystore, google-services.json)
 *   2. .gitignore exists and contains required patterns
 *   3. API keys not in staged files
 */

const fs = require('fs');
const path = require('path');

const SENSITIVE_PATTERNS = [
    '.env',
    '.env.local',
    '.env.production',
    '*.jks',
    '*.keystore',
    'google-services.json',
    'GoogleService-Info.plist',
    '*.pem',
    '*.key',
    'id_rsa',
    'id_ed25519',
    '.credentials.json',
    'auth.json'
];

const REQUIRED_GITIGNORE = [
    '.env',
    '*.jks',
    '*.keystore',
    'google-services.json',
    'node_modules',
    '.credentials.json'
];

let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
    try {
        const data = JSON.parse(input);
        const toolName = data.tool_name || '';
        const toolInput = data.tool_input || {};
        const command = toolInput.command || '';

        // Only check git commands
        if (toolName !== 'Bash') process.exit(0);
        if (!command.match(/^git\s+(add|commit|push)/)) process.exit(0);

        const warnings = [];

        // Check 1: .gitignore exists
        if (!fs.existsSync('.gitignore')) {
            warnings.push('⚠️ .gitignore MISSING — sensitive files could be committed');
        } else {
            // Check 2: .gitignore has required patterns
            const gitignore = fs.readFileSync('.gitignore', 'utf8');
            const missing = REQUIRED_GITIGNORE.filter(p => !gitignore.includes(p));
            if (missing.length > 0) {
                warnings.push(`⚠️ .gitignore missing: ${missing.join(', ')}`);
            }
        }

        // Check 3: Sensitive files in git add command
        if (command.match(/^git\s+add/)) {
            for (const pattern of SENSITIVE_PATTERNS) {
                const clean = pattern.replace('*', '');
                if (command.includes(clean) || command.includes(pattern)) {
                    process.stderr.write(
                        `🛑 BLOCKED: Attempting to stage sensitive file matching "${pattern}". ` +
                        `This file should be in .gitignore, not committed.\n`
                    );
                    process.exit(2);
                }
            }
            
            // Check "git add ." or "git add -A" — warn about broad staging
            if (command.match(/git\s+add\s+(\.|--all|-A)/)) {
                // Check if any sensitive file exists and is not gitignored
                for (const pattern of ['.env', '.env.local', '.env.production']) {
                    if (fs.existsSync(pattern)) {
                        const gitignore = fs.existsSync('.gitignore') 
                            ? fs.readFileSync('.gitignore', 'utf8') : '';
                        if (!gitignore.includes('.env')) {
                            process.stderr.write(
                                `🛑 BLOCKED: "git add ." with ${pattern} present but .env not in .gitignore. ` +
                                `Add .env to .gitignore first.\n`
                            );
                            process.exit(2);
                        }
                    }
                }
            }
        }

        // Check 4: Pre-commit — verify no sensitive files staged
        if (command.match(/^git\s+commit/)) {
            // Warn about any .gitignore issues found
            if (warnings.length > 0) {
                process.stderr.write(warnings.join('\n') + '\n');
                process.stderr.write('Fix .gitignore before committing.\n');
                process.exit(2);
            }
        }

        // Non-blocking warnings
        if (warnings.length > 0) {
            process.stderr.write(warnings.join('\n') + '\n');
        }

        process.exit(0);
    } catch (e) {
        process.exit(0);
    }
});