FROM nvidia/opengl:1.0-glvnd-runtime

# FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/ffmpeg-3 && \
    apt-get update && \
    apt-get install -y xvfb x11vnc x11-xserver-utils ffmpeg x264 curl mesa-utils fluxbox wbar binutils module-init-tools
# RUN apt-get install -y nvidia-384
# RUN apt-get install -y // 29, 1
#     dpkg-reconfigure xserver-xorg

# configure fluxbox
ADD fluxbox/menu /usr/share/fluxbox/menu
ADD fluxbox/keys /usr/share/fluxbox/keys
ADD fluxbox/init /usr/share/fluxbox/init
ADD fluxbox/startup /usr/share/fluxbox/startup
ADD fluxbox/apps /usr/share/fluxbox/apps
ADD init-env.sh /init-env.sh

RUN cp -r /usr/share/fluxbox /root/.fluxbox

RUN chmod a+x /root/.fluxbox/startup
RUN chmod a+x /init-env.sh

# Configure x apps
ADD bg.png /bg.png

# Install nvidia drivers
ADD nvidia-driver.run /tmp/nvidia-driver.run
RUN sh /tmp/nvidia-driver.run -a -N --ui=none --no-kernel-module
RUN rm /tmp/nvidia-driver.run

# add the game setup stuff
COPY visualizer /visualizer
COPY games.sh ./games.sh
COPY start.sh ./root/start.sh
EXPOSE 5900
CMD ./games.sh