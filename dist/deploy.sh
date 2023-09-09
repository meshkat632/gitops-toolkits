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

BUILD_TIME=$(date '+%Y%m%d%H%M%S')
tagName=${args[tagName]}
sourceRepo=${args[sourceRepo]}
sourceBranch=${args[sourceBranch]}
targetRepo=${args[targetRepo]}
targetBranch=${args[targetBranch]}
GITHUB_TOKEN=${args[GITHUB_TOKEN]}
GITHUB_USER=${args[GITHUB_USER]}


echo "tagName: $tagName"
echo "sourceRepo: $sourceRepo"
echo "sourceBranch: $sourceBranch"
echo "targetRepo: $targetRepo"
echo "targetBranch: $targetBranch"
echo "GITHUB_TOKEN: $GITHUB_TOKEN"
echo "GITHUB_USER: $GITHUB_USER"

mkdir -p "temp-$BUILD_TIME"

git clone --branch main https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/$targetRepo "temp-$BUILD_TIME/$targetRepo"
cd temp-$BUILD_TIME/$targetRepo
ls -ltr
#git clone --branch master https://github.com/ververica/vvc-portal "temp-$BUILD_TIME/vvc-portal-master"



#git clone --branch deployments/env-DEV https://github.com/ververica/vvc-portal "temp-$BUILD_TIME/vvc-portal-deployments-env-DEV"
#cd temp-$BUILD_TIME/vvc-portal
#echo "#############################"
#pwd
#git status
#echo "#############################"
#git diff deployments/env-DEV origin/master --color > diff.txt
#cat diff.txt
#git fetch origin
#git reset --hard origin/deployments/pr-branch
#git clean -df
#git commit -m "reset to pr-branch at $BUILD_TIME"
#git push
#echo "#############################"
#pwd
#git status
#echo "#############################"
#git push
#git status
