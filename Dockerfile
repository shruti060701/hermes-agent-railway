FROM nousresearch/hermes-agent:latest

USER root

ENV HERMES_HOME=/opt/data
ENV PORT=9119

EXPOSE 9119

# Run gateway in background + dashboard on 0.0.0.0 for Railway routing
ENTRYPOINT []
CMD ["bash", "-c", "hermes gateway run & exec hermes dashboard --host 0.0.0.0 --port ${PORT} --no-open"]
