FROM ubuntu:24.04
LABEL maintainer="Sergey Grigoriev <s.a.grigoriev@gmail.com>"
LABEL description="Ubuntu-based image with CUDA and Python, tailored for Stable Diffusion"

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y \
        bash-completion \
        bc \
        build-essential \
        curl \
        gcc \
        git \
        google-perftools \
        libbz2-dev \
        libffi-dev \
        libgl1 \
        libglib2.0-0 \
        liblzma-dev \
        libncursesw5-dev \
        libreadline-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        libxmlsec1-dev \
        llvm \
        make \
        nvidia-driver-535 \
        mc \
        passwd \
        pciutils \
        sudo \
        tk-dev \
        vim \
        wget \
        zlib1g-dev && \
    apt clean
RUN curl https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb  -o /tmp/cuda-keyring.deb && \
    dpkg --install /tmp/cuda-keyring.deb && rm /tmp/cuda-keyring.deb && \
    apt update && apt install -y cuda-toolkit-12-6 cudnn9-cuda-12 &&  \
    apt clean
    
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN useradd -m -s /bin/bash -g users -G sudo artist
WORKDIR /home/artist
USER artist

COPY install-python.sh /tmp/
RUN /tmp/install-python.sh
