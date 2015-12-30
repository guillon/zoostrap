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

SHELL=/bin/sh
ZOOSTRAP=../zoostrap
KAINS=./ckains
WGET=wget --tries 3 --no-check-certificate
UNAME=$(shell uname -m)
CKAINS_URL=https://github.com/guillon/ckains/releases/download/v0.1.1/ckains.$(UNAME)
CKAINS_SHA1SUM_i686=bda6a5cb3566ce94edf219da540cb43fc4fbc352
CKAINS_SHA1SUM_x86_64=3195facc3d2bf7201098bdaa631a3e5186ee4951
CKAINS_SHA1SUM=$(CKAINS_SHA1SUM_$(UNAME))

TESTS:=$(wildcard test*.sh)

help:
	@echo "usage: make TARGET [PARAMETERS]"
	@echo
	@echo "where TARGET is one of:"
	@echo "make all       : run unit tests"
	@echo "make check     : same as make all"
	@echo "make clean     : clean build and tests"
	@echo "make distclean : clean evrything"
	@echo
	@echo "where PAREMETERS is one of (current values):"
	@echo "TESTS=$(TESTS)"
	@echo "ZOOSTRAP=$(ZOOSTRAP)"
	@echo "KAINS=$(KAINS)"


all: check

check:
	$(MAKE) _dependencies
	$(MAKE) _unittests

clean:
	rm -f test*.log test*.dir *.tmp *.dep ckains

distclean: clean

_dependencies: ckains.dep

ckains.dep:
	[ -n "`which "$(KAINS)" 2>/dev/null`" ] || \
	($(WGET) -O ckains.tmp "$(CKAINS_URL)" && \
	echo "$(CKAINS_SHA1SUM)  ckains.tmp" | sha1sum --check && \
	mv ckains.tmp ckains && \
	chmod +x ckains)
	touch ckains.dep

_unittests: $(TESTS:%=%.chk)

$(TESTS:%=%.chk): %.chk: %
	env KAINS=$(KAINS) ZOOSTRAP=$(ZOOSTRAP) ./$*

.PHONY: help all check clean distclean _unittests $(TESTS:%=%.chk)
