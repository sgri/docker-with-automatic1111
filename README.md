# Overview

This project builds and runs a Docker image with
the [AUTOMATIC1111](https://github.com/AUTOMATIC1111/stable-diffusion-webui) web interface for Stable Diffusion. The
image is optimized for Nvidia GPUs.

# System Requirements

## Hardware

* Nvidia GPU

## Software

* Linux
* Docker
* Nvidia CUDA verstion 12.2 or later.

# Running the Image

To start the image, use:

```bash
cd automatik1111
./run.sh --listen --xformers
```

When running the script for the first time, it will take a while to install Automatik1111 in the
***${HOME}/.local/share/automatik1111*** folder on your machine. This installation is persistent, so subsequent runs
will skip the installation step and use the existing setup.
The web interface will be available at [http://127.0.0.1:7860/](http://127.0.0.1:7860/).

All the arguments passed to run.sh are forwarded
to [webui.sh](https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/webui.sh). Run the following command to list available arguments:

```bash
./run.sh --help
```

## Integration with Open WebUI

If you want to generate images in [Open WebUI](https://github.com/open-webui/open-webui) using Stable Diffusion, then
enable the API:

```bash
./run.sh --api --xformers --listen
```

## Running XL Models on Low VRAM

If you run an XL model which doesn't fit into VRAM, then you may get OutOfMemory errors. In that case, add the --medvram-sdxl option.

```bash
./run.sh --listen --xformers --medvram-sdxl
```
# Stopping the Container
To stop the container, use:

```bash
$ docker stop automatik1111
```
You can also interrupt the `run.sh` by pressing `Ctrl+C` 3 times.