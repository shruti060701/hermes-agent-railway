FROM nousresearch/hermes-agent:latest

USER root

ENV HERMES_HOME=/opt/data
ENV PORT=9119

EXPOSE 9119
