#!/bin/bash
set -e
. set_devkit_path.sh
cd freetype-$BUILD_FREETYPE_VERSION

echo "Building Freetype"

export PATH=$TOOLCHAIN/bin:$PATH
  ./configure \
    --host=$TARGET \
    --prefix=`pwd`/build_android-${TARGET_SHORT} \
    --without-zlib \
    --with-brotli=no \
    --with-png=no \
    --with-harfbuzz=no $EXTRA_ARGS \
    || error_code=$?

if [[ "$error_code" -ne 0 ]]; then
  echo "\n\nCONFIGURE ERROR $error_code , config.log:"
  cat config.log
  exit $error_code
fi

CFLAGS=-fno-rtti CXXFLAGS=-fno-rtti make -j4
make install

if [[ -f "${namefreetype}.a" ]]; then
  clang -fPIC -shared $LDFLAGS -lbz2 -Wl,-all_load ${namefreetype}.a -o ${namefreetype}.dylib
fi
