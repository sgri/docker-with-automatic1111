FROM ubuntu:24.04
ARG USER_ID
RUN apt update && apt dist-upgrade -y && apt install -y sudo git libgl1 libglib2.0-0 pciutils google-perftools \
 gcc wget bash-completion bc vim passwd curl \
 make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
 && apt clean
RUN deluser --remove-all-files ubuntu
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN useradd -m -s /bin/bash -g users -G sudo --uid ${USER_ID} stable-diffusion

WORKDIR /home/stable-diffusion
USER stable-diffusion
ADD install-python.sh .
RUN ./install-python.sh
ADD main.sh .
ENTRYPOINT ["./main.sh"]




