# Deploy and Host Hermes Agent-self-hosted on Railway

Hermes Agent is an open-source AI assistant from Nous Research that actually gets smarter the more you use it. It builds skills from conversations, remembers context across sessions through Honcho memory, and connects to 200+ LLM models. You can talk to it through Telegram, Discord, Slack, WhatsApp, or WeChat — all from a single self-hosted instance.

## About Hosting Hermes Agent-self-hosted

Why pay $20-50/month for managed AI assistants that forget everything between sessions? Self-hosting Hermes Agent on Railway gives you a persistent AI that grows with you — and it costs ~$5-10/month for the container. Your conversations, API keys, and learned skills stay on your infrastructure. Railway handles SSL, container orchestration, and networking automatically. The template deploys with a persistent volume for Hermes's embedded SQLite database (with FTS5 full-text search), its skill library, and Honcho user models. No external database required. Configure your LLM provider through the WebUI dashboard, connect your messaging channels, and you're running in under five minutes.

## Common Use Cases

- **Personal AI that remembers you** — Unlike ChatGPT, Hermes doesn't start fresh every session. It builds a deepening model of who you are, what you've asked before, and how you prefer answers. After a month of use, it's a fundamentally different assistant than on day one
- **Automated research on autopilot** — Set cron schedules to monitor competitor sites, pull industry reports, and summarize findings into Slack or Telegram digests. Product managers save 3-5 hours weekly on manual research gathering
- **One agent, five channels** — Deploy a single Hermes instance that responds across Telegram, Discord, Slack, WhatsApp, and WeChat simultaneously. Context and memory carry across all channels — a conversation started on Discord can continue on Telegram without losing context
- **Developer automation with 40+ tools** — Execute code, browse the web with Playwright, manage files, run SSH commands, and interact with APIs. Hermes doesn't just talk about doing things — it actually does them inside a sandboxed environment
- **Skill library that compounds** — Every time Hermes solves a problem, it can save the approach as a reusable skill. Over time, your instance accumulates domain-specific capabilities that no generic AI assistant has

## Dependencies for Hermes Agent-self-hosted Hosting

- **Persistent Volume** — Mounted at `/opt/data`. Stores configuration files, SQLite databases with FTS5 search, conversation memories, 89 bundled skills, user-created skills, and Honcho user models. Without this volume, the agent loses all learned context between deploys
- **LLM API Key** — You'll need at least one provider key after deployment. OpenRouter ($0 to start, pay-per-token across 200+ models) is the easiest entry point. Also supports OpenAI, Anthropic, Nous Portal, and NVIDIA NIM directly

### Deployment Dependencies

- [Hermes Agent Official Docs](https://hermes-agent.nousresearch.com/)
- [Quickstart Guide](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart)
- [Docker Hub Image](https://hub.docker.com/r/nousresearch/hermes-agent)
- [GitHub Repository](https://github.com/NousResearch/hermes-agent)
- [Environment Variables Reference](https://hermes-agent.nousresearch.com/docs/reference/environment-variables)

### Implementation Details

This template runs the official `nousresearch/hermes-agent` image with a custom `start.sh` that launches both the messaging gateway and WebUI dashboard:

```
HERMES_HOME=/opt/data
PORT=9119
```

The gateway handles multi-channel messaging (Telegram, Discord, Slack, WhatsApp, WeChat) in the background. The dashboard binds to `0.0.0.0:9119` with the `--insecure` flag so Railway can route HTTPS traffic to it. All data — config, SQLite databases, skills, memories — lives in the `/opt/data` volume. No external database needed. After deployment, open the WebUI at your Railway URL, add an LLM provider key, and start chatting.

## Why Deploy Hermes Agent-self-hosted on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Hermes Agent-self-hosted on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
