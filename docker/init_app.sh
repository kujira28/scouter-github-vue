#!/bin/bash

BRANCH=$1

mkdir -p /var/www/
cd /var/www
git clone -b ${BRANCH} ${REPO_URL_GITHUB_VUE}
cd scouter-github-vue
npm install
npm run build
