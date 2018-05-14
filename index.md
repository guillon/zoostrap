
[![Build Status](https://api.travis-ci.org/guillon/zoostrap.png?branch=master)](https://travis-ci.org/guillon/zoostrap/branches)

# Synopsis

The zoostrap utility is a simple tool for bootstrapping a Linux host
distribution and running command in an unprivileged container.

Actually this tool proceeds in three steps:
- download a reference distribution archive an extract into the specified
rootfs directory
- execute installation of additional packages into this rootfs with `PRoot`
- execute actual commands into this rootfs with `ckains`

The list of available x86_64 distributions is currently:
- Ubuntu 12.04 (`ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=12.04`)
- Ubuntu 14.04 (`ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=14.04`)
- Ubuntu 16.04 (`ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=16.04`)
- CentOS 5 (`ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=5`)
- CentOS 6 (`ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=6`)
- CentOS 7 (`ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=7`)
- Fedora 20/21/22/23 (`ZS_DISTRIB_ID=fedora ZS_DISTRIB_RELEASE=20/21/22/23`)

Some x86 distributions are also available with the `ZS_DISTRIB_ARCH=i686`
parameter:
- Ubuntu 12.04 (`ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=12.04 ZS_DISTRIB_ARCH=i686`)
- Ubuntu 14.04 (`ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=14.04 ZS_DISTRIB_ARCH=i686`)
- CentOS 5 (`ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=5 ZS_DISTRIB_ARCH=i686`)
- CentOS 6 (`ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=6 ZS_DISTRIB_ARCH=i686`)
- Fedora 20 (`ZS_DISTRIB_ID=centos ZS_DISTRIB_RELEASE=20 ZS_DISTRIB_ARCH=i686`)

This tool is still a prototype and as of now configuration is passed through
the environment, refer to the TODO file for next steps.

Note that this tool requires a kernel >= 3.11.x in order to execute
unprivileged containers.
In particular if you have this kind of error:
`ERROR: unshare failed with error Invalid argument`. The host distribution
kernel is probably too old.

The tool uses 3 companions tools as backend:
- PRoot for installation of packages,
- ckains for execution of the container,
- bcache for cacheing of images.

See references section.


# Download

Download a specific release from the release page:
https://github.com/guillon/zoostrap/releases

Or download the last stable version from there:
https://raw.githubusercontent.com/guillon/zoostrap/master/zoostrap

For instance:

    $ wget -O ~/bin/zoostrap https://raw.githubusercontent.com/guillon/zoostrap/master/zoostrap
    $ chmod +x ~/bin/zoostrap

The first command gets the zoostrap tool and the second command sets execution bit.

# Examples

A typical usage is to bootstrap for instance a CentOS or Ubuntu distribution and then
execute a build command into the installed distribution root tree.

For instance, assuming  zoostrap is available in the path:

    $ env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=12.04 \
      ZS_DISTRIB_PACKAGES="wget" \
      zoostrap rootfs
    $ rootfs/.zoostrap/run wget https://raw.githubusercontent.com/guillon/zoostrap/master/zoostrap
    ...

The first command installs a Ubuntu 12.04 core root tree in the rootfs/
directory and install the wget package.

The second command executes a wget command in the just installed distro.

One can also do this with a single command, passing the command to execute as parameter:

    $ env ZS_DISTRIB_ID=ubuntu ZS_DISTRIB_RELEASE=12.04 \
      ZS_DISTRIB_PACKAGES="wget" \
      zoostrap rootfs wget https://raw.githubusercontent.com/guillon/zoostrap/master/zoostrap
    ...
# Parameters

zoostrap gets parameters from the environment except for the rootfs directory
to create which is passed as argument.

The available parameters are:

* `ZS_DISTRIB_ID="<distro>"`: one of the known distribution listed above.
* `ZS_DISTRIB_RELEASE="<release>"`: one of the known distro release listed above.
* `ZS_DISTRIB_ARCH="<uname-m>"`: the requested architecture for the
  guest as may be provided by `uname -m` for instance. The default is the same
  as the host architecture. It may be x86_64, amd64 (64 bits) or x86,
  i[3456]86 (32 bits).
* `ZS_DISTRIB_PACKAGES="<packages list>"`: space separated list of packages to
  install, note that package names are specific to distributions. It is up to
  the user to give actual packages names as expected by the requested
  distribution.
* `ZS_WGET="<wget command>"`: override default wget command and options.
  The default wget command is: `wget --no-check-certificate --tries 3`.
  Note that you may use `--no-check-certificate` without compromising
  security as all downloaded files are checked against there known
  content hash (a sha1sum).
* `ZS_BCACHE=false|true`: activates caching of installed images, defaults to
  `false`. If `true` Images are cached after after  download and packages
  installation. The cached installed images are
  used on further zoostrap installations if the image identifiers and installed
  packages are the same. Cached images are stored into a local `ZS_BCACHE_DIR`.
  The `ZS_BCACHE_ID` variable can be used to discriminate images optionally,
  and have a guarantee that an image is stable (the actual base distro
  archives may indeed vary over time), though this is not used generally.
  Thus the actual identification of a unique cache entry is done at least with
  the tuple (ZS_DISTRIB_ID, ZS_DISTRIB_RELEASE, ZS_DISTRIB_ARCH,
  ZS_BCACHE_ID). This option uses the `bcache` tool.
* `ZS_BCACHE_DIR=<cache_dir>`: set location of cache when `ZS_BCACHE=true`,
  defaults to `$HOME/.bcache`. Note that this location holds installed images
  which may require some amout of disk space (generally 500Mb par installed
  images with a reasonable number of user packegs). There is no management
  of space provided by the tool, this location can be cleaned manually.
  Note that the startup is much faster if this location is on the same
  partition than the instelled root FSs.
* `ZS_BCACHE_ID=<any_stiing>`: optional discriminent for cached images. Ref to
  `ZS_BCACHE` notes.
* `ZS_UPDATE=true|false`: run packages list update before installing packages,
   defaults to ` true`. This should normally always be active as base distros
   images do not have latest packages versions list.
* `ZS_UPGRADE=false|true`: run packages upgrade before installing packages,
   defaults to `false`. This has an effect only for Ubuntu images and runs
   an `apt-get upgrade` if `true`. This is normally not required, provided
   just as an option. Note that if this is `true`, caching through `ZS_BCACHE`
   is deactivated.
* `ZS_PACKAGES_STRICT/ZS_UPDATE_STRICT/ZS_UPGRADE_STRICT=true|false`: these
  three variables control the error management on respectively packages
  installation, packages update, packages upgrade. There are cases where
  packages installation fail due to limitation of the non-privileged PRoot
  backend. For instace some packages installation may try to restart damons or
  create device nodes, which is not supported. If actually the installation is
  correct even when such errors are reported, one may use
  `ZS_PACKAGES_STRICT=false` to work-around the problem.


# Build and Install

This script requires bash and wget packages and should work on any Linux
distribution for x86_64 architecture with a kernel >= 3.0.

The script can be used directly without installation.

A makefile is provided for completion and testing purpose.

Build with:

    $ make all # a no-op actually

Run unit tests with:

    $ make check

Install with, for instance:

    $ make install PREFIX=$HOME/local  # Default is PREFIX=/usr/local


# References

Refer to the project home page at:
http://guillon.github.com/zoostrap

Refer to the current build and validation status at:
https://travis-ci.org/guillon/zoostrap?branches

Fill issues and enhancement request at:
https://github.com/guillon/zoostrap/issues

Refer to the TODO file for future work:
https://github.com/guillon/zoostrap/blob/master/TODO

Refer to ckains at: https://github.com/mickael-guene/ckains

Refer to PRoot at: http://proot.me

Refer to bcache at: https://guillon.github.com/bcache/

# License

Refer to the COPYING file: https://github.com/guillon/zoostrap/blob/master/COPYING
Refer to the COPYRIGHT file: https://github.com/guillon/zoostrap/blob/master/COPYRIGHT
