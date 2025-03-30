FROM ubuntu:24.04
ARG USER_ID
RUN apt update && apt dist-upgrade -y && apt install -y sudo git libgl1 libglib2.0-0 pciutils google-perftools \
 gcc wget bash-completion bc vim passwd curl mc \
 make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
 && apt clean
RUN deluser --remove-all-files ubuntu
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN useradd -m -s /bin/bash -g users -G sudo --uid ${USER_ID} stable-diffusion

WORKDIR /home/stable-diffusion

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-keyring_1.1-1_all.deb
RUN dpkg --install cuda-keyring_1.1-1_all.deb && rm cuda-keyring_1.1-1_all.deb
RUN apt update && apt install -y cuda-toolkit-12-6 cudnn9-cuda-12 && apt clean

USER stable-diffusion
COPY install-python.sh .
RUN ./install-python.sh
COPY main.sh .
ENTRYPOINT ["./main.sh"]




