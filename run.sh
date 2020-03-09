#!/bin/bash

function usage {
    echo "Usage: $0 [-g] [-h|--help] [-t|--tag tag]"
    echo " -g       Use GPU, Turns on the nvidia-docker environment"
    echo " -h       Print usage"
    echo " -t tag   Specify a tag for the docker image to use"
}

if [ -z "$1" ]; then
    usage
    exit 1
fi

TAG=latest
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -g|--gpu)
        GPU=yes
        shift # past argument
        ;;
    -t|--tag)
        TAG="$2"
        shift # past argument
        shift # past value
        ;;
    -h|--help)
        usage
        exit 0
esac
done

if [ "$GPU" = yes ]; then
    RUNTIME_OPTS = "--runtime=nvidia"
else
    RUNTIME_OPTS = ""
fi


docker run -d --rm -p 8888:8888 -p 6006:6006 \
    -v $(pwd)/private:/etc/notebook \
    -v $(pwd)/notebooks:/tmp \
	-v $(pwd)/jupyter_cfg:/root/.jupyter \
    -v /tmp/tflogs:/tmp/tflogs \
    -w /tmp \
    --name mlengine "${RUNTIME_OPTS}" --init endertekin/mldocker:"${TAG}"
