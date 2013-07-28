#! /bin/bash
set -e

DATE=`date -u "+%Y%m%d%H%M%S"`

# We need to sync any new sources, packages and images to the deployment
# directory and crytographically sign everything. We do not wish to overwrite or
# re-sign anthing that is not new. The exception to this is the symbolic links
# in the images directory and the package indexes which may change on each
# build.

# Ensure the staging and deployment trees exist
mkdir -p {deploy,staging}/{feed,images,sources,oe}

# First we copy all changed files to a staging directory
rsync -av --compare-dest="deploy/feed" build/tmp/deploy/ipk/ staging/feed/
rsync -av --compare-dest="deploy/images" build/tmp/deploy/images/ staging/images/
rsync -av --compare-dest="deploy/sources" --exclude="*.done" --exclude="/git2" \
	--exclude="/hg" --exclude="/svn" downloads staging/sources/

# Capture the yocto source tree
rsync -av --exclude=".git" oe-udaq oe-udaq_${DATE}
tar cvJf staging/oe/oe-udaq_${DATE}.tar.xz oe-udaq_${DATE}
rm -rf oe-udaq_${DATE}

# Sign everything in the staging directory
find staging -type f -exec gpg -sab {} \;

# Merge into deployment directory
rsync -av staging/ deploy/

# Clean staging directory
find staging -type f -delete
