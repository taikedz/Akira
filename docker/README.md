# Docker build

Use this script to build Akira inside a docker container.

In the host environment, run

    ./build-akira-docker.sh --build-docker

to build the container image, then start a build -- this takes a while, >5min.

If you've already built the docker image before, simply run

    ./build-akira-docker.sh --build-akira

Once the build is complete, you can run `ninja && sudo ninja install` in your host environment.
