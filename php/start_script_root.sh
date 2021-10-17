#!/bin/bash

# start cron, and check if it started properly
cron
status=$?

if [ $status -ne 0 ]; then
  echo "Failed to start cron: $status"
  exit $status
fi
