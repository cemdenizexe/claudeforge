#!/usr/bin/env node
/**
 * self-learning.js — PostToolUse hook (Bash)
 * Logs: errors, fix commits, env quirks, "NEVER/ALWAYS" rules
 * Writes: [project]/.claude/learnings.md
 * Read by: session-start.js at every session open
 */

const fs = require('fs');
const path = require('path');

const ENV = (() => {
    if (process.env.WSL_DISTRO_NAME || fs.existsSync('/proc/sys/fs/binfmt_misc/WSLInterop')) return 'WSL';
    if (process.platform === 'win32') return 'Windows';
    return 'Unix';
})();

const LEARNINGS_PATH = path.join(process.cwd(), '.claude', 'learnings.md');

function ensureFile() {
    const dir = path.dirname(LEARNINGS_PATH);
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    if (!fs.existsSync(LEARNINGS_PATH)) {
        fs.writeFileSync(LEARNINGS_PATH,
            '# Project Learnings (auto-generated)\n' +
            '> Auto-logged by self-learning hook. Read at session start.\n\n' +
            '## Errors\n\n## Bug Fixes\n\n## Env Notes\n\n## Rules\n'
        );
    }
}

function alreadyLogged(snippet) {
    if (!fs.existsSync(LEARNINGS_PATH)) return false;
    return fs.readFileSync(LEARNINGS_PATH, 'utf8').includes(snippet);
}

function appendUnder(section, entry) {
    ensureFile();
    const snippet = entry.slice(0, 60);
    if (alreadyLogged(snippet)) return;
    let content = fs.readFileSync(LEARNINGS_PATH, 'utf8');
    const marker = `## ${section}`;
    if (content.includes(marker)) {
        content = content.replace(marker, `${marker}\n${entry}`);
    } else {
        content += `\n## ${section}\n${entry}\n`;
    }
    fs.writeFileSync(LEARNINGS_PATH, content, 'utf8');
}

const date = new Date().toISOString().split('T')[0];

// ENV-aware error patterns
const ENV_PATTERNS = [
    { re: /command not found|not recognized/, tag: 'CMD_NOT_FOUND' },
    { re: /PATH.*not included|not in PATH/, tag: 'PATH_ISSUE' },
    { re: /pip3.*not found/, tag: 'PIP3_MISSING', fix: 'Use python3 -m pip' },
    { re: /permission denied/i, tag: 'PERM_DENIED' },
    { re: /execution policy/i, tag: 'EXEC_POLICY', fix: 'Set-ExecutionPolicy Bypass -Scope Process' },
    { re: /ENOENT/, tag: 'FILE_NOT_FOUND' },
    { re: /cannot find module/i, tag: 'MODULE_NOT_FOUND' },
    { re: /address already in use/i, tag: 'PORT_IN_USE' },
    { re: /ssl.*certificate/i, tag: 'SSL_ERROR' },
];

let input = '';
process.stdin.on('data', c => input += c);
process.stdin.on('end', () => {
    try {
        const data = JSON.parse(input);
        const toolName = data.tool_name || '';
        const toolInput = data.tool_input || {};
        const output = data.tool_output || {};

        if (toolName !== 'Bash') process.exit(0);

        const command = (toolInput.command || '').slice(0, 120);
        const stderr  = (typeof output === 'object' ? output.stderr : '') || '';
        const stdout  = (typeof output === 'object' ? output.stdout : String(output)) || '';
        const exitCode = typeof output === 'object' ? output.exit_code : null;
        const allOutput = (stderr + '\n' + stdout).slice(0, 400);

        // 1. Error logging
        if (exitCode && exitCode !== 0 && (stderr || stdout)) {
            for (const p of ENV_PATTERNS) {
                if (p.re.test(allOutput)) {
                    const fix = p.fix ? ` | fix: ${p.fix}` : '';
                    appendUnder('Errors',
                        `- [${date}] [${ENV}] [${p.tag}] \`${command.slice(0,80)}\`${fix}\n` +
                        `  > ${stderr.split('\n')[0].slice(0,120)}`
                    );
                    break;
                }
            }
            // Generic error fallback
            if (stderr && !ENV_PATTERNS.some(p => p.re.test(allOutput))) {
                appendUnder('Errors',
                    `- [${date}] [${ENV}] exit:${exitCode} \`${command.slice(0,80)}\`\n` +
                    `  > ${stderr.split('\n')[0].slice(0,120)}`
                );
            }
        }

        // 2. Fix commit logging
        if (command.match(/^(rtk\s+)?git\s+commit/) && command.match(/-m\s+["']/)) {
            const m = command.match(/-m\s+["']([^"']+)["']/);
            if (m && m[1].match(/^(fix|bugfix|hotfix)/i)) {
                appendUnder('Bug Fixes', `- [${date}] [${ENV}] ${m[1]}`);
            }
        }

        // 3. NEVER/ALWAYS rules from stdout
        const ruleMatch = allOutput.match(/\b(NEVER|ALWAYS)\b.{10,100}/gi);
        if (ruleMatch) {
            for (const rule of ruleMatch.slice(0, 3)) {
                appendUnder('Rules', `- [${date}] [${ENV}] ${rule.trim().slice(0, 120)}`);
            }
        }

        process.exit(0);
    } catch (e) {
        process.exit(0);
    }
});
