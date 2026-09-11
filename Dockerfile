FROM nousresearch/hermes-agent@sha256:dd539111ddc4a6c2046c9bc5d7b9966dfcd7746893433c9590dc055fac0fc565

USER root

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

# Use the original entrypoint (activates venv, sets up config)
# Pass our start script as the command — entrypoint will exec it since it's on PATH
CMD ["bash", "/opt/hermes/start.sh"]
