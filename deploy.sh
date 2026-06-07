APP_DIR=/var/lib/jenkins/webservice
REPO_URL=https://github.com/sreejithn7777/webservice.git
PORT=5001
VENV_DIR="$APP_DIR/venv"

echo "=== Clone or update repo ==="

if [ ! -d "$APP_DIR/.git" ]; then
    git clone "$REPO_URL" "$APP_DIR"
fi

cd "$APP_DIR" || exit 1

git pull origin main

echo "==== App Directory: $APP_DIR ===="

echo "=== Create virtual environment if not exists ==="

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv venv
    echo "Virtual environment created"
fi

echo "=== Activate virtual environment ==="
source venv/bin/activate

echo "=== Upgrade pip ==="
pip install --upgrade pip

echo "=== Install dependencies ==="
pip install -r requirements.txt

echo "=== Stopping old Flask app ==="

# Kill process using port (most reliable)
fuser -k ${PORT}/tcp 2>/dev/null || true

# Extra safety cleanup
pkill -f "app.py" 2>/dev/null || true

sleep 2

echo "=== Starting app ==="

nohup python3 app.py > app.log 2>&1 &

echo "=== App started successfully on port $PORT ==="