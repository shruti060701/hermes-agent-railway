FROM nousresearch/hermes-agent:latest

USER root

ENV HERMES_HOME=/opt/data
ENV PORT=9119

# Copy start script
COPY start.sh /opt/hermes/start.sh
RUN chmod +x /opt/hermes/start.sh

EXPOSE 9119

# Use the original entrypoint (activates venv, sets up config)
# Pass our start script as the command — entrypoint will exec it since it's on PATH
CMD ["bash", "/opt/hermes/start.sh"]
