ARG BASE_IMAGE=cuda
FROM ${BASE_IMAGE}
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Ubuntu-based image with CUDA and Python, tailored for Stable Diffusion"

COPY install-python.sh /tmp/
RUN /tmp/install-python.sh