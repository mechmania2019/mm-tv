#!/bin/sh

set -eu

visualizer=/visualizer/MM_LinuxCombined_PlayerSettings.x86_64
chmod +x $visualizer

password="corgi"

# Start X Server
export DISPLAY="${DISPLAY:-:0}"
Xvfb $DISPLAY -screen 0 1280x800x24 &

# Start streaming
ffmpeg -f x11grab -s 1280x800 -framerate 15 -i $DISPLAY -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -threads 0 -f flv "rtmp://live.twitch.tv/app/live_59563742_VbqqKX5asQE66w1rIp7LcyWZ0BjtMA" &

sleep 2

# Start VNC
x11vnc --passwd "$password" -display $DISPLAY -xkb -forever -noxdamage -noxrecord -noxfixes -nopw -wait 16 -shared -bg

# Start fluxbox
/usr/bin/startfluxbox &

# Start games
sleep 5
/root/start.sh

# Start playing games
# while true; do
#     curl -sSL https://tv.mechmania.io > $logpath
#     $visualizer $logpath
# done;