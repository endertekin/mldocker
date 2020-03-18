#!/bin/bash

function usage {
    echo "Usage: $0 [-g] [-h|--help] [-t|--tag tag] <container>"
    echo " -g       Use GPU, Turns on the nvidia-docker environment"
    echo " -h       Print usage"
    echo " -t tag   Specify a tag for the docker image to use. Default is 'latest'"
	echo " <container> Name of the container to use, launches endertekin/<container>:<tag>"
}

if [ -z "$1" ]; then
    usage
    exit 1
fi

RUNTIME_OPTS=(-d --init)
RUNTIME_OPTS+=(--rm)
RUNTIME_OPTS+=(-p 8888:8888)
RUNTIME_OPTS+=(-v $(pwd)/private:/etc/notebook)
RUNTIME_OPTS+=(-v $(pwd)/jupyter_cfg:/root/.jupyter)
RUNTIME_OPTS+=(-v $(pwd)/notebooks:/tmp/notebooks)
RUNTIME_OPTS+=(-w /tmp)
RUNTIME_OPTS+=(--name mlengine)

TAG=latest
ARGS=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -g|--gpu)
	    RUNTIME_OPTS+=(--runtime=nvidia)
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
		;;
	* )
		ARGS+=("$1")
		shift
		;;
esac
done

if [[ "${#ARGS[@]}" -ne 1 ]]; then
	echo "Incorrect number of arguments. Container name should be a single word, got '${ARGS[@]}'"
	exit 1
fi

docker run ${RUNTIME_OPTS[@]} endertekin/"${ARGS[0]}":"${TAG}"
