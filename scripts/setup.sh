#!/bin/bash
# ============================================================
# ClaudeForge setup.sh — macOS / Linux / WSL
# https://github.com/cemdenizexe/claudeforge
# ============================================================
set -e

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; DIM='\033[2m'; NC='\033[0m'
ok()  { echo -e "  ${GREEN}$1${NC}"; }
dim() { echo -e "  ${DIM}$1${NC}"; }
hdr() { echo -e "\n${YELLOW}$1${NC}"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
TEMPLATES_DIR="$PARENT_DIR/templates"
CLAUDE_DIR="$HOME/.claude"
SKILLS_DIR="$CLAUDE_DIR/skills"
HOOKS_DIR="$CLAUDE_DIR/hooks"

mkdir -p "$SKILLS_DIR" "$HOOKS_DIR"

# Detect OS
OS="linux"
if [[ "$OSTYPE" == "darwin"* ]]; then OS="mac"; fi
if grep -qi microsoft /proc/version 2>/dev/null; then OS="wsl"; fi
ok "Platform: $OS"

# --- [1/8] Auth ---
hdr "[1/8] Claude Code auth..."
if ! claude whoami &>/dev/null; then
    echo "  Not logged in. Running claude login..."
    claude login
    if ! claude whoami &>/dev/null; then
        echo "  Login failed. Run 'claude login' and retry."; exit 1
    fi
fi
ok "Auth ok: $(claude whoami 2>/dev/null | head -1)"

# --- [2/8] Skills ---
hdr "[2/8] Skills..."
SKILLS=(
    "caveman|https://github.com/shiv248/Caveman-Claude-Skill.git"
    "security-guidance|https://github.com/anthropics/anthropic-quickstarts.git"
    "playwright|https://github.com/microsoft/playwright-mcp.git"
    "gsd|https://github.com/get-shit-done/gsd-skills.git"
    "frontend-design|https://github.com/nicholasgasior/claude-frontend-design.git"
    "graphify|pip"
)
for entry in "${SKILLS[@]}"; do
    name="${entry%%|*}"; url="${entry##*|}"
    dest="$SKILLS_DIR/$name"
    if [ "$url" = "pip" ]; then
        dim "$name (pip)..."
        pip3 install graphifyy --break-system-packages -q 2>/dev/null || pip install graphifyy -q 2>/dev/null
        graphify install 2>/dev/null && ok "$name ok" || dim "$name: install skipped"
        continue
    fi
    if [ ! -d "$dest" ]; then
        git clone --depth 1 "$url" "$dest" 2>/dev/null && ok "$name" || dim "$name: clone failed"
    else
        dim "$name exists"
    fi
done

# --- [3/8] Hooks ---
hdr "[3/8] Hooks..."
for f in "$TEMPLATES_DIR"/*.js; do
    [ -f "$f" ] || continue
    cp "$f" "$HOOKS_DIR/$(basename "$f")"
    ok "$(basename "$f")"
done

# --- [4/8] RTK ---
hdr "[4/8] RTK — Bash output compression..."
if command -v rtk &>/dev/null; then
    dim "RTK already installed: $(rtk --version)"
else
    curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | bash
    export PATH="$HOME/.local/bin:$PATH"
    for RC in ~/.bashrc ~/.zshrc; do
        [ -f "$RC" ] && grep -q '.local/bin' "$RC" || echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$RC"
    done
fi
rtk init -g --auto-patch 2>/dev/null && ok "RTK hook registered"
echo "  Telemetry? Skip with N."
rtk telemetry disable 2>/dev/null && dim "Telemetry disabled"

# --- [5/8] GSD ---
hdr "[5/8] GSD workflow engine..."
read -p "  Install GSD? (y/N): " USE_GSD
if [[ "$USE_GSD" =~ ^[Yy]$ ]]; then
    npx get-shit-done-cc@latest --claude --global 2>/dev/null && ok "GSD ok"
else
    dim "GSD skipped"
fi

# --- [6/8] Claude Plugins ---
hdr "[6/8] Plugins..."
PLUGINS=(
    "security-guidance" "code-review" "playwright" "coderabbit"
    "firecrawl" "github" "chrome-devtools-mcp" "code-simplifier"
    "huggingface-skills" "claude-mem" "superpowers" "ui-ux-pro-max"
    "obsidian" "document-skills" "example-skills"
)
for p in "${PLUGINS[@]}"; do
    claude plugin install "$p" 2>/dev/null && ok "$p" || dim "$p: skipped"
done

# --- [7/8] settings.json hooks ---
hdr "[7/8] Wiring hooks to settings.json..."
SJ="$CLAUDE_DIR/settings.json"
HF="$HOOKS_DIR"

node - <<EOF
const fs = require('fs');
const path = require('path');
const SJ = '$SJ';
const HF = '$HF';

let raw = fs.existsSync(SJ) ? fs.readFileSync(SJ,'utf8') : '{}';
raw = raw.replace(/^\uFEFF/,'').replace(/(?m)^\s*\/\/[^\n]*/g,'');
let cfg;
try { cfg = JSON.parse(raw); } catch(e) { cfg = {}; }
if (!cfg.hooks) cfg.hooks = {};
const h = cfg.hooks;

