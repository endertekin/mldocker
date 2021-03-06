############################################################
# Dockerfile for machine learning based on pytorch
############################################################

FROM pytorch/pytorch:latest
MAINTAINER Ender Tekin <ender.tekin@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Install git, python and some other image libraries that opencv needs, install tensorflow, install opencv, cleanup
RUN apt-get update && \
	apt-get -y upgrade && \
    apt-get install -y -q apt-utils build-essential vim git && \
    apt-get autoremove && \
    apt-get clean
RUN /usr/bin/env python3 -m pip install jupyter && \
	/usr/bin/env python3 -m pip install ipywidgets && \
    /usr/bin/env python3 -m pip install numpy && \
    /usr/bin/env python3 -m pip install scipy && \
    /usr/bin/env python3 -m pip install scikit-learn && \
    /usr/bin/env python3 -m pip install scikit-image && \
    /usr/bin/env python3 -m pip install snorkel && \
    /usr/bin/env python3 -m pip install pandas && \
    /usr/bin/env python3 -m pip install pillow && \
    /usr/bin/env python3 -m pip install matplotlib && \
    /usr/bin/env python3 -m pip install tqdm && \
    /usr/bin/env python3 -m pip install --upgrade cython && \
    /usr/bin/env python3 -m pip install torchvision && \
    /usr/bin/env python3 -m pip install tensorboard && \
#    /usr/bin/env python3 -m pip install pycocotools && \
    /usr/bin/env python3 -m pip install jupyter_nbextensions_configurator && \
    /usr/bin/env python3 -m pip install jupyter_contrib_nbextensions && \
    jupyter contrib nbextension install --user && \
    jupyter nbextensions_configurator enable --user

	#Build pycococtools
WORKDIR /tmp
RUN mkdir /tmp/coco && \
	cd /tmp/coco && \
	git clone --depth 1 https://github.com/cocodataset/cocoapi.git && \
	cd cocoapi/PythonAPI/ && \
	/usr/bin/env python3 setup.py install
	

# Set up and launch jupyter notebook
WORKDIR /tmp
COPY scripts /tmp/scripts
# Expose the ports for jupyter notebook and tensorboard
EXPOSE 8888 6006
CMD ["/tmp/scripts/launch_jupyter.sh"]
