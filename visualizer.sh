#!/bin/bash

if command -v python3 >/dev/null 2>&1; then
    pip3 install -r requirements.txt >/dev/null 2>&1
    python3 visualizer.py
else
    echo "Python is not installed. Please install python to run the script."
fi