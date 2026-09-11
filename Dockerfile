FROM nousresearch/hermes-agent@sha256:dd539111ddc4a6c2046c9bc5d7b9966dfcd7746893433c9590dc055fac0fc565

USER root

# tini = tiny init, run as PID 1. Without it, hermes's spawned subprocesses
# (MCP stdio servers, git, tool invocations) that get orphaned reparent to
# PID 1 and accumulate as zombies instead of being reaped. After weeks of
# uptime that exhausts the kernel's PID table -> "fork: cannot allocate
# memory" and the container dies. This is a real, documented failure mode:
# the community's from-source Hermes Railway template
# (praveen-ks-2001/hermes-agent-template) builds Hermes from scratch
# specifically to control this, with the exact same reasoning in its own
# Dockerfile. We don't need to rebuild from source to fix it though --
# tini just needs to be the outermost process. The base image's own
# entrypoint-dispatch.sh is kept in the chain (it still does its own venv
# activation / config setup and execs its argument, same as before), tini
# just wraps the whole thing as true PID 1 so it can reap orphans no
# matter how many exec layers happen above it.
RUN apt-get update && apt-get install -y --no-install-recommends tini && rm -rf /var/lib/apt/lists/*

ENV HERMES_HOME=/opt/data
ENV PORT=9119
# Nous Research's July 2026 security update refuses to start `hermes gateway run` as
# root unless explicitly allowed (this image already ran as USER root before that
# change). Opting in to their sanctioned override rather than switching users.
ENV HERMES_ALLOW_ROOT_GATEWAY=1

# Copy start script
COPY start.sh /opt/hermes/start.sh
RUN chmod +x /opt/hermes/start.sh

EXPOSE 9119

# tini wraps the base image's own entrypoint (which still activates the venv
# and sets up config, then execs its argument -- unchanged from before), with
# our start script as that argument. -g propagates signals to the whole
# process group so Railway's stop signal cleanly reaches the actual server.
ENTRYPOINT ["/usr/bin/tini", "-g", "--", "/opt/hermes/docker/entrypoint-dispatch.sh"]
CMD ["bash", "/opt/hermes/start.sh"]
