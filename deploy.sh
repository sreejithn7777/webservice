#!/bin/bash

APP_DIR=/var/lib/jenkins/webservice
REPO_URL=https://github.com/sreejithn7777/webservice.git

if [ ! -d "$APP_DIR/.git" ]; then
    git clone "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR" || exit 1

git pull origin main

pip3 install -r requirements.txt

pkill -f app.py || true

python3 app.py 