#!/usr/bin/env bash
#
# Copyright (c) STMicroelectronics 2015
#
# This file is part of zoostrap.
#
# zoostrap is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License v2.0
# as published by the Free Software Foundation
#
# zoostrap is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# v2.0 along with zoostrap. If not, see <http://www.gnu.org/licenses/>.
#

# unitary test

source `dirname $0`/common.sh

TEST_CASE="zoostrap and wget"

# Test kains installation
$KAINS true

# Test zoostrap distros
env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=12.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=14.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04.1 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04.2 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04.3 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04.4 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04.5 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04.6 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=18.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=18.04.1 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=18.04.2 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=18.04.3 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=18.04.4 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=18.04.5 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=20.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=20.04.1 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=20.04.2 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=20.04.3 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=20.04.4 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=22.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

#env ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=5 \
#    ZS_DISTRIB_PACKAGES="wget" \
#    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=6 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=7 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

#env ZS_DISTRIB_ID=fedora ZS_DISTRIB_RELEASE=20 \
#    ZS_DISTRIB_PACKAGES="wget" \
#    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

#env ZS_DISTRIB_ID=fedora ZS_DISTRIB_RELEASE=21 \
#    ZS_DISTRIB_PACKAGES="wget" \
#    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=fedora ZS_DISTRIB_RELEASE=22 \
    ZS_DISTRIB_PACKAGES="wget" \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

# Fails under travis-ci for an unknown reason
#env ZS_DISTRIB_ID=fedora ZS_DISTRIB_RELEASE=23 \
#    ZS_DISTRIB_PACKAGES="wget" \
#    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com
