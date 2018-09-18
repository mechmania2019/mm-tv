# FROM queeno/ubuntu-desktop
FROM ubuntu:16.04
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:jonathonf/ffmpeg-3 && \
    apt-get update && \
    apt-get install -y xvfb x11vnc x11-xserver-utils ffmpeg x264 curl
RUN apt-get install -y fluxbox wbar

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
ADD logo.png /logo.png
ADD .wbar /root/.wbar

# add the game setup stuff
COPY visualizer /visualizer
COPY games.sh ./games.sh
COPY start.sh ./root/start.sh
EXPOSE 5900
CMD ./games.sh