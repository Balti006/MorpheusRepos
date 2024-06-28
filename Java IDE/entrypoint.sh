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

echo "Starting IntelliJ IDEA"
/opt/intellij/bin/idea.sh &
INTELLIJ_PID=$!
sleep 10  # Give IntelliJ IDEA some time to start

# Check if IntelliJ IDEA started successfully
if ! pgrep -f "idea.Main" > /dev/null; then
    echo "IntelliJ IDEA failed to start"
    exit 1
fi

echo "IntelliJ IDEA started successfully"

# Monitor processes and keep the container running
while true; do
    if ! kill -0 $XVFB_PID > /dev/null 2>&1; then
        echo "Xvfb process has exited"
        exit 1
    fi
    
    if ! kill -0 $INTELLIJ_PID > /dev/null 2>&1; then
        echo "IntelliJ IDEA process has exited"
        exit 1
    fi
    
    sleep 60
done

