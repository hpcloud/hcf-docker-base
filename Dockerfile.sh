#!/bin/bash -ex

DEBIAN_PACKAGES="wget git bzr mercurial"
# The new stackato-deps.
# Manageable at https://horizon.hpcloud.com/project/containers/stackato-deps/
ASSETS_URL="http://a248.e.akamai.net/cdn.hpcloudsvc.com/h39066e7520a2434486279540204b7687/prodaw2/"

# For git 1.9
echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main ' >> /etc/apt/sources.list.d/git-latest.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24
sed 's/main$/main universe/' -i /etc/apt/sources.list
apt-get -qy update

# Golang is used in the alsek stack (for Go buildpack) and to build Go-based
# components. We're leaving it unextracted as that's what the Go buildpack
# expects.
apt-get -qy install wget
mkdir -p /opt/golang
cd /opt/golang && wget -q ${ASSETS_URL}/go${GOVERSION}.linux-amd64.tar.gz
ls -l /opt/golang

# Install commonly used debian packages
apt-get -qy install $DEBIAN_PACKAGES

# Ensure we are up to date with the latest packages
apt-get -qy upgrade

/docker/clean.sh
