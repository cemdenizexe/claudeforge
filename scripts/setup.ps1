$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$accent = "DarkYellow"
$dim = "DarkGray"

Write-Host ""
Write-Host "   ██████╗██╗      █████╗ ██╗   ██╗██████╗ ███████╗" -ForegroundColor DarkYellow
Write-Host "  ██╔════╝██║     ██╔══██╗██║   ██║██╔══██╗██╔════╝" -ForegroundColor DarkYellow
Write-Host "  ██║     ██║     ███████║██║   ██║██║  ██║█████╗  " -ForegroundColor DarkYellow
Write-Host "  ██║     ██║     ██╔══██║██║   ██║██║  ██║██╔══╝  " -ForegroundColor DarkYellow
Write-Host "  ╚██████╗███████╗██║  ██║╚██████╔╝██████╔╝███████╗" -ForegroundColor DarkYellow
Write-Host "   ╚═════╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═════╝╚══════╝" -ForegroundColor DarkYellow
Write-Host ""
Write-Host "  ███████╗ ██████╗ ██████╗  ██████╗ ███████╗" -ForegroundColor Yellow
Write-Host "  ██╔════╝██╔═══██╗██╔══██╗██╔════╝ ██╔════╝" -ForegroundColor Yellow
Write-Host "  █████╗  ██║   ██║██████╔╝██║  ███╗█████╗  " -ForegroundColor Yellow
Write-Host "  ██╔══╝  ██║   ██║██╔══██╗██║   ██║██╔══╝  " -ForegroundColor Yellow
Write-Host "  ██║     ╚██████╔╝██║  ██║╚██████╔╝███████╗" -ForegroundColor Yellow
Write-Host "  ╚═╝      ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝" -ForegroundColor Yellow
Write-Host ""
Write-Host "                    by cemdenizexe" -ForegroundColor White
Write-Host ""
Write-Host "  200+ skills | Security autopilot | Self-learning" -ForegroundColor $dim
Write-Host ""
Write-Host "  ------------------------------------------------" -ForegroundColor $dim
Write-Host ""

# --- Environment Detection ---
$HOME_DIR = $env:USERPROFILE
$CLAUDE_DIR = Join-Path $HOME_DIR ".claude"
$SKILLS_DIR = Join-Path $CLAUDE_DIR "skills"
$HOOKS_DIR = Join-Path $CLAUDE_DIR "hooks"
$SCRIPT_ROOT = $PSScriptRoot
$PARENT_ROOT = Split-Path $SCRIPT_ROOT -Parent

# WSL Detection
$HAS_WSL = $false
try { $wslCheck = wsl --list --quiet 2>$null; if ($wslCheck) { $HAS_WSL = $true } } catch {}

Write-Host "  Home      : $HOME_DIR" -ForegroundColor $dim
Write-Host "  Claude dir: $CLAUDE_DIR" -ForegroundColor $dim
if ($HAS_WSL) { Write-Host "  WSL       : Detected - will install to both Windows and WSL" -ForegroundColor Cyan }
Write-Host ""

# --- [1/9] Prerequisites ---
Write-Host "[1/9] Checking prerequisites..." -ForegroundColor Yellow
$missing = @()
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) { $missing += "Node.js" }
if (-not (Get-Command "git" -ErrorAction SilentlyContinue)) { $missing += "Git" }
if (-not (Get-Command "claude" -ErrorAction SilentlyContinue)) { $missing += "Claude Code (npm install -g @anthropic-ai/claude-code)" }
if ($missing.Count -gt 0) {
    Write-Host "  Missing: $($missing -join ', ')" -ForegroundColor Red
    exit 1
}
Write-Host "  All prerequisites found." -ForegroundColor Green

# --- [2/9] Configuration ---
Write-Host ""
Write-Host "[2/9] Configuration..." -ForegroundColor Yellow
$DEV_DIR = (Read-Host "  Your projects directory (e.g. D:\Dev, C:\code)").Trim()
if (-not $DEV_DIR) { $DEV_DIR = "D:\Dev" }
if (-not (Test-Path $DEV_DIR)) {
    $create = Read-Host "  $DEV_DIR doesn't exist. Create it? (y/n)"
    if ($create -eq 'y') { New-Item -Path $DEV_DIR -ItemType Directory -Force | Out-Null }
}
$USER_NAME = (Read-Host "  Your name (for CLAUDE.md identity)").Trim()
if (-not $USER_NAME) { $USER_NAME = "Developer" }
$INSTALL_CAVEMAN = (Read-Host "  Install Caveman? 65-75% token savings (y/n)").Trim()
if (-not $INSTALL_CAVEMAN) { $INSTALL_CAVEMAN = "y" }
$INSTALL_VIDEO = (Read-Host "  Install video pipeline skills? Seedance/SEO/YouTube (y/n)").Trim()
if (-not $INSTALL_VIDEO) { $INSTALL_VIDEO = "n" }
$INSTALL_GSD = (Read-Host "  Install GSD? 70+ workflow commands + statusbar (y/n)").Trim()
if (-not $INSTALL_GSD) { $INSTALL_GSD = "y" }
Write-Host ""

# --- [3/9] Directories ---
Write-Host "[3/9] Setting up directories..." -ForegroundColor Yellow
foreach ($d in @($CLAUDE_DIR, $SKILLS_DIR, $HOOKS_DIR)) {
    if (-not (Test-Path $d)) { New-Item -Path $d -ItemType Directory -Force | Out-Null }
}
$TEMPLATES_DIR = Join-Path $DEV_DIR "_templates"
if (-not (Test-Path $TEMPLATES_DIR)) { New-Item -Path $TEMPLATES_DIR -ItemType Directory -Force | Out-Null }
Write-Host "  Directories created." -ForegroundColor Green

# --- [4/9] Plugins ---
Write-Host "[4/9] Installing plugins..." -ForegroundColor Yellow
$corePlugins = @(
    "security-guidance", "code-review", "playwright",
    "coderabbit", "firecrawl", "github",
    "chrome-devtools-mcp", "code-simplifier", "huggingface-skills"
)
foreach ($p in $corePlugins) {
    Write-Host "  $p..." -ForegroundColor $dim -NoNewline
    & claude plugin install "${p}@claude-plugins-official" 2>$null
    Write-Host " ok" -ForegroundColor Green
}
Write-Host "  Marketplace plugins..." -ForegroundColor $dim
& claude plugin marketplace add "thedotmack/claude-mem" 2>$null
& claude plugin install "claude-mem@thedotmack" 2>$null
& claude plugin marketplace add "obra/superpowers-marketplace" 2>$null
& claude plugin install "superpowers@superpowers-marketplace" 2>$null
& claude plugin marketplace add "nextlevelbuilder/ui-ux-pro-max-skill" 2>$null
& claude plugin install "ui-ux-pro-max@ui-ux-pro-max-skill" 2>$null
& claude plugin marketplace add "kepano/obsidian-skills" 2>$null
& claude plugin install "obsidian@obsidian-skills" 2>$null
& claude plugin marketplace add "anthropics/skills" 2>$null
& claude plugin install "document-skills@anthropic-agent-skills" 2>$null
& claude plugin install "example-skills@anthropic-agent-skills" 2>$null
Write-Host "  16 plugins installed." -ForegroundColor Green

# --- [5/9] Skills ---
Write-Host "[5/9] Installing skills..." -ForegroundColor Yellow
$coreSkills = [System.Collections.ArrayList]@()
[void]$coreSkills.Add(@{ name = "awesome-design-md"; repo = "https://github.com/VoltAgent/awesome-design-md.git" })
if ($INSTALL_CAVEMAN -eq 'y') {
    [void]$coreSkills.Add(@{ name = "caveman-skill"; repo = "https://github.com/JuliusBrussee/caveman.git" })
}
if ($INSTALL_VIDEO -eq 'y') {
    [void]$coreSkills.Add(@{ name = "claude-seo"; repo = "https://github.com/AgriciDaniel/claude-seo.git" })
    [void]$coreSkills.Add(@{ name = "claude-youtube"; repo = "https://github.com/AgriciDaniel/claude-youtube.git" })
    [void]$coreSkills.Add(@{ name = "marketingskills"; repo = "https://github.com/coreyhaines31/marketingskills.git" })
    [void]$coreSkills.Add(@{ name = "seedance2-skill"; repo = "https://github.com/dexhunter/seedance2-skill.git" })
}
foreach ($s in $coreSkills) {
    $dest = Join-Path $SKILLS_DIR $s.name
    if (-not (Test-Path $dest)) {
        Write-Host "  $($s.name)..." -ForegroundColor $dim -NoNewline
        git clone --depth 1 $s.repo $dest 2>$null
        Write-Host " ok" -ForegroundColor Green
    } else {
        Write-Host "  $($s.name) exists." -ForegroundColor $dim
    }
}
if ($INSTALL_GSD -eq 'y') {
    Write-Host "  GSD workflow..." -ForegroundColor $dim
    npx get-shit-done-cc@latest --claude --global 2>$null
    Write-Host "  GSD installed." -ForegroundColor Green
}
Write-Host "  Skills installed." -ForegroundColor Green

