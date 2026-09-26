#!/bin/bash
set -e
. set_devkit_path.sh
export LD=/usr/bin/ld
export lt_cv_path_LD=/usr/bin/ld
cd freetype-$BUILD_FREETYPE_VERSION

echo "Building Freetype"

export PATH=$TOOLCHAIN/bin:$PATH
./configure \
  --host=$TARGET \
  --prefix=${PWD}/build_android-${TARGET_SHORT} \
  --without-zlib \
  --with-png=no \
  --with-harfbuzz=no --with-bzip2=no $EXTRA_ARGS \
  || error_code=$?

if [[ "$error_code" -ne 0 ]]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat ${PWD}/builds/unix/config.log
  exit $error_code
fi

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
make install