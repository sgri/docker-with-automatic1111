ARG BASE_IMAGE=cuda-with-python
FROM ${BASE_IMAGE}
LABEL org.opencontainers.image.description="Automatik1111 web UI for Stable Diffusion"
LABEL org.opencontainers.image.source="https://github.com/sgri/docker-with-automatic1111"

RUN apt update && \
  apt install -y bc mc && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

COPY entry.sh /usr/local/bin/
COPY start.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entry.sh"]