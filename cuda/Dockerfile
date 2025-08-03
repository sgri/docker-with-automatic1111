FROM ubuntu:24.04
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Ubuntu-based image with CUDA"

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        google-perftools \
        kmod \
        libgl1 \
        lsb-release \
        mc \
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
      echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
      useradd -m -s /bin/bash -G sudo artist && \
      deluser --remove-home ubuntu 