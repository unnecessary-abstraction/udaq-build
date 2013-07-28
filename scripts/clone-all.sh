#! /bin/bash
set -e

# Clone necessary layers (at the dylan branch where appropriate)
mkdir -p oe-udaq
git clone git://git.openembedded.org/bitbake.git \
	oe-udaq/bitbake

git clone -b dylan git://git.openembedded.org/openembedded-core.git \
	oe-udaq/openembedded-core

git clone -b dylan git://git.openembedded.org/meta-openembedded.git \
	oe-udaq/meta-openembedded

git clone -b dylan git://git.yoctoproject.org/meta-yocto.git \
	oe-udaq/meta-yocto

git clone git://bitbucket.org/underwater-acoustics/meta-udaq.git \
	oe-udaq/meta-udaq

# We need a symlink to bitbake within the openembedded-core directory
ln -s ../bitbake oe-udaq/openembedded-core/bitbake
