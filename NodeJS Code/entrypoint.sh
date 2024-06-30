#!/bin/bash

echo "Starting code-server"
code-server --bind-addr 0.0.0.0:8080 --auth none &
CODESERVER_PID=$!
sleep 10  # Give code-server some time to start

# Check if code-server started successfully
if ! pgrep -f "code-server" > /dev/null; then
    echo "code-server failed to start"
    exit 1
fi

echo "code-server started successfully"

# Monitor processes and keep the container running
while true; do
    if ! kill -0 $CODESERVER_PID > /dev/null 2>&1; then
        echo "code-server process has exited"
        exit 1
    fi
    
    sleep 60
done
