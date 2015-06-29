#!/bin/bash -ex
# Clean up tasks to run before commiting the docker image.
# Use this script to remove unnecessary files to save layer size.
# --


# Apt cache
apt-get -qy clean
rm -rf /var/lib/apt/lists /var/cache/debconf /var/cache/apt
