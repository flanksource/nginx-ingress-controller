#!/bin/bash
set -x

if [[ "$CIRCLE_PR_NUMBER" != "" ]]; then
  echo Skipping release of a PR build
  circleci-agent step halt
  exit 0
fi
NAME=$(basename $(git remote get-url origin | sed 's/\.git//'))
GITHUB_USER=$(basename $(dirname $(git remote get-url origin | sed 's/\.git//')))
GITHUB_USER=${GITHUB_USER##*:}
TAG=$(git describe --tags --abbrev=0 --exact-match)
if [[ "$TAG" == "" ]];  then
  TAG=$(git describe --tags --exclude "*-g*")
fi

VERSION="v$TAG built $(date)"

echo Building docker image

docker build . -t $GITHUB_USER/$NAME:$TAG

echo Pushing docker image
docker login --username $DOCKER_LOGIN --password $DOCKER_PASS
docker push $GITHUB_USER/$NAME:$TAG
