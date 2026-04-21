#!/usr/bin/env node
/**
 * self-learning.js — PostToolUse hook
 * Auto-detects bug fixes and architecture decisions, logs them to .claude/learnings.md
 * 
 * Triggers on: Edit, Write (after successful execution)
 * Detects:
 *   - Bug fix patterns in commit messages (fix:, bugfix, hotfix)
 *   - "NEVER" / "ALWAYS" rules Claude states during fixes
 *   - Architecture decisions (chose X over Y)
 * 
 * Writes to: [project]/.claude/learnings.md (separate from CLAUDE.md)
 * Read by: SessionStart hook reads this file for context
 */

const fs = require('fs');
const path = require('path');

let input = '';
process.stdin.on('data', chunk => input += chunk);
process.stdin.on('end', () => {
    try {
        const data = JSON.parse(input);
        const toolName = data.tool_name || '';
        const toolInput = data.tool_input || {};
        const toolOutput = data.tool_output || '';

        // Only process after Bash (git commit) completes
        if (toolName !== 'Bash') process.exit(0);

        const command = toolInput.command || '';
        
        // Detect bug fix commits
        if (command.match(/^git\s+commit/) && command.match(/-m\s+["']/)) {
            const msgMatch = command.match(/-m\s+["']([^"']+)["']/);
            if (!msgMatch) process.exit(0);
            
            const msg = msgMatch[1];
            
            // Only log fix/bugfix/hotfix commits
            if (!msg.match(/^(fix|bugfix|hotfix)/i)) process.exit(0);
            
            const date = new Date().toISOString().split('T')[0];
            const learningEntry = `\n- [${date}] ${msg}`;
            
            const learningsPath = path.join(process.cwd(), '.claude', 'learnings.md');
            const learningsDir = path.dirname(learningsPath);
            
            // Ensure .claude directory exists
            if (!fs.existsSync(learningsDir)) {
                fs.mkdirSync(learningsDir, { recursive: true });
            }
            
            // Create or append to learnings.md
            if (!fs.existsSync(learningsPath)) {
                fs.writeFileSync(learningsPath, 
                    '# Project Learnings (auto-generated)\n' +
                    '> Auto-logged by self-learning hook. Read at session start.\n' +
                    '> Manual entries welcome — add bugs, decisions, "NEVER do X" rules.\n\n' +
                    '## Bug Fixes\n' + learningEntry + '\n'
                );
            } else {
                const content = fs.readFileSync(learningsPath, 'utf8');
                // Prevent duplicates
                if (!content.includes(msg)) {
                    fs.appendFileSync(learningsPath, learningEntry + '\n');
                }
            }
        }
        
        process.exit(0);
    } catch (e) {
        process.exit(0);
    }
});