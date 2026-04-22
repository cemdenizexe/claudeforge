# Recommended MCP Servers

ClaudeForge ile kullanilabilecek MCP'ler. Her biri `claude_desktop_config.json`'a eklenir.

---

## Kurulum

`%APPDATA%\Claude\claude_desktop_config.json` aç, `mcpServers` bloguna ekle.

---

## Productivity

### filesystem (ClaudeForge ile gelir)
Dosya sistemi erisimi.
```json
"filesystem": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\Users\\USER\\Dev"]
}
```

### desktop-commander
Terminal komutlari, dosya islemleri, process yonetimi.
```json
"desktop-commander": {
  "command": "npx",
  "args": ["-y", "@wonderwhy-er/desktop-commander"]
}
```

### obsidian
Obsidian vault okuma/yazma.
```json
"obsidian": {
  "command": "npx",
  "args": ["-y", "obsidian-mcp", "C:\\Users\\USER\\ObsidianVault"]
}
```

---

## Dev

### github
PR, issue, repo yonetimi.
```json
"github": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-github"],
  "env": { "GITHUB_TOKEN": "ghp_..." }
}
```

### supabase
Database sorgu + yonetim.
```json
"supabase": {
  "command": "npx",
  "args": ["-y", "@supabase/mcp-server-supabase", "--access-token", "sbp_..."]
}
```

### playwright
Browser otomasyon, test.
```json
"playwright": {
  "command": "npx",
  "args": ["-y", "@playwright/mcp"]
}
```

### firecrawl
Web scraping, crawling.
```json
"firecrawl": {
  "command": "npx",
  "args": ["-y", "firecrawl-mcp"],
  "env": { "FIRECRAWL_API_KEY": "fc-..." }
}
```

---

## AI / Data

### huggingface
Model hub, dataset erisimi.
```json
"huggingface": {
  "command": "npx",
  "args": ["-y", "@huggingface/mcp-server"]
}
```

### brave-search
Web arama (API key gerekli).
```json
"brave-search": {
  "command": "npx",
  "args": ["-y", "@modelcontextprotocol/server-brave-search"],
  "env": { "BRAVE_API_KEY": "BSA..." }
}
```

---

## Communication

### gmail
Mail okuma/gonderme.
```json
"gmail": {
  "command": "npx",
  "args": ["-y", "@gongrzhe/server-gmail-mcp"]
}
```

### slack
Kanal okuma, mesaj gonderme.
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

## Tam config ornegi

```json
{
  "mcpServers": {
    "filesystem": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-filesystem", "C:\\Dev"] },
    "desktop-commander": { "command": "npx", "args": ["-y", "@wonderwhy-er/desktop-commander"] },
    "github": { "command": "npx", "args": ["-y", "@modelcontextprotocol/server-github"], "env": { "GITHUB_TOKEN": "ghp_..." } },
    "playwright": { "command": "npx", "args": ["-y", "@playwright/mcp"] },
    "firecrawl": { "command": "npx", "args": ["-y", "firecrawl-mcp"], "env": { "FIRECRAWL_API_KEY": "fc-..." } }
  }
}
```

---

## Notlar

- API key gerektiren MCP'ler: github, supabase, firecrawl, brave-search, slack, gmail
- Key'leri `.env`'e koy, config'e direkt yazma
- Degisiklikten sonra Claude Desktop restart
