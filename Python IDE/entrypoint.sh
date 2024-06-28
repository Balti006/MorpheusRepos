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

echo "Starting PyCharm"
/opt/pycharm/bin/pycharm.sh &
PYCHARM_PID=$!
sleep 10  # Give PyCharm some time to start

# Check if PyCharm started successfully
if ! pgrep -f "pycharm" > /dev/null; then
    echo "PyCharm failed to start"
    exit 1
fi

echo "PyCharm started successfully"

# Monitor processes and keep the container running
while true; do
    if ! kill -0 $XVFB_PID > /dev/null 2>&1; then
        echo "Xvfb process has exited"
        exit 1
    fi
    
    if ! kill -0 $PYCHARM_PID > /dev/null 2>&1; then
        echo "PyCharm process has exited"
        exit 1
    fi
    
    sleep 60
done


