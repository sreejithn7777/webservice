APP_DIR=/var/lib/jenkins/webservice
REPO_URL=https://github.com/sreejithn7777/webservice.git

PORT=5001

echo "=== Clone or update repo ==="
if [ ! -d "$APP_DIR/.git" ]; then
    git clone "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR" || exit 1

echo "====App Directory: $APP_DIR===="

pip install -r requirements.txt

echo "=== Stopping old Flask app ==="

# Find process using port 5001 (BEST METHOD)
PID=$(lsof -t -i:$PORT || true)

if [ ! -z "$PID" ]; then
    echo "Killing process using port $PORT → PID $PID"
    kill -9 $PID || true
else
    echo "No process found on port $PORT"
fi

echo "=== Starting app ==="

python3 app.py 
echo "App started"