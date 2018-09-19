#!/bin/sh

set -eu

export VISUALIZER="/visualizer/MM_LinuxCombined_After5.x86_64"
chmod +x $VISUALIZER

password="corgi"

# Fix opengl
# rm /usr/lib/**/libGL.* ||:
rm /usr/local/lib/**/libGL.* ||:
# rm /lib/**/libGL.* ||:
ldconfig all ||:
ldconfig ||:

nvidia-xconfig

# Start X Server
export DISPLAY="${DISPLAY:-:0}"
Xvfb $DISPLAY -nocursor -screen 0 1280x800x24 &

# Start streaming
ffmpeg -f x11grab -s 1280x800 -framerate 15 -draw_mouse 0 -i $DISPLAY -c:v libx264 -preset fast -pix_fmt yuv420p -s 1280x800 -threads 0 -f flv "rtmp://live.twitch.tv/app/live_59563742_VbqqKX5asQE66w1rIp7LcyWZ0BjtMA" &

sleep 2

# Start VNC
x11vnc --passwd "$password" -display $DISPLAY -xkb -forever -noxdamage -noxrecord -noxfixes -nopw -wait 16 -shared -bg

# Start fluxbox
/usr/bin/startfluxbox &

# Start games
sleep 5
/root/start.sh