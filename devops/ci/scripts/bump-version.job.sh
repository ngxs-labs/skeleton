#!/usr/bin/env bash

apt-get install jq

bumpAction=patch
description=$(echo "$TRAVIS_COMMIT_NAME" | sed -r '/^\s*$/d' | awk '{print tolower($0)}')

for type in breaking, perf, major; do
  if [[ $description =~ ^"$type".* ]]; then
    bumpAction=major
  fi
done

for type in feat, refactor, minor; do
  if [[ $description =~ ^"$type".* ]]; then
    bumpAction=minor
  fi
done

latestVersion=$(cat ./package.json | jq -r ".version")

export VERSION=$(./devops/ci/scripts/semver.sh bump $bumpAction $latestVersion)

echo "Gonna bump version"

jq ".version=env.VERSION" ./package.json > /tmp/tmp.$$.json && mv /tmp/tmp.$$.json ./package.json

function pushToGitWithTags {
  echo "Gonna login to the git using access token"

  ./devops/ci/scripts/login-to-git.sh

  echo "Gonna push to the git"

  git add .
  git commit -m "$VERSION" --no-verify
  git tag -a "v$VERSION" -m "$VERSION"
  git push origin HEAD:master --tags
}

pushToGitWithTags
