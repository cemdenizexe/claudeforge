#!/bin/bash
# ClaudeForge session launcher — macOS / Linux / WSL

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"
GIT_BRANCH="$(git -C "$PROJECT_DIR" rev-parse --abbrev-ref HEAD 2>/dev/null || echo 'no-git')"
LAST_COMMIT="$(git -C "$PROJECT_DIR" log --oneline -1 2>/dev/null || echo 'no commits yet')"

echo ""
echo "  ClaudeForge Session"
echo "  ------------------------------------------------"
echo "  Project : $PROJECT_NAME"
echo "  Branch  : $GIT_BRANCH"
echo "  Last    : $LAST_COMMIT"
echo "  ------------------------------------------------"
echo ""

# RTK session stats
if command -v rtk &>/dev/null; then
    RTK_GAIN=$(rtk gain 2>/dev/null | grep -i "tokens saved" || true)
    [ -n "$RTK_GAIN" ] && echo "  RTK: $RTK_GAIN"
fi

BOOTSTRAP="Read CLAUDE.md fully. Read .claude/learnings.md if exists. Run git status and git log --oneline -5. Report: current phase, last commit, next action. No clarifying questions."

# Copy to clipboard (Mac/Linux)
if command -v pbcopy &>/dev/null; then
    echo "$BOOTSTRAP" | pbcopy
    echo "  Bootstrap prompt copied to clipboard (pbcopy)"
elif command -v xclip &>/dev/null; then
    echo "$BOOTSTRAP" | xclip -selection clipboard
    echo "  Bootstrap prompt copied to clipboard (xclip)"
else
    echo "  Bootstrap: $BOOTSTRAP"
fi

echo ""
echo "  Launching Claude Code..."
echo ""
cd "$PROJECT_DIR"
claude
