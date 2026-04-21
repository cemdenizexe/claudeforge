# Project Init Script - Auto-configures new Claude Code projects
# Usage: powershell -ExecutionPolicy Bypass -File D:\Dev\init-project.ps1 -Name "MyProject"
# Optional: -Design "vercel" for brand DESIGN.md, -TypeUI "glassmorphism" for design skill

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [string]$Design = "",
    [string]$TypeUI = ""
)

$baseDir = "D:\Dev"
$skillSource = "D:\Dev\HabitFlow\.claude\skills"
$projectDir = Join-Path $baseDir $Name

Write-Host "=== Project Init: $Name ==="

# 1. Create project dir if needed
if (-not (Test-Path $projectDir)) {
    New-Item -Path $projectDir -ItemType Directory -Force | Out-Null
    Write-Host "Created: $projectDir"
}

# 2. Create .claude structure
$dirs = @(
    ".claude",
    ".claude\skills",
    ".claude\commands"
)
foreach ($d in $dirs) {
    $p = Join-Path $projectDir $d
    if (-not (Test-Path $p)) {
        New-Item -Path $p -ItemType Directory -Force | Out-Null
    }
}
Write-Host "Created .claude structure"

# 3. Copy skills from HabitFlow
if (Test-Path $skillSource) {
    $copied = 0
    foreach ($skillDir in (Get-ChildItem $skillSource -Directory)) {
        $dest = Join-Path $projectDir ".claude\skills\$($skillDir.Name)"
        if (-not (Test-Path $dest)) {
            Copy-Item -Path $skillDir.FullName -Destination $dest -Recurse -Force
            $copied++
        }
    }
    Write-Host "Copied $copied skills"
} else {
    Write-Host "WARNING: Skill source not found at $skillSource"
}

# 3b. Copy commands from HabitFlow
$commandSource = "D:\Dev\HabitFlow\.claude\commands"
if (Test-Path $commandSource) {
    Copy-Item -Path "$commandSource\*" -Destination (Join-Path $projectDir ".claude\commands") -Recurse -Force
    $cmdCount = (Get-ChildItem (Join-Path $projectDir ".claude\commands") -Recurse -File).Count
    Write-Host "Copied $cmdCount command files"
}

# 3c. Copy start.ps1 from templates
$startTemplate = "D:\Dev\_templates\start.ps1"
$startDest = Join-Path $projectDir "start.ps1"
if ((Test-Path $startTemplate) -and (-not (Test-Path $startDest))) {
    Copy-Item -Path $startTemplate -Destination $startDest -Force
    Write-Host "Copied start.ps1"
}

# 4. Add DESIGN.md via getdesign if requested
if ($Design -ne "") {
    Write-Host "Adding DESIGN.md: $Design style..."
    Push-Location $projectDir
    npx getdesign@latest add $Design
    Pop-Location
}

# 5. Add TypeUI design skill if requested
if ($TypeUI -ne "") {
    Write-Host "Adding TypeUI design skill: $TypeUI..."
    Push-Location $projectDir
    npx typeui.sh pull $TypeUI
    Pop-Location
}

# 6. Create settings.local.json if missing
$settingsPath = Join-Path $projectDir ".claude\settings.local.json"
if (-not (Test-Path $settingsPath)) {
    $settings = @'
{
  "permissions": {
    "allow": [
      "Bash(powershell:*)",
      "Bash(node:*)",
      "Bash(npx:*)",
      "Bash(npm:*)",
      "Bash(git:*)",
      "Bash(cd:*)",
      "Bash(dir:*)",
      "Bash(echo:*)",
      "Bash(cat:*)",
      "Bash(ls:*)",
      "Bash(mkdir:*)",
      "Bash(adb:*)",
      "Bash(curl:*)",
      "Bash(python:*)"
    ]
  }
}
'@
    Set-Content -Path $settingsPath -Value $settings -Encoding UTF8
    Write-Host "Created settings.local.json"
}

# 7. Init git if needed
$gitDir = Join-Path $projectDir ".git"
if (-not (Test-Path $gitDir)) {
    Push-Location $projectDir
    git init
    Pop-Location
    Write-Host "Initialized git"
}

# 8. Create .gitignore if missing
$gitignore = Join-Path $projectDir ".gitignore"
if (-not (Test-Path $gitignore)) {
    $content = @'
node_modules/
.env
.env.local
dist/
build/
*.jks
*.keystore
.claude/memory.db
'@
    Set-Content -Path $gitignore -Value $content -Encoding UTF8
    Write-Host "Created .gitignore"
}

Write-Host ""
Write-Host "=== Init Complete ==="
Write-Host "Project: $projectDir"
Write-Host "Next: cd $projectDir && claude"
