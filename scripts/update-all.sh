#! /bin/bash
set -e

# Requires git-up because it is superior to git pull

cd oe-udaq/bitbake
git up

cd ../openembedded-core
git up

cd ../meta-openembedded
git up

cd ../meta-yocto
git up

cd ../meta-udaq
git up
