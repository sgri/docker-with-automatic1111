FROM ubuntu:24.04
LABEL org.opencontainers.image.description="Ubuntu-based image with CUDA"
LABEL org.opencontainers.image.source="https://github.com/sgri/docker-with-automatic1111"

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        google-perftools \
        kmod \
        less \
        libgl1 \
        lsb-release \
        nano \
        pciutils \
        sudo  \
        telnet \
        vim \
        wget && \
    curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb  -o /tmp/cuda-keyring.deb && \
    dpkg --install /tmp/cuda-keyring.deb && rm /tmp/cuda-keyring.deb && \
    apt update && apt install -y --no-install-recommends \
      libnvidia-compute-535 \
      libnvidia-ml-dev \
      nvidia-utils-535 && \
      apt clean && \
      rm -rf /var/lib/apt/lists/* && \
      echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
      deluser --remove-home ubuntu 