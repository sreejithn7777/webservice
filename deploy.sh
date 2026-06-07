#!/bin/bash

APP_DIR=/var/lib/jenkins/webservice
REPO_URL=https://github.com/<username>/<repo>.git

if [ ! -d "$APP_DIR/.git" ]; then
    git clone "https://github.com/sreejithn7777/webservice.git" "$APP_DIR"
fi

cd "$APP_DIR" || exit 1

git pull origin main

pip3 install -r requirements.txt

pkill -f app.py || true

nohup python3 app.py > app.log 2>&1 &