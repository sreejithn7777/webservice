#!/bin/bash
sudo su
APP_DIR=/home/ec2-user/webservice

if [ ! -d "$APP_DIR" ]; then
    git clone https://github.com/sreejithn7777/webservice.git $APP_DIR
fi

cd $APP_DIR

git pull

pip3 install -r requirements.txt

pkill -f app.py || true

nohup python3 app.py > app.log 2>&1 &