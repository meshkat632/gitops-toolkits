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

BUILD_TIME=$(date '+%Y%m%d%H%M%S')
echo "BUILD_TIME: $BUILD_TIME"
mkdir -p "temp-$BUILD_TIME"


git clone --branch deployments/argo-DEV https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY} "temp-$BUILD_TIME/vvc-portal"

#git clone --branch master https://github.com/ververica/vvc-portal "temp-$BUILD_TIME/vvc-portal-master"



#git clone --branch deployments/env-DEV https://github.com/ververica/vvc-portal "temp-$BUILD_TIME/vvc-portal-deployments-env-DEV"
cd temp-$BUILD_TIME/vvc-portal
echo "#############################"
pwd
git status
echo "#############################"
#git diff deployments/env-DEV origin/master --color > diff.txt
#cat diff.txt
git fetch origin
git reset --hard origin/deployments/pr-branch
git clean -df
#git commit -m "reset to pr-branch at $BUILD_TIME"
#git push
echo "#############################"
pwd
git status
#echo "#############################"
#git push
#git status
