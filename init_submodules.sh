#!/bin/sh

set -e
git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
while read path_key path
do
set +e
echo _adding submodule $path _
url_key=$(echo $path_key | sed 's/\.path/.url/')
branch_key=$(echo $path_key | sed 's/\.path/.branch/')
url=$(git config -f .gitmodules --get "$url_key")
branch=$(git config -f .gitmodules --get "$branch_key")

if [ "$branch" = "" ]
then
    branch="master"
fi
echo url $url
echo path $path
echo branch $branch
set -e
git submodule add $url $path -b $branch
done
