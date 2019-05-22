#!/usr/bin/env bash

docker run \
  -v $PWD:/tmp/src \
  --name $APPVEYOR_JOB_ID \
  node:11 /bin/bash -c \
  "mkdir /tmp/build && cp -a /tmp/src/. /tmp/build && cd /tmp/build && yarn --pure-lockfile --non-interactive --no-progress && yarn say-hello"
