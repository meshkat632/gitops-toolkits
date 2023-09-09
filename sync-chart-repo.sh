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
#SOPS_AGE_KEY=${args[SOPS_AGE_KEY]}


echo "tagName: $tagName"
echo "sourceRepo: $sourceRepo"
echo "sourceBranch: $sourceBranch"
echo "targetRepo: $targetRepo"
echo "targetBranch: $targetBranch"
echo "GITHUB_TOKEN: $GITHUB_TOKEN"
echo "GITHUB_USER: $GITHUB_USER"
#echo "SOPS_AGE_KEY: $SOPS_AGE_KEY"

echo "################################################################################################################"
mkdir -p "temp-$BUILD_TIME"
#git clone git@github.com:ververica/vvc-portal.git "temp-$BUILD_TIME/targetRepo"
#git status
#ls -ltr

git clone --branch main https://${GITHUB_USER}:${GITHUB_TOKEN}@github.com/ververica/vvc-portal-ui-chart "temp-$BUILD_TIME/targetRepo"
cd "temp-$BUILD_TIME/targetRepo"
git status
ls -ltr
cat argocd/environments/dev/vvc-portal/values.yaml
#export SOPS_AGE_KEY=$SOPS_AGE_KEY
./scripts/sops-utils.sh decryptFile argocd/environments/dev/vvc-portal/values.yaml
cat argocd/environments/dev/vvc-portal/values.yaml


yq -i e '.vvc-portal.portal.imageTag = vvc-portal-ui:d099bb7-20230712-104112' argocd/environments/dev/vvc-portal/values.yaml
cat argocd/environments/dev/vvc-portal/values.yaml
echo "################################################################################################################"
