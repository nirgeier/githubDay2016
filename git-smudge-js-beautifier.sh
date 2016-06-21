#!/bin/bash

rm -rf git-demo1
git init git-demo1
cd git-demo1

echo '*.js filter=jsbeautify' > .gitattributes
echo 'This is the default commit message' > .gitmessage.txt
git config commit.template .gitmessage.txt

git add .gitattributes
git add .gitmessage.txt

git commit -m "Commited intial files"

sudo npm install -g js-beautify
wget https://code.jquery.com/jquery-migrate-1.4.1.min.js

git config --local filter.jsbeautify.clean "js-beautify -f -"
git config --local filter.jsbeautify.smudge cat

git add .
git commit -m "Added beautified jquery"

