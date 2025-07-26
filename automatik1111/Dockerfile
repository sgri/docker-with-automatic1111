ARG BASE_IMAGE=cuda-with-python
FROM ${BASE_IMAGE}
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Automatik1111 web UI for Stable Diffusion"

COPY entry.sh .
ENTRYPOINT ["./entry.sh"]
