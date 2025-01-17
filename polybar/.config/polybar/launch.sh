#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1
for m in $(polybar --list-monitors | cut -d":" -f1); do
    echo "---" > /home/sinbizkit/polybar-$m.log
    MONITOR=$m polybar --reload main_bar 2>&1 | tee -a /tmp/polybar-$m.log & disown
done

echo "Bar launched..."
