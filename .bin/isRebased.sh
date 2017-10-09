#!/usr/bin/env bash

BASE_BRANCH=${1:-develop}
BRANCH=`git rev-parse --abbrev-ref HEAD`

git checkout $BASE_BRANCH
git pull
DEV_HEAD=`git rev-parse HEAD`

git checkout $BRANCH
git pull
CURRENT_HEAD=`git rev-parse HEAD`

if [ "$(git rev-parse $DEV_HEAD)" == "$(git merge-base $DEV_HEAD $CURRENT_HEAD)" ]; then
  echo Current branch is rebased on $BASE_BRANCH
  exit 0
else
  echo Current branch is rebased on NOT $BASE_BRANCH
  exit 1
fi
