# Overview

This project builds and runs a Docker image with
the [AUTOMATIC1111](https://github.com/AUTOMATIC1111/stable-diffusion-webui) on a Linux machine with an Nvidia GPU.

# System Requirements

## Hardware

* Nvidia GPU

## Software

* Linux
* Docker with GPU support.
* Nvidia CUDA version 12.2 or later.

# Install the Script
Get the latest release of the script:

```bash
curl -L -O https://github.com/sgri/docker-with-automatic1111/releases/latest/download/a1111.sh
chmod +x a1111.sh
```

# Running the Image
Root privileges are not required to run the container and must not be used.

To start the image, use:

```bash
./a1111.sh run --listen --xformers
````

When you run the script for the first time, it will take a while to install Automatic1111 in the
`${HOME}/.local/share/a1111` folder on your machine. This installation is persistent, so subsequent runs
will skip the installation step and use the existing workspace. 

You can place your models in
```${HOME}/.local/share/a1111/stable-diffusion-webui/models```.

Generated images can be found at `${HOME}/.local/share/a1111/stable-diffusion-webui/outputs`.

The web interface will be available at [http://127.0.0.1:7860/](http://127.0.0.1:7860/).

All the arguments passed to run.sh are forwarded
to [webui.sh](https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/webui.sh). Run the following command to list available arguments:

```bash
./a1111.sh run --help
```

## Configuration File

When you run `a1111.sh`, a configuration file is created at `${HOME}/.config/a1111/config.rc` if it does not already exist. This file contains variables to configure the Docker container.

### Setting Environment Variables for WebUI
You can pass environment variables to the container via DOCKER_OPTS in the configuration file. 
For example, to use a custom Stable Diffusion repository, add the following line to the configuration file:
```bash
DOCKER_OPTS="--gpus all -e STABLE_DIFFUSION_REPO=https://github.com/w-e-w/stablediffusion.git"
```

## Integration with Open WebUI

If you want to generate images in [Open WebUI](https://github.com/open-webui/open-webui) using Stable Diffusion, then
enable the API with the --api option:

```bash
./a1111.sh run --api --xformers --listen
```

## Running XL Models on Low VRAM

If you run an XL model which doesn't fit into VRAM, then you may get OutOfMemory errors. In that case, add the --medvram-sdxl option.

```bash
./a1111.sh run --listen --xformers --medvram-sdxl
```
# Stopping the Container
To stop the container, use:

```bash
./a1111.sh stop
```
You can also interrupt `a1111.sh` by pressing `Ctrl+C` 3 times; it will stop the container.
