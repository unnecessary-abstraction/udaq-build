#! /bin/bash
set -e

DATE=`date -u "+%Y%m%d%H%M%S"`

# Enter the build environment
cd oe-udaq/openembedded-core
source oe-init-build-env ../../build

# Build everything, continuing on error and producing a log file
bitbake -k kitchen-sink | tee bitbake-${DATE}.log
xz bitbake-${DATE}.log

# Ensure the package feed is up-to-date
bitbake package-index
