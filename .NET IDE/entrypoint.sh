#!/bin/bash

echo "Starting Xvfb"
Xvfb :1 -screen 0 1920x900x16 &
XVFB_PID=$!
sleep 5  # Give Xvfb some time to start

echo "Setting DISPLAY environment variable"
export DISPLAY=:1

# Check if Xvfb started successfully
if ! pgrep -x "Xvfb" > /dev/null; then
    echo "Xvfb failed to start"
    exit 1
fi

echo "Starting x11vnc"
x11vnc -display :1 -forever -passwd password &

echo "Starting noVNC"
websockify --web=/usr/share/novnc/ 6080 localhost:5900 &

echo "Starting JetBrains Rider"
/opt/rider/bin/rider.sh &
RIDER_PID=$!
sleep 10  # Give JetBrains Rider some time to start

# Check if JetBrains Rider started successfully
if ! pgrep -f "rider" > /dev/null; then
    echo "JetBrains Rider failed to start"
    exit 1
fi

echo "JetBrains Rider started successfully"

# Monitor processes and keep the container running
while true; do
    if ! kill -0 $XVFB_PID > /dev/null 2>&1; then
        echo "Xvfb process has exited"
        exit 1
    fi
    
    if ! kill -0 $RIDER_PID > /dev/null 2>&1; then
        echo "JetBrains Rider process has exited"
        exit 1
    fi
    
    sleep 60
done




