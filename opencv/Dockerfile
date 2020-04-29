############################################################
# Dockerfile for computer vision based on pytorch and OpenCV
############################################################
FROM endertekin/jupyter
MAINTAINER Ender Tekin <ender.tekin@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Install git, python and some other image libraries that opencv needs, install tensorflow, install opencv, cleanup
RUN apt-get update && \
	apt-get -y upgrade && \
    apt-get install -y -q cmake liblog4cxx-dev libboost-dev libboost-program-options-dev \
  		libboost-filesystem-dev libjpeg-dev libpng-dev \
		libavcodec-dev libavformat-dev libswscale-dev libavutil-dev \
		tesseract-ocr libtesseract-dev && \
    apt-get autoremove && \
    apt-get clean
	
#Install python bindings for tesseract
RUN /usr/bin/env python3 -m pip install pytesseract

#Build & install opencv, then remove source to reduce size of image
WORKDIR /tmp
RUN mkdir opencv && \
    cd opencv && \
    git clone --depth 1 https://github.com/opencv/opencv.git && \
    git clone --depth 1 https://github.com/opencv/opencv_contrib.git && \
    mkdir build && \ 
    cd build && \
 	cmake -D CMAKE_BUILD_TYPE=RELEASE \
 	    -D CMAKE_INSTALL_PREFIX=/usr/local \
 	    -D BUILD_EXAMPLES=OFF -D BUILD_opencv_apps=OFF \
 	    -D BUILD_DOCS=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
 	    -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
 		-D BUILD_opencv_python3=ON \
 	    ../opencv && \
 	make && \
 	make install && \
 	rm -rf /tmp/opencv

# Set up and launch jupyter notebook
WORKDIR /tmp
COPY scripts /tmp/scripts
# Expose the ports for jupyter notebook and tensorboard
EXPOSE 8888
CMD ["/tmp/scripts/launch_jupyter.sh"]
