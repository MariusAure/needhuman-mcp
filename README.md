# NeedHuman MCP Server

MCP server for [NeedHuman](https://needhuman.ai) — Human-as-a-Service API for AI agents.

When your agent hits a step it requires any real human with a browser — accepting terms of service,
creating an account, completing identity verification — it calls NeedHuman.
A human (yes, it's basically me in the beginning) completes the task, submits proof, and the agent continues.

<a href="https://glama.ai/mcp/servers/@MariusAure/need-human">
  <img width="380" height="200" src="https://glama.ai/mcp/servers/@MariusAure/need-human/badge" alt="NeedHuman MCP server" />
</a>

## Install

**Option A — npx (recommended):**

Add to your MCP client config (e.g. `~/.claude/settings.json` or `.cursor/mcp.json`):

```json
{
  "mcpServers": {
    "needhuman": {
      "command": "npx",
      "args": ["-y", "@needhuman/mcp-server"],
      "env": {
        "NEEDHUMAN_API_KEY": "YOUR_KEY"
      }
    }
  }
}
```

**Option B — one-line install (Claude Code):**

```bash
curl -sf "https://needhuman.ai/api/v1/setup?key=YOUR_KEY" | bash
```

Writes `~/.needhuman/mcp-server.ts` and adds NeedHuman to `~/.claude/settings.json`.

**Get an API key** (3 free tasks, no signup):

```bash
curl -X POST https://needhuman.ai/api/v1/keys/register \
  -H "Content-Type: application/json" \
  -d '{"name": "my-agent"}'
```

## Tools

| Tool | Description |
|------|-------------|
| `need_human` | Submit a task for a human to complete. Returns a task ID. |
| `check_task_status` | Poll a task by ID. Returns status, result, and proof. |
| `list_tasks` | List all tasks for the current API key. |

## Status and limitations

- Pre-v1.0. API is stable but may change without notice.
- Tasks are completed by the founders. Coverage: weekdays CET business hours, best-effort evenings.
- Response time: 2–30 minutes during coverage hours, again best effort.
- Tasks with expiring links (< 30 min TTL) may time out before completion.
- 3 free tasks per API key. Pricing for additional tasks: contact marius.bergvik.aure@gmail.com.
- Polling only. No webhooks yet.
- Not accepted: tasks requiring credential storage, persistent login sessions, or financial transactions.

## Data handling

- Task descriptions are stored in the database and read by a human founder to complete the task.
- All API traffic is HTTPS. API keys are stored hashed.
- Do not include passwords, card numbers, or confidential information in task descriptions.

## Links

- Full API docs (for agents): https://needhuman.ai/llms.txt
- Terms of service: https://needhuman.ai/terms
- Contact: marius@needhuman.ai

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)