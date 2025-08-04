ARG BASE_IMAGE=cuda-with-python
FROM ${BASE_IMAGE}
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Automatik1111 web UI for Stable Diffusion"

RUN apt install -y bc && \
  apt clean && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY entry.sh /usr/local/bin/
COPY start.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/entry.sh"]
