############################################################
# Dockerfile for computer vision based on pytorch and OpenCV
############################################################
FROM debian:stable-slim
MAINTAINER Ender Tekin <ender.tekin@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Install git, python and some other image libraries that opencv needs, install tensorflow, install opencv, cleanup
RUN apt-get update && \
	apt-get -y upgrade && \
    apt-get install -y -q apt-utils build-essential git vim \
		python3.7 python3.7-dev python3-pip && \
    apt-get autoremove && \
    apt-get clean
RUN /usr/bin/env python3 -m pip install jupyter && \
    /usr/bin/env python3 -m pip install numpy && \
    /usr/bin/env python3 -m pip install scipy && \
    /usr/bin/env python3 -m pip install pillow && \
    /usr/bin/env python3 -m pip install matplotlib && \
    /usr/bin/env python3 -m pip install tqdm && \
    /usr/bin/env python3 -m pip install requests && \
    /usr/bin/env python3 -m pip install ipywidgets && \
    /usr/bin/env python3 -m pip install jupyter_nbextensions_configurator && \
    /usr/bin/env python3 -m pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user

# Set up and launch jupyter notebook
WORKDIR /tmp
COPY scripts /tmp/scripts
# Expose the ports for jupyter notebook and tensorboard
EXPOSE 8888
CMD ["/tmp/scripts/launch_jupyter.sh"]
