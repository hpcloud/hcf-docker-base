#!/bin/bash -ex

# The new stackato-deps.
# Manageable at https://horizon.hpcloud.com/project/containers/stackato-deps/
ASSETS_URL="http://a248.e.akamai.net/cdn.hpcloudsvc.com/h39066e7520a2434486279540204b7687/prodaw2/"

# For modern git
echo 'deb http://ppa.launchpad.net/git-core/ppa/ubuntu precise main ' >> /etc/apt/sources.list.d/git-latest.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E1DF1F24
sed 's/main$/main universe/' -i /etc/apt/sources.list
apt-get -qy update

# Commands used to bootstrap the image:
# -------------------------------------
#
# Pull the latest Ubuntu image: docker pull ubuntu:12.04
#
# Start the container: docker run -t -i ubuntu:12.04 /bin/bash
#
# Run the commands at the top of this file to add the git PPA, etc.
#
# Run the following commands for security updates and to install the additional packages:
#
#   # Security updates:
#   apt-get -s dist-upgrade | grep "^Inst" | grep -i securi | awk -F " " {'print $2'} | xargs apt-get install
#
#   DEBIAN_PACKAGES="wget git bzr mercurial"
#   apt-get -qy install $DEBIAN_PACKAGES
#
# In another terminal, generate the package_list file:
# docker exec <base-image-id> /bin/bash -c "dpkg -l | grep ^ii | awk '{print \$2 \"=\" \$3}'" > package_list

# Ensure we are up to date with the latest packages
apt-get -qy install `cat /docker/package_list`

# Golang is used in the alsek stack (for Go buildpack) and to build Go-based
# components. We're leaving it unextracted as that's what the Go buildpack
# expects.
mkdir -p /opt/golang
cd /opt/golang && wget -q ${ASSETS_URL}/go${GOVERSION}.linux-amd64.tar.gz
ls -l /opt/golang

/docker/clean.sh
