# Deploy and Host Hermes Agent-self-hosted on Railway

Hermes Agent is an open-source, self-improving AI agent built by Nous Research. It learns from every conversation, creates reusable skills from experience, maintains persistent memory across sessions, and connects to 200+ LLM models across Telegram, Discord, Slack, WhatsApp, and WeChat — all running on your own infrastructure.

## About Hosting Hermes Agent-self-hosted

Self-hosting Hermes Agent gives you full control over your AI assistant — your conversations, learned skills, API keys, and memory data never leave your infrastructure. This Railway template deploys Hermes Agent with a persistent volume for its SQLite database, skills library, and Honcho memory system. Railway handles SSL termination, container orchestration, and networking so you can focus on configuring your agent. Unlike managed AI assistant platforms with per-seat pricing and usage caps, self-hosting on Railway costs ~$5-10/month with no limits on conversations, skills, or connected channels. You only pay your LLM provider (OpenRouter, OpenAI, Anthropic) separately.

## Common Use Cases

- **Personal AI Assistant** — Build a persistent AI companion that remembers your preferences, learns from past conversations, and improves its responses over time through Honcho user modeling and a self-growing skills library
- **Product Research Automation** — Product managers can schedule cron tasks to monitor competitor websites, summarize industry reports, and deliver weekly briefings to Slack or Telegram without manual intervention
- **Multi-Channel Support Agent** — Deploy a single agent that responds across Telegram, Discord, Slack, and WhatsApp simultaneously, maintaining conversation context and user memory across all channels
- **Code and DevOps Automation** — Use 40+ built-in tools including code execution, web browsing with Playwright, file management, and SSH to automate development workflows and monitor services
- **Knowledge Worker Agent** — Create an agent that browses the web, reads documents, takes notes, and builds a growing skill library that makes it more capable with every interaction

## Dependencies for Hermes Agent-self-hosted Hosting

- **Persistent Volume** — Mounted at `/opt/data` to store configuration files, SQLite databases (with FTS5 full-text search), conversation memories, learned skills, and Honcho user models across deploys
- **LLM API Key** — At least one provider key (OpenRouter, OpenAI, Anthropic, Nous Portal, or NVIDIA NIM) configured via the WebUI dashboard after deployment

### Deployment Dependencies

- [Hermes Agent Official Documentation](https://hermes-agent.nousresearch.com/)
- [Hermes Agent Quickstart Guide](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart)
- [Hermes Agent Docker Hub Image](https://hub.docker.com/r/nousresearch/hermes-agent)
- [Hermes Agent GitHub Repository](https://github.com/NousResearch/hermes-agent)
- [Nous Research Website](https://nousresearch.com/)

### Implementation Details

This template uses the official `nousresearch/hermes-agent` Docker image with a persistent volume for all agent data. The container runs both the messaging gateway and WebUI dashboard:

```
HERMES_HOME=/opt/data
PORT=9119
```

A custom `start.sh` script launches the gateway (for messaging channels) in the background and the dashboard (WebUI) in the foreground, bound to `0.0.0.0` so Railway can route traffic. The agent stores all data — configuration, SQLite databases, learned skills, conversation memories, and Honcho user models — in the `/opt/data` volume. No external database is needed. After deployment, open the WebUI at your Railway URL to configure your LLM provider and connect messaging channels.

## Why Deploy Hermes Agent-self-hosted on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Hermes Agent-self-hosted on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
