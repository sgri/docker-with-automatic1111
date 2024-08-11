# Overview
This project builds and runs a Docker image with the [AUTOMATIC1111](https://github.com/AUTOMATIC1111/stable-diffusion-webui) web interface for Stable Diffusion. The image is optimized for Nvidia GPUs.

# System Requirements
## Hardware
* Nvidia GPU
## Software
* Linux 
* Docker
* Nvidia CUDA
# Building the Image
To build the image, run:
```bash
$ ./build.sh
```
# Running the Image
To start the image, use:
```bash
./run.sh --port=7860
```
When running the script for the first time, it will take a while to install Stable Diffusion in the ***${HOME}/.stable-diffusion*** folder on your machine. This installation is persistent, so subsequent runs will skip the installation step and use the existing setup.
The web interface will be available at [http://127.0.0.1:7860/](http://127.0.0.1:7860/).

All the arguments passed to  run.sh are forwarded to [webui.sh](https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/webui.sh).

## Integration with Open WebUI
If you want to generate images in [Open WebUI](https://github.com/open-webui/open-webui) using Stable Diffusion, then enable the API:
```bash
./run.sh --port=7860 --api --listen
```
## Running XL Models on Low VRAM
If you run an XL model which doesn't fit into VRAM, then you may get OutOfMemory errors. In that case, add the --medvram-sdxl option:
```bash
./run.sh --port=7860 --api --listen --medvram-sdxl
```
# Final Notes
This project was developed and tested on Ubuntu 24.04. 
