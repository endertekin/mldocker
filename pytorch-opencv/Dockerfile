############################################################
# Dockerfile for computer vision based on pytorch and OpenCV
############################################################
FROM endertekin/pytorch
MAINTAINER Ender Tekin <ender.tekin@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

#Install git, python and some other image libraries that opencv needs, install tensorflow, install opencv, cleanup
RUN apt-get update && \
	apt-get -y upgrade && \
    apt-get install -y -q cmake git libjpeg-dev libpng-dev \
		libavcodec-dev libavformat-dev libswscale-dev libavutil-dev \
		libtesseract-dev && \
    apt-get autoremove && \
    apt-get clean
	
#Build & install opencv, then remove source to reduce size of image
WORKDIR /tmp
RUN mkdir opencv && \
    cd opencv && \
    git clone --depth 1 https://github.com/opencv/opencv.git && \
    git clone --depth 1 https://github.com/opencv/opencv_contrib.git && \
    mkdir build

WORKDIR /tmp/opencv/build
RUN	cmake -D CMAKE_BUILD_TYPE=RELEASE \
 	    -D CMAKE_INSTALL_PREFIX=/usr/local \
 	    -D BUILD_EXAMPLES=OFF -D BUILD_opencv_apps=OFF \
 	    -D BUILD_DOCS=OFF -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF \
 	    -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
 		-D BUILD_opencv_python3=ON \
		-D PYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")  \
		-D PYTHON_LIBRARY=$(python -c "import distutils.sysconfig as sysconfig; print(sysconfig.get_config_var('LIBDIR'))") \
 	    ../opencv && \
 	make && \
 	make install && \
 	rm -rf /tmp/opencv

# Set up and launch jupyter notebook
WORKDIR /tmp
COPY scripts /tmp/scripts
# Expose the ports for jupyter notebook and tensorboard
EXPOSE 8888 6006
CMD ["/tmp/scripts/launch_jupyter.sh"]
