#!/bin/bash

function usage {
    echo "Usage: $0 [-g] [-h|--help]"
    echo " -g       Also builds the GPU version"
    echo " -h       Print usage"
}

if [ -z "$1" ]; then
    usage
    exit 1
fi

while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -g|--gpu)
        GPU=yes
        shift # past argument
        ;;
    -h|--help)
        usage
        exit 0
esac
done

IMAGE_NAME="endertekin/mldocker"
TAG=`git rev-parse --abbrev-ref HEAD`
if [ "$TAG" == "master" ]; then
    TAG="latest"
fi
echo "Building Dockerfile..."
docker build -t "$IMAGE_NAME":"$TAG" .


if [ "$GPU" = yes ]; then
    echo "Building Dockerfile-gpu..."
    docker build -f Dockerfile-gpu -t "$IMAGE_NAME":gpu-"$TAG" .
fi




