FROM ubuntu:22.04
RUN apt update && apt install -y sudo python3 python3-pip python3-venv git libgl1 libglib2.0-0 pciutils google-perftools \
 gcc wget bash-completion bc vim && apt clean
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 0
RUN update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 0
RUN pip install --upgrade pip
RUN useradd -m -s /bin/bash -G sudo stable-diffusion
WORKDIR /home/stable-diffusion
ADD main.sh .
RUN chown stable-diffusion main.sh
USER stable-diffusion
ENTRYPOINT ["./main.sh"]


