#!/usr/bin/env node
/**
 * skill-discovery.js — SessionStart hook
 * Auto-scans .claude/skills/ for new/removed skills
 * Outputs discovered skills so Claude knows what's available
 * No manual CLAUDE.md editing needed for new skills
 */

const fs = require('fs');
const path = require('path');

const homeDir = process.env.HOME || process.env.USERPROFILE;
const globalSkills = path.join(homeDir, '.claude', 'skills');
const projectSkills = path.join(process.cwd(), '.claude', 'skills');

function scanSkills(dir) {
    if (!fs.existsSync(dir)) return [];
    const skills = [];
    try {
        const entries = fs.readdirSync(dir, { withFileTypes: true });
        for (const entry of entries) {
            const skillPath = path.join(dir, entry.name);
            // Check for SKILL.md in the directory
            const skillMd = entry.isDirectory() 
                ? path.join(skillPath, 'SKILL.md')
                : null;
            
            if (entry.isFile() && entry.name.endsWith('.md') && entry.name !== 'ecosystem-awareness.md') {
                skills.push({ name: entry.name.replace('.md', ''), type: 'file' });
            } else if (entry.isDirectory() && !entry.name.startsWith('.') && !entry.name.startsWith('gsd-') && !entry.name.startsWith('gstack-')) {
                // Skip GSD (too many, already known)
                const readme = path.join(skillPath, 'README.md');
                const skillFile = path.join(skillPath, 'SKILL.md');
                let desc = '';
                
                // Try to extract one-line description
                for (const f of [skillFile, readme]) {
                    if (fs.existsSync(f)) {
                        const content = fs.readFileSync(f, 'utf8');
                        const firstLine = content.split('\n').find(l => l.trim() && !l.startsWith('#') && !l.startsWith('-'));
                        if (firstLine) { desc = firstLine.trim().substring(0, 80); break; }
                    }
                }
                skills.push({ name: entry.name, type: 'dir', desc });
            }
        }
    } catch (e) { /* ignore permission errors */ }
    return skills;
}

const global = scanSkills(globalSkills);
const project = scanSkills(projectSkills);
const allSkills = [...new Map([...global, ...project].map(s => [s.name, s])).values()];

if (allSkills.length > 0) {
    console.log('[ Available Skills ]');
    // Group: known tools vs custom
    const known = allSkills.filter(s => ['caveman-skill','claude-seo','claude-youtube','marketingskills','seedance2-skill','superpowers'].includes(s.name));
    const custom = allSkills.filter(s => !['caveman-skill','claude-seo','claude-youtube','marketingskills','seedance2-skill','superpowers'].includes(s.name) && s.type === 'dir');
    const builtins = allSkills.filter(s => s.type === 'file');
    
    if (known.length) console.log(`  Core: ${known.map(s => s.name).join(', ')}`);
    if (builtins.length) console.log(`  Builtins: ${builtins.map(s => s.name).join(', ')}`);
    if (custom.length) console.log(`  Custom: ${custom.map(s => s.name).join(', ')}`);
    console.log(`  Total: ${allSkills.length} skills (+ 70 GSD + plugin bundles)`);
}