#!/bin/bash

# Output colors
red='\033[0;31m';
green='\033[0;32m';
yellow='\033[0;33m';
default='\033[0;m';
	
echo ''
echo -e $red'Deleteing old folder'

rm -rf git-smudge-merge > /dev/null 2>&1
mkdir git-smudge-merge > /dev/null 2>&1
cd git-smudge-merge > /dev/null 2>&1

echo -e $green'Creating new repository'
git init  > /dev/null 2>&1

echo -e $default'Setting the config merge.our.driver to '$green'true'$default' [to support our gitattribute merge]'

git config merge.ours.driver true
git commit --allow-empty -m "Initial commit" > /dev/null 2>&1

echo -e 'Mark the ['$green'data.json merge=ours'$default'][' $yellow $(git branch | grep "*") $default '] in .gitattributes'
echo ''

echo 'data.json merge=ours' >> .gitattributes
git add .gitattributes > /dev/null 2>&1
git commit -m 'Preserve data.json during merges' > /dev/null 2>&1

echo 'Line from master' > shared-file
git add shared-file > /dev/null 2>&1
git commit -m 'Demo: a file that will merge normally' > /dev/null 2>&1
git checkout -b demo-branch 

echo ''
echo 'Write the data.json file in [demo-branch]'
echo ''

echo '{"data" : "This is the demo-branch content ..."}' > data.json
git add data.json > /dev/null 2>&1
git commit -m 'Commit original: production data.json' > /dev/null 2>&1

echo "Line from demo-branch" >> shared-file
git commit -am 'fix(demo): Header for the normal-merge file' > /dev/null 2>&1

git checkout -

echo ''
echo 'Write the data.json file in [master]'
echo ''

echo '{"data" : "This is the line from master ..."}' > data.json
git add data.json > /dev/null 2>&1
git commit -m 'Commit master data.json' > /dev/null 2>&1

echo "Line from demo-branch" >> shared-file
git commit -am 'fix: Footer for the normal-merge file' > /dev/null 2>&1

echo ''
echo 'Checkout demo-branch'
echo ''

git checkout demo-branch

echo ''
echo 'Merge demo-branch with master'
echo ''

GIT_EDITOR=true git merge -
git branch 
cat data.json
