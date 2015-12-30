#!/usr/bin/env bash
#
# Copyright (c) STMicroelectronics 2012
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
env ZS_DISTRIB_ID=Ubuntu ZS_DISTRIB_RELEASE=12.04 \
    ZS_DISTRIB_PACKAGES="wget" KAINS_EXE=$KAINS \
    $ZOOSTRAP rootfs
$KAINS -R rootfs -- wget -O google.html http://www.google.com
