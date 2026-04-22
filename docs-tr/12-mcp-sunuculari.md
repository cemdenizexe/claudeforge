# Onerilen MCP Sunuculari

ClaudeForge ile kullanilabilecek MCP'ler.

---

## Kurulum

`%APPDATA%\Claude\claude_desktop_config.json` ac, `mcpServers` bloguna ekle. Sonra Claude Desktop restart.

---

## Productivity

### filesystem (ClaudeForge ile gelir)
```json
"filesystem": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\Users\\USER\\Dev"]
}
```

### desktop-commander
Terminal, dosya, process yonetimi.
```json
"desktop-commander": {
  "command": "npx",
  "args": ["-y", "@wonderwhy-er/desktop-commander"]
}
```

### obsidian
Vault okuma/yazma.
```json
"obsidian": {
  "command": "npx",
  "args": ["-y", "obsidian-mcp", "C:\\Users\\USER\\ObsidianVault"]
}
```

---

## Gelistirici

### github
PR, issue, repo. `GITHUB_TOKEN` gerekli.
```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": { "GITHUB_TOKEN": "ghp_..." }
}
```

### supabase
Database. `access-token` gerekli.
```json
"supabase": {
  "command": "npx",
  "args": ["-y", "@supabase/mcp-server-supabase", "--access-token", "sbp_..."]
}
```

### playwright
Browser otomasyon.
```json
"playwright": {
  "command": "npx",
  "args": ["-y", "@playwright/mcp"]
}
```

### firecrawl
Web scraping. `FIRECRAWL_API_KEY` gerekli.
```json
"firecrawl": {
  "command": "npx",
  "args": ["-y", "firecrawl-mcp"],
  "env": { "FIRECRAWL_API_KEY": "fc-..." }
}
```

---

## AI / Veri

### huggingface
Model ve dataset erisimi.
```json
"huggingface": {
  "command": "npx",
  "args": ["-y", "@huggingface/mcp-server"]
}
```

### brave-search
Web arama. `BRAVE_API_KEY` gerekli.
```json
"brave-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-brave-search"],
  "env": { "BRAVE_API_KEY": "BSA..." }
}
```

---

## Iletisim

### gmail
```json
"gmail": {
  "command": "npx",
  "args": ["-y", "@gongrzhe/server-gmail-mcp"]
}
```

### slack
`SLACK_BOT_TOKEN` gerekli.
```json
"slack": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-slack"],
  "env": { "SLACK_BOT_TOKEN": "xoxb-..." }
}
```

---

## Windows

### windows-mcp
UI otomasyon, mouse/keyboard, screenshot.
```json
"windows-mcp": {
  "command": "npx",
  "args": ["-y", "@stefanbroenner/windows-mcp"]
}
```

---

## Notlar

- API key gerektiren: github, supabase, firecrawl, brave-search, slack, gmail
- Key'leri direkt config'e yazma — environment variable kullan
- Degisiklik sonrasi Claude Desktop restart
