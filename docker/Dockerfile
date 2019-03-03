FROM ubuntu:18.04
MAINTAINER dch.tai@gmail.com

RUN apt-get update && apt-get install -y \
    gtk+-3.0 \
    libgranite-common \
    libgtk-3.0 \
    libgee-0.8-2 \
    libxml2 \
    libgtksourceview-3.0-1 \
    libclutter-gtk-1.0-0 \
    libcairo2 \
    meson \
    valac

ADD build-akira-docker.sh /build.sh
RUN chmod 755 /build.sh

ENTRYPOINT /build.sh

#    gobject \
#    clutter \
