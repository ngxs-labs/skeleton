#!/usr/bin/env bash

GREEN="\e[92m"

files=(
  devops/definitions.sh
  devops/ci/scripts/build-test.job.sh
  devops/ci/scripts/bump-version.job.sh
  devops/ci/scripts/login-to-git.sh
)

for file in ${files[*]}; do
  chmod +x ./${file}
  echo -e "$GREEN Successfully changed mod for file: $file"
done

echo -e "$GREEN Successfully changed mod for all files"
