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

TEST_CASE="zoostrap and wget on x86 guest distros"

# Test kains installation
$KAINS true

# Test x86 distros, x86 ans i[3456]86 archs are equivalent for zoostrap
env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=12.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    ZS_DISTRIB_ARCH=x86 \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=14.04 \
    ZS_DISTRIB_PACKAGES="wget" \
    ZS_DISTRIB_ARCH=i686 \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=5 \
    ZS_DISTRIB_PACKAGES="wget" \
    ZS_DISTRIB_ARCH=i386 \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=6 \
    ZS_DISTRIB_PACKAGES="wget" \
    ZS_DISTRIB_ARCH=i486 \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com

env ZS_DISTRIB_ID=fedora ZS_DISTRIB_RELEASE=20 \
    ZS_DISTRIB_PACKAGES="wget" \
    ZS_DISTRIB_ARCH=i586 \
    $ZOOSTRAP rootfs wget -O /dev/null http://www.google.com
