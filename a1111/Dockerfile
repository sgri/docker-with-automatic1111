ARG BASE_IMAGE=cuda-with-python
FROM ${BASE_IMAGE}
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Automatik1111 web UI for Stable Diffusion"

RUN apt update && \
  apt install -y bc mc && \
  apt clean && \
  rm -rf /var/lib/apt/lists/*

COPY entry.sh /usr/local/bin/
COPY start.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entry.sh"]