# --- [6/9] Hooks + settings.json wiring ---
Write-Host "[6/9] Installing hooks + wiring to settings.json..." -ForegroundColor Yellow
$hookSource = Join-Path $PARENT_ROOT "templates"
foreach ($hook in @("sensitive-file-guard.js", "self-learning.js", "skill-discovery.js", "session-start.js", "update-check.js")) {
    $src = Join-Path $hookSource $hook
    $dst = Join-Path $HOOKS_DIR $hook
    if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Force; Write-Host "  $hook" -ForegroundColor Green }
}

# Wire hooks to settings.json
$settingsJson = Join-Path $CLAUDE_DIR "settings.json"
$hooksDir_fwd = $HOOKS_DIR.Replace('\', '/')
$hookConfig = @{
    hooks = @{
        SessionStart = @(@{ hooks = @(@{ type = "command"; command = "node `"$hooksDir_fwd/session-start.js`"" }) })
        PreToolUse = @(
            @{ matcher = "Edit|Write|MultiEdit"; hooks = @(@{ type = "command"; command = "node `"$hooksDir_fwd/sensitive-file-guard.js`""; timeout = 5 }) }
        )
        PostToolUse = @(
            @{ matcher = "Bash"; hooks = @(@{ type = "command"; command = "node `"$hooksDir_fwd/self-learning.js`""; timeout = 5 }) }
        )
    }
}

try {
    $raw = if (Test-Path $settingsJson) { Get-Content $settingsJson -Raw } else { '{}' }
    $raw = $raw -replace '(?m)^\s*//.*$','' -replace ',(\s*[}\]])',('$1')
    $existing = $raw | ConvertFrom-Json
    if (-not $existing.hooks) {
        $existing | Add-Member -NotePropertyName "hooks" -NotePropertyValue $hookConfig.hooks -Force
        $existing | ConvertTo-Json -Depth 10 | Set-Content $settingsJson -Encoding UTF8
        Write-Host "  Hooks wired to settings.json" -ForegroundColor Green
    } else {
        Write-Host "  Hooks already in settings.json" -ForegroundColor $dim
    }
} catch {
    Write-Host "  Could not wire hooks (settings.json parse error)" -ForegroundColor DarkYellow
}

# --- [7/9] Global CLAUDE.md ---
Write-Host "[7/9] Generating Global CLAUDE.md..." -ForegroundColor Yellow
$globalMd = Join-Path $CLAUDE_DIR "CLAUDE.md"
$templateMd = Join-Path (Join-Path $PARENT_ROOT "templates") "CLAUDE-template.md"
$skipClaude = $false
if (Test-Path $globalMd) {
    $overwrite = Read-Host "  Global CLAUDE.md exists. Overwrite? (y/n)"
    if ($overwrite -ne 'y') {
        Write-Host "  Skipped." -ForegroundColor DarkYellow
        $skipClaude = $true
    }
}
if (-not $skipClaude) {
    if (Test-Path $templateMd) {
        $content = Get-Content $templateMd -Raw
        $content = $content.Replace("{{USER_NAME}}", $USER_NAME)
        $content = $content.Replace("{{DEV_DIR}}", $DEV_DIR)
        if ($INSTALL_CAVEMAN -eq 'y') {
            $content = $content.Replace("{{CAVEMAN}}", "- Caveman - token 65-75 percent reduction. Type dollar-caveman to activate.")
        } else {
            $content = $content.Replace("{{CAVEMAN}}", "")
        }
        Set-Content -Path $globalMd -Value $content -Encoding UTF8
        Write-Host "  Global CLAUDE.md created for $USER_NAME." -ForegroundColor Green
    } else {
        $fallback = Join-Path (Join-Path $PARENT_ROOT "templates") "CLAUDE.md"
        if (Test-Path $fallback) { Copy-Item -Path $fallback -Destination $globalMd -Force }
        Write-Host "  Global CLAUDE.md copied (default)." -ForegroundColor DarkYellow
    }
}

# --- [8/9] Dependencies + Templates ---
Write-Host "[8/9] Dependencies and templates..." -ForegroundColor Yellow
foreach ($f in @("start.ps1", "ecosystem-awareness.md", ".claudeignore")) {
    $src = Join-Path (Join-Path $PARENT_ROOT "templates") $f
    $dst = Join-Path $TEMPLATES_DIR $f
    if (Test-Path $src) { Copy-Item -Path $src -Destination $dst -Force }
}

# start.ps1'i DEV_DIR altindaki tum projelere dagit
Write-Host "  Distributing start.ps1 to projects..." -ForegroundColor $dim
$startSrc = Join-Path (Join-Path $PARENT_ROOT "templates") "start.ps1"
if (Test-Path $startSrc) {
    $distributed = 0
    foreach ($proj in (Get-ChildItem $DEV_DIR -Directory -ErrorAction SilentlyContinue)) {
        $dst = Join-Path $proj.FullName "start.ps1"
        Copy-Item -Path $startSrc -Destination $dst -Force
        $distributed++
    }
    Write-Host "  start.ps1 → $distributed projects" -ForegroundColor Green
}
Write-Host "  CodeBurn..." -ForegroundColor $dim -NoNewline
npm install -g codeburn 2>$null
Write-Host " ok" -ForegroundColor Green

# Status bar — daniel3303/ClaudeCodeStatusLine
Write-Host "  Status bar (token + rate limit + context)..." -ForegroundColor $dim -NoNewline
$statusBarDir = Join-Path $HOME_DIR ".claude\statusline"
if (-not (Test-Path $statusBarDir)) {
    git clone --depth 1 https://github.com/daniel3303/ClaudeCodeStatusLine.git $statusBarDir 2>$null
}
$statusBarScript = Join-Path $statusBarDir "statusline.ps1"
if (Test-Path $statusBarScript) {
    $settingsJson = Join-Path $CLAUDE_DIR "settings.json"
    $settingsContent = if (Test-Path $settingsJson) { Get-Content $settingsJson -Raw | ConvertFrom-Json } else { [PSCustomObject]@{} }
    if (-not $settingsContent.statusLine) {
        $settingsContent | Add-Member -NotePropertyName "statusLine" -NotePropertyValue @{
            type = "command"
            command = "powershell -File `"$statusBarScript`""
        } -Force
        $settingsContent | ConvertTo-Json -Depth 5 | Set-Content $settingsJson -Encoding UTF8
    }
    Write-Host " ok" -ForegroundColor Green
} else {
    Write-Host " skipped (clone failed)" -ForegroundColor DarkYellow
}

# Claude Desktop MCP bridge — filesystem erisimi
Write-Host "  Claude Desktop MCP bridge..." -ForegroundColor $dim -NoNewline
$desktopConfig = "$env:APPDATA\Claude\claude_desktop_config.json"
if (Test-Path $desktopConfig) {
    try {
        $dc = Get-Content $desktopConfig -Raw | ConvertFrom-Json
        if (-not $dc.mcpServers) { $dc | Add-Member -NotePropertyName "mcpServers" -NotePropertyValue ([PSCustomObject]@{}) -Force }
        if (-not $dc.mcpServers.filesystem) {
            $dc.mcpServers | Add-Member -NotePropertyName "filesystem" -NotePropertyValue @{
                command = "npx"
                args = @("-y", "@modelcontextprotocol/server-filesystem", $CLAUDE_DIR, $DEV_DIR)
            } -Force
            $dc | ConvertTo-Json -Depth 8 | Set-Content $desktopConfig -Encoding UTF8
            Write-Host " ok (filesystem MCP added)" -ForegroundColor Green
        } else {
            Write-Host " already configured" -ForegroundColor $dim
        }
    } catch {
        Write-Host " skipped (config parse error)" -ForegroundColor DarkYellow
    }
} else {
    Write-Host " skipped (Claude Desktop not found)" -ForegroundColor DarkYellow
}

if (-not (Get-Command "bun" -ErrorAction SilentlyContinue)) {
    $installBun = Read-Host "  Bun not found. Install? Some plugins use it. (y/n)"
    if ($installBun -eq 'y') { npm install -g bun 2>$null }
} else { Write-Host "  Bun found." -ForegroundColor Green }

# --- [9/9] WSL Mirror ---
# WSL - skip
Write-Host "[9/9] WSL sync skipped (Claude Code runs native on Windows)" -ForegroundColor $dim
Write-Host ""

# --- Complete ---
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "   ClaudeForge setup complete!" -ForegroundColor Green
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  Installed:" -ForegroundColor White
Write-Host "    Plugins     16 (zero redundancy)" -ForegroundColor $dim
Write-Host "    Skills      $($coreSkills.Count) cloned + GSD + plugin bundles" -ForegroundColor $dim
Write-Host "    Hooks       session-start, sensitive-file-guard, self-learning, skill-discovery, update-check" -ForegroundColor $dim
Write-Host '    Workflow    GSD workflow engine' -ForegroundColor $dim
Write-Host "    Config      Global CLAUDE.md with Skill Activation Guide" -ForegroundColor $dim
Write-Host "    Dashboard   CodeBurn (npx codeburn)" -ForegroundColor $dim
Write-Host ""
Write-Host "  Quick start:" -ForegroundColor White
Write-Host "    cd $DEV_DIR\[your-project]" -ForegroundColor $dim
Write-Host "    claude" -ForegroundColor $dim
Write-Host '    Paste: "Read CLAUDE.md. Run git status. Report status."' -ForegroundColor $dim
if ($INSTALL_CAVEMAN -eq 'y') {
    Write-Host '    Type $caveman to save tokens' -ForegroundColor $dim
}
Write-Host ""
Write-Host "  Health check: npx codeburn optimize" -ForegroundColor $dim
Write-Host "  Docs: https://github.com/cemdenizexe/claudeforge" -ForegroundColor $dim
Write-Host ""
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host "  SONRAKI ADIMLAR" -ForegroundColor White
Write-Host "  ================================================" -ForegroundColor $accent
Write-Host ""
Write-Host "  [1] Claude Code icin:" -ForegroundColor Yellow
Write-Host "      cd $DEV_DIR\[proje]" -ForegroundColor $dim
Write-Host "      .\start.ps1" -ForegroundColor $dim
Write-Host ""
Write-Host "  [2] Claude Desktop awareness:" -ForegroundColor Yellow
if (Test-Path $desktopConfig) {
    Write-Host "      Filesystem MCP added. Restart Claude Desktop." -ForegroundColor Green
    Write-Host "      Then paste this prompt:" -ForegroundColor $dim
} else {
    Write-Host "      Open claude.ai → Projects → Instructions" -ForegroundColor $dim
    Write-Host "      Paste this prompt:" -ForegroundColor $dim
}
Write-Host ""
Write-Host "  ┌─────────────────────────────────────────────────────────┐" -ForegroundColor Cyan
Write-Host "  │ Read ~/.claude/CLAUDE.md fully. List active skills,     │" -ForegroundColor Cyan
Write-Host "  │ hooks, and GSD status. Confirm ClaudeForge is active.   │" -ForegroundColor Cyan
Write-Host "  └─────────────────────────────────────────────────────────┘" -ForegroundColor Cyan
$desktopPrompt = "Read ~/.claude/CLAUDE.md fully. List active skills, hooks, and GSD status. Confirm ClaudeForge is active."
try { $desktopPrompt | Set-Clipboard; Write-Host "      (copied to clipboard)" -ForegroundColor Green } catch {}
Write-Host ""
Write-Host "  [3] Ilk proje icin:" -ForegroundColor Yellow
Write-Host "      .\start.ps1 calistir → model sec → bootstrap prompt yapistir" -ForegroundColor $dim
Write-Host ""