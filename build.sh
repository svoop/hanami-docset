#!/bin/bash
set -euo pipefail

# Clean
rm -rf source *.docset

# Read version
version=$(cat version.txt)

# Checkout guides
git clone https://github.com/hanami/guides.git source

# Build website
cd source
hugo -D

# Transform content
cd public/v${version}
../../../transform.rb ${version}

# Build docset
cp ../../../icon.png .
cat ../../../dashing.json | sed "s/\${version}/${version}/" >dashing.json

dashing build hanami
mv hanami.docset ../../../hanami-${version}.docset
