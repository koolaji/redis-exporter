#!/bin/bash

# Redis connection details
REDIS_HOST="127.0.0.1"
REDIS_PORT="6379"
REDIS_PASSWORD="your_password" # Leave empty if no password

# Key to monitor (passed as an argument)
KEY_NAME="$1"

# Check if Redis CLI is installed
if ! command -v redis-cli &> /dev/null; then
  echo "redis-cli not found. Please install Redis CLI."
  exit 1
fi

# Fetch the value of the key
if [ -n "$REDIS_PASSWORD" ]; then
  VALUE=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" -a "$REDIS_PASSWORD" get "$KEY_NAME")
else
  VALUE=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" get "$KEY_NAME")
fi

# Output the value (or an error if the key doesn't exist)
if [ -z "$VALUE" ]; then
  echo "Key not found or empty"
else
  echo "$VALUE"
fi
