# Deploy and Host Hermes Agent-self-hosted on Railway

Hermes Agent is an open-source, self-improving AI agent built by Nous Research. It creates skills from experience, maintains persistent memory across sessions, connects to 200+ LLM models, and works across Telegram, Discord, Slack, WhatsApp, and WeChat — all self-hosted with full data ownership.

## About Hosting Hermes Agent-self-hosted

Self-hosting Hermes Agent gives you complete control over your AI assistant — your conversations, memories, skills, and API keys stay on your own infrastructure. This Railway template deploys Hermes Agent with persistent storage for its SQLite database, skills, and memory system. Railway handles SSL, networking, and container orchestration so you can focus on building your agent. Unlike managed AI assistants with monthly subscriptions and usage caps, self-hosting on Railway costs ~$5-10/month for the container with no limits on conversations or skill creation — you only pay your LLM provider separately.

## Common Use Cases

- **Personal AI Assistant** — Build a persistent AI companion that learns your preferences, remembers past conversations, and improves its responses over time through Honcho user modeling
- **Product Research Automation** — Product managers can set up cron-scheduled tasks to monitor competitor websites, summarize industry news, and generate weekly briefings delivered to Slack or Telegram
- **Multi-Channel Support Bot** — Deploy a single agent that responds across Telegram, Discord, and Slack simultaneously, maintaining conversation context and user memory across all channels
- **Code & DevOps Automation** — Use 40+ built-in tools including code execution, web browsing, and file management to automate development workflows, run scripts, and monitor services
- **Knowledge Worker Agent** — Create an agent that browses the web, reads documents, takes notes, and builds a growing skill library that makes it more capable with every interaction

## Dependencies for Hermes Agent-self-hosted Hosting

- **Persistent Volume** — Mounted at `/opt/data` to store configuration files, SQLite databases, conversation memories, learned skills, and user models across deploys.
- **LLM API Key** — At least one provider key (OpenRouter, OpenAI, Anthropic, Nous Portal, or NVIDIA NIM) configured via the WebUI dashboard after deployment.

### Deployment Dependencies

- [Hermes Agent Official Documentation](https://hermes-agent.nousresearch.com/)
- [Hermes Agent GitHub Repository](https://github.com/NousResearch/hermes-agent)
- [Hermes Agent Docker Hub Image](https://hub.docker.com/r/nousresearch/hermes-agent)
- [Nous Research Website](https://nousresearch.com/)
- [Hermes Agent Quickstart Guide](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart)

### Implementation Details

This template uses the official `nousresearch/hermes-agent` Docker image with a persistent volume for all agent data. The container runs both the messaging gateway and WebUI dashboard:

```
HERMES_HOME=/opt/data
PORT=9119
```

The agent stores its configuration, SQLite databases, learned skills, and conversation memories in the `/opt/data` volume. After deployment, open the WebUI dashboard at your Railway URL to configure your LLM provider API key and connect messaging channels. No database service is needed — Hermes uses embedded SQLite with FTS5 full-text search for its memory system.

## Why Deploy Hermes Agent-self-hosted on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Hermes Agent-self-hosted on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
