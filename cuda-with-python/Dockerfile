FROM ubuntu:24.04
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Ubuntu-based image with CUDA and Python, tailored for Stable Diffusion"

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y --no-install-recommends \
        ca-certificates \
        curl \
        git \
        gnupg \
        lsb-release \
        mc \
        sudo  \
        telnet \
        vim \
        wget 

RUN curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb  -o /tmp/cuda-keyring.deb && \
    dpkg --install /tmp/cuda-keyring.deb && rm /tmp/cuda-keyring.deb && \
    apt update && apt install -y --no-install-recommends \
      libcudnn9-cuda-12 \
      libnvidia-compute-535 \
      libnvidia-ml-dev \
      cuda-toolkit-12-6 && \
      apt clean && rm -rf /var/lib/apt/lists/*
    
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN useradd -m -s /bin/bash -g users -G sudo artist
WORKDIR /home/artist
USER artist

COPY install-python.sh /tmp/
RUN /tmp/install-python.sh