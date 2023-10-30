#!/bin/bash
IMG_NAME=apluslms/grader
DIR=$(dirname $0)
TAG=$(cat $DIR/tag)
ITERATION=00
for i in $(seq -w 0 99); do
  ITERATION=$i
  if ! docker manifest inspect $IMG_NAME:$TAG-$ITERATION; then
    break
  fi
done
IMG_NAME_FULL=$IMG_NAME:$TAG-$ITERATION
echo "Building and pushing $IMG_NAME_FULL"

docker build --no-cache --build-arg TAG=$TAG -t $IMG_NAME_FULL $DIR && docker push $IMG_NAME_FULL
