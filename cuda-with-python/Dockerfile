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
  apt clean && \
  cd  /tmp && \
  wget https://www.python.org/ftp/python/3.10.14/Python-3.10.14.tgz && \
  tar -xzf Python-3.10.14.tgz && \
  pushd Python-3.10.14 && \
  ./configure --prefix=/opt/python-3.10.14 --enable-optimizations && \
  make -j$(nproc) && \
  make altinstall && \
  popd  && \
  rm -R Python-3.10.14 && \
  rm  Python-3.10.14.tgz && \
  ln -s /opt/python-3.10.14/bin/python3.10 /opt/python-3.10.14/bin/python && \
  ln -s /opt/python-3.10.14/bin/pip3.10 /opt/python-3.10.14/bin/pip && \                   
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  useradd -m -s /bin/bash -G sudo artist \
    
WORKDIR /home/artist
USER artist