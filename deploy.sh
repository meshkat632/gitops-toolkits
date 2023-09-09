#!/bin/bash

# Read named command line arguments into an args variable

declare -A args

while (( "$#" )); do
    if  [[ $1 == --* ]] && [ "$2" ]; then
        args[${1:2}]=$2
        shift
    fi
    shift
done

# Do the deployment
echo "Hello, bucketname:${args[bucketname]}"
