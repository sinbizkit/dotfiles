#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1
echo "---" > /home/sinbizkit/polybar1.log
polybar main_bar 2>&1 | tee -a /tmp/polybar1.log & disown

echo "Bar launched..."
