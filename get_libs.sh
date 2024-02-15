#!/bin/bash
set -e

. set_devkit_path.sh

wget https://downloads.sourceforge.net/project/freetype/freetype2/$BUILD_FREETYPE_VERSION/freetype-$BUILD_FREETYPE_VERSION.tar.gz
tar xf freetype-$BUILD_FREETYPE_VERSION.tar.gz

wget https://github.com/apple/cups/releases/download/v2.2.4/cups-2.2.4-source.tar.gz
tar xf cups-2.2.4-source.tar.gz

rm cups-2.2.4-source.tar.gz freetype-$BUILD_FREETYPE_VERSION.tar.gz
