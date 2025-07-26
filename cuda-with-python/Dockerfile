ARG BASE_IMAGE=cuda
FROM ${BASE_IMAGE}
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Ubuntu-based image with CUDA and Python, tailored for Stable Diffusion"

USER root
RUN apt install -y --no-install-recommends \
    build-essential \
    git \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    make \
    tk-dev \
    xz-utils \
    zlib1g-dev && \
  apt clean
      
USER artist
COPY install-python.sh /tmp/
RUN /tmp/install-python.sh