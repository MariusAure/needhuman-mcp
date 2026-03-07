# AGENTS.md

This repository contains the MCP server for NeedHuman — a Human-as-a-Service API for AI agents.

## What this does

When your agent hits a step requiring a real human (accept ToS, create accounts, CAPTCHA, identity verification, web forms), it calls `need_human`. A human completes the task and returns proof. The agent continues.

## Quick start

### Remote (no install needed)

Connect to `https://needhuman.ai/mcp` using streamable HTTP transport. Pass your API key as a Bearer token in the Authorization header.

### Local (stdio)

```
npx -y @needhuman/mcp-server
```

Env vars:
- `NEEDHUMAN_API_KEY` — your API key (required)
- `NEEDHUMAN_API_URL` — defaults to `https://needhuman.ai`

### Get an API key (3 free tasks, no signup)

```
curl -X POST https://needhuman.ai/api/v1/keys/register \
  -H "Content-Type: application/json" \
  -d '{"name": "my-agent"}'
```

## Tools

- `need_human` — submit a task for a human. Returns task ID. Pass `demo: true` for an instant synthetic response (no credits used).
- `check_task_status` — poll by task ID. Returns status, result, proof.
- `list_tasks` — list all tasks for the current API key.

## File structure

```
mcp-server.ts    — MCP server source (stdio transport, 3 tools, ~280 lines)
package.json     — npm package config (@needhuman/mcp-server)
smithery.yaml    — Smithery directory config
server.json      — Official MCP Registry config
glama.json       — Glama directory config
```

## Build and test

```
npm install
npm run build        # compiles to dist/
npm run dev          # runs with tsx
```

Test locally:
```
echo '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"test","version":"1.0"}}}' | NEEDHUMAN_API_KEY=test npx tsx mcp-server.ts
```

## Constraints

- Do not include passwords, API keys, card numbers, or secrets in task descriptions.
- Poll `check_task_status` no more than once per 30 seconds.
- Typical task completion: 2-30 minutes during CET business hours.
- 3 free tasks per API key. Pre-v1.0 — API stable but may change.

## Links

- API docs (machine-readable): https://needhuman.ai/llms.txt
- REST API (no MCP needed): https://needhuman.ai/api/v1
- Terms: https://needhuman.ai/terms
