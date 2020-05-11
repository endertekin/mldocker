#!/bin/bash
function usage {
    echo "Usage: $0 [-h|--help] <name>"
    echo " -h       Print usage"
	echo " <name>   which container to build."
}

if [ "$#" -ne 1 ]; then 
    echo "Error: Must pass exactly one container name."
	exit 1
fi

NAME=$1
case $NAME in
    -h|--help)
        usage
        exit 0
esac

TAG=`git rev-parse --abbrev-ref HEAD`
if [ "$TAG" == "master" ]; then
    TAG="latest"
fi
echo "Building Dockerfile..."
docker build -t "endertekin/$NAME":"$TAG" -f ${NAME}/Dockerfile .
