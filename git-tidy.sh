#!/usr/bin/env bash
set -e
branch=$(git rev-parse --abbrev-ref HEAD)
if [ "${branch}" == "master" ] || [ "${branch}" == "production" ]
then
  echo "On ${branch} branch - this ain't it, chief."
  exit 1
fi
if git branch | grep -q master
then
  mainbranch="master"
elif git branch | grep -q production
then
  mainbranch="production"
else
  echo "can't determine main branch - bailing"
  exit 1
fi
git checkout "${mainbranch}"
git pull
git branch -d "${branch}"
git remote prune origin
