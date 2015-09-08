# Base image for other Stackato images.
#
# The base image serves two purposes:
#   * Install common packages to minimize size of other images
#   * Potentially add configuration as environment variables

FROM ubuntu:12.04

# For future use.
ENV STACKATO_DOCKER True

# Version of Go tarball at /opt/golang. Expected to be used to compile the Go
# components.
ENV GOVERSION 1.2.1

RUN mkdir /docker
ADD Dockerfile.sh clean.sh package_list /docker/
RUN /docker/Dockerfile.sh

ADD stackon.json /
