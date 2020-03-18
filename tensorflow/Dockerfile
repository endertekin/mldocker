############################################################
# Dockerfile to build Python 3.x + Tensorflow latest image
# Based on NVIDIA's Ubuntu-based CUDA images
# See https://www.tensorflow.org/install/install_linux for tensorflow installation instructions
############################################################

FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04
MAINTAINER Ender Tekin <ender.tekin@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Install git, python and some other image libraries that opencv needs, install tensorflow, install opencv, cleanup
RUN apt-get update && \
apt-get -y upgrade && \
    apt-get install -y -q \
        apt-utils build-essential git vim \
        python3.8 python3.8-dev python3-pip && \
    apt-get autoremove && \
    apt-get clean && \
    /usr/bin/env python3 -m pip install jupyter && \
    /usr/bin/env python3 -m pip install numpy && \
    /usr/bin/env python3 -m pip install matplotlib && \
    /usr/bin/env python3 -m pip install tqdm && \
    /usr/bin/env python3 -m pip install requests && \
    /usr/bin/env python3 -m pip install protobuf && \
    /usr/bin/env python3 -m pip install tensorflow-gpu && \
    /usr/bin/env python3 -m pip install jupyter_nbextensions_configurator && \
    /usr/bin/env python3 -m pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user

# Set up and launch jupyter notebook
WORKDIR /tmp
COPY scripts /tmp/scripts
# Expose the ports for jupyter notebook and tensorboard
EXPOSE 8888 6006
CMD ["/tmp/scripts/launch_jupyter.sh"]
