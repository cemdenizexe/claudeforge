# Ecosystem Sync — Syncs skills, commands, .mcp.json, settings.local.json, start.ps1
# Source of truth: D:\Dev\HabitFlow
# Usage: powershell -ExecutionPolicy Bypass -File D:\Dev\sync-skills.ps1

$source = "D:\Dev\HabitFlow"
$baseDir = "D:\Dev"
$projects = @(
    "cpu-commander-app",
    "TicTacToeGenerals",
    "Trade-Bot\crypto-trading-bot",
    "Mind-Elevator-App",
    "SporBeslen",
    "UltimateDealCloser",
    "HesapMakinesiPro",
    "INDIK App",
    "NBA-Machine-Learning-Sports-Betting",
    "polymarket-bot",
    "BagimlilikBirak",
    "ai-video-channel",
    "Fıkra_App"
)

# Template files
$templateStart = "D:\Dev\_templates\start.ps1"
$templateEcosystem = "D:\Dev\_templates\ecosystem-awareness.md"
$mcpTemplate = @'
{
  "mcpServers": {
    "ruflo": {
      "command": "cmd",
      "args": ["/c", "npx", "-y", "ruflo@latest", "mcp", "start"],
      "env": {
        "npm_config_update_notifier": "false",
        "CLAUDE_FLOW_MODE": "v3",
        "CLAUDE_FLOW_HOOKS_ENABLED": "true",
        "CLAUDE_FLOW_TOPOLOGY": "hierarchical-mesh",
        "CLAUDE_FLOW_MAX_AGENTS": "8",
        "CLAUDE_FLOW_MEMORY_BACKEND": "hybrid"
      }
    }
  }
}
'@

Write-Host ""
Write-Host "=== Ecosystem Sync Starting ===" -ForegroundColor Cyan
Write-Host "Source: $source" -ForegroundColor DarkCyan
Write-Host ""

foreach ($project in $projects) {
    $targetDir = Join-Path $baseDir $project
    if (-not (Test-Path $targetDir)) {
        Write-Host "SKIP: $project (not found)" -ForegroundColor DarkYellow
        continue
    }
    
    Write-Host "--- $project ---" -ForegroundColor Yellow

    # 1. Ensure .claude structure exists
    foreach ($d in @(".claude", ".claude\skills", ".claude\commands")) {
        $p = Join-Path $targetDir $d
        if (-not (Test-Path $p)) {
            New-Item -Path $p -ItemType Directory -Force | Out-Null
        }
    }

    # 2. Sync skills
    $skillSource = Join-Path $source ".claude\skills"
    $skillTarget = Join-Path $targetDir ".claude\skills"
    $skillCopied = 0
    foreach ($skillDir in (Get-ChildItem $skillSource -Directory)) {
        $dest = Join-Path $skillTarget $skillDir.Name
        if (-not (Test-Path $dest)) {
            Copy-Item -Path $skillDir.FullName -Destination $dest -Recurse -Force
            $skillCopied++
        }
    }

    # 3. Sync commands (files + subdirectories)
    $cmdSource = Join-Path $source ".claude\commands"
    $cmdTarget = Join-Path $targetDir ".claude\commands"
    $cmdCopied = 0
    # Copy top-level .md files
    foreach ($cmdFile in (Get-ChildItem $cmdSource -File -Filter "*.md")) {
        $dest = Join-Path $cmdTarget $cmdFile.Name
        if (-not (Test-Path $dest)) {
            Copy-Item -Path $cmdFile.FullName -Destination $dest -Force
            $cmdCopied++
        }
    }
    # Copy subdirectories
    foreach ($cmdDir in (Get-ChildItem $cmdSource -Directory)) {
        $dest = Join-Path $cmdTarget $cmdDir.Name
        if (-not (Test-Path $dest)) {
            Copy-Item -Path $cmdDir.FullName -Destination $dest -Recurse -Force
            $cmdCopied++
        }
    }

    # 4. Create .mcp.json if missing
    $mcpPath = Join-Path $targetDir ".mcp.json"
    $mcpCreated = $false
    if (-not (Test-Path $mcpPath)) {
        Set-Content -Path $mcpPath -Value $mcpTemplate -Encoding UTF8
        $mcpCreated = $true
    }

    # 5. Sync start.ps1 (always overwrite with latest template)
    $startDest = Join-Path $targetDir "start.ps1"
    $startCreated = $false
    if (Test-Path $templateStart) {
        Copy-Item -Path $templateStart -Destination $startDest -Force
        $startCreated = $true
    }

    # 6. Sync ecosystem-awareness.md (always overwrite)
    $ecoCreated = $false
    if (Test-Path $templateEcosystem) {
        $ecoDest = Join-Path $targetDir ".claude\ecosystem-awareness.md"
        Copy-Item -Path $templateEcosystem -Destination $ecoDest -Force
        $ecoCreated = $true
    }

    # 7. Report
    $status = @()
    if ($skillCopied -gt 0) { $status += "skills:$skillCopied" }
    if ($cmdCopied -gt 0) { $status += "commands:$cmdCopied" }
    if ($mcpCreated) { $status += ".mcp.json:created" }
    if ($startCreated) { $status += "start.ps1:synced" }
    if ($ecoCreated) { $status += "ecosystem:synced" }
    if ($status.Count -eq 0) { $status += "up-to-date" }
    Write-Host "  $($status -join ', ')" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== Ecosystem Sync Complete ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "NOTE: CLAUDE.md and settings.local.json are project-specific." -ForegroundColor DarkGray
Write-Host "      They are NOT overwritten by this script." -ForegroundColor DarkGray
Write-Host "      Edit them manually per project if needed." -ForegroundColor DarkGray
