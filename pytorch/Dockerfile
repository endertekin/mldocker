############################################################
# Dockerfile for machine learning based on pytorch
############################################################

FROM pytorch/pytorch:latest
MAINTAINER Ender Tekin <ender.tekin@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Install git, python and some other image libraries that opencv needs, install tensorflow, install opencv, cleanup
RUN apt-get update && \
	apt-get -y upgrade && \
    apt-get install -y -q apt-utils build-essential vim poppler-utils tesseract-ocr && \
    apt-get autoremove && \
    apt-get clean
RUN /usr/bin/env python3 -m pip install jupyter && \
    /usr/bin/env python3 -m pip install numpy && \
    /usr/bin/env python3 -m pip install scipy && \
    /usr/bin/env python3 -m pip install pillow && \
    /usr/bin/env python3 -m pip install matplotlib && \
    /usr/bin/env python3 -m pip install tqdm && \
    /usr/bin/env python3 -m pip install requests && \
    /usr/bin/env python3 -m pip install torchvision && \
    /usr/bin/env python3 -m pip install pycocotools-fix && \
    /usr/bin/env python3 -m pip install pdf2image && \
    /usr/bin/env python3 -m pip install pdfminer3k && \
    /usr/bin/env python3 -m pip install pytesseract && \
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
