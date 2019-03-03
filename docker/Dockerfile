FROM ubuntu:18.04
MAINTAINER dch.tai@gmail.com

RUN apt-get update && apt-get install -y \
    gnupg2

RUN echo "deb http://ppa.launchpad.net/elementary-os/daily/ubuntu bionic main" >> /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/elementary-os/daily/ubuntu bionic main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BF36996C4E1F8A59

RUN apt-get update && apt-get install -y \
    gtk+-3.0 \
    libgranite-common gir1.2-granite-1.0 libgranite4 \
    libgtk-3.0 \
    libgee-0.8-2 \
    libxml2 \
    libgtksourceview-3.0-1 \
    libclutter-gtk-1.0-0 \
    libcairo2 \
    meson \
    desktop-file-utils \
    appstream-util \
    io.elementary.vala-lint \
    valac

ADD build-akira-docker.sh /build.sh
RUN chmod 755 /build.sh

ENTRYPOINT /build.sh
