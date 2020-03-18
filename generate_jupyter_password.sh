#!/bin/bash

function usage {
    echo "Usage: $0 [-h|--help] <password>"
    echo " -h       Print usage"
	echo " <password> the plain text password to use. This will be stored in hashed form in pwd.txt"
}

if [ "$#" -ne 1 ]; then 
    echo "Error: Must pass exactly one password."
	exit 1
fi

PWD=$1
case $PWD in
    -h|--help)
        usage
        exit 0
esac

RUNTIME_OPTS=(-d --init)
RUNTIME_OPTS+=(-v $(pwd):/tmp/pwd)
RUNTIME_OPTS+=(-w /tmp/pwd)
docker run ${RUNTIME_OPTS[@]} --name passgen endertekin/jupyter /tmp/scripts/generate_password.py $PWD
