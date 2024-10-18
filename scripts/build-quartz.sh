#!/bin/bash

QUARTZ_DIR="/usr/src/app/quartz"

cd $QUARTZ_DIR

echo "Running Quartz build..."
npx quartz build --directory /vault --output /usr/share/nginx/html

if [ $? -eq 0 ]; then
  echo "Quartz build completed successfully."
else
  echo "Quartz build failed."
  exit 1
fi