const forgeHooks = {
    SessionStart: [{hooks:[{type:'command',command:\`node "\${HF}/session-start.js"\`}]}],
    PreToolUse: [
        {matcher:'Edit|Write|MultiEdit',hooks:[{type:'command',command:\`node "\${HF}/sensitive-file-guard.js"\`,timeout:5}]},
        {matcher:'Bash',hooks:[{type:'command',command:'rtk hook claude'}]},
        {matcher:'Glob|Grep',hooks:[{type:'command',command:\`node "\${HF}/graphify-hint.js"\`}]}
    ],
    PostToolUse: [{matcher:'Bash',hooks:[{type:'command',command:\`node "\${HF}/self-learning.js"\`,timeout:5}]}],
    Notification: [{hooks:[{type:'command',command:\`bash -c 'notify-send "Claude Code" "Needs your input" 2>/dev/null || osascript -e "display notification \\\\"Claude Code needs input\\\\" with title \\\\"Claude Code\\\\"" 2>/dev/null || true'\`}]}]
};

const added=[], skipped=[];
for (const [key, val] of Object.entries(forgeHooks)) {
    if (!h[key]) { h[key]=val; added.push(key); }
    else skipped.push(key);
}
fs.writeFileSync(SJ, JSON.stringify(cfg, null, 2), 'utf8');
if (added.length) console.log('  Added hooks: ' + added.join(', '));
if (skipped.length) console.log('  Kept (user-defined): ' + skipped.join(', '));
EOF
ok "settings.json updated"

# --- [8/8] Project start scripts ---
hdr "[8/8] Project start scripts..."
read -p "  Dev projects directory (e.g. ~/Dev): " DEV_DIR
DEV_DIR="${DEV_DIR/#\~/$HOME}"
if [ -d "$DEV_DIR" ]; then
    for dir in "$DEV_DIR"/*/; do
        name=$(basename "$dir")
        [[ "$name" == "node_modules" || "$name" == "_templates" ]] && continue
        cp "$TEMPLATES_DIR/start.sh" "$dir/start.sh" 2>/dev/null
        chmod +x "$dir/start.sh" 2>/dev/null
    done
    ok "start.sh distributed to $(ls -d "$DEV_DIR"/*/ 2>/dev/null | wc -l | xargs) projects"
else
    dim "Directory not found, skipping"
fi

echo ""
echo -e "${GREEN}============================================${NC}"
echo -e "${GREEN}  ClaudeForge ready!${NC}"
echo -e "${GREEN}  cd your-project && ./start.sh${NC}"
echo -e "${GREEN}============================================${NC}"
echo ""
