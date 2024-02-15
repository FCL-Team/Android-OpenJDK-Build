#!/bin/bash
set -e

. set_devkit_path.sh

imagespath=openjdk/build/${JVM_PLATFORM}-${TARGET_JDK}-normal-${JVM_VARIANTS}-${JDK_DEBUG_LEVEL}/images

rm -rf dizout jreout jdkout dSYM-temp
mkdir -p dizout dSYM-temp/{lib,bin}

cp freetype-$BUILD_FREETYPE_VERSION/build_android-$TARGET_SHORT/lib/libfreetype.so $imagespath/jdk/lib/

cp -r $imagespath/jdk jdkout

export EXTRA_JLINK_OPTION=

if [[ "$TARGET_JDK" == "aarch64" ]] || [[ "$TARGET_JDK" == "x86_64" ]]; then
   echo "Building for aarch64 or x86_64, introducing JVMCI module"
   export EXTRA_JLINK_OPTION=,jdk.internal.vm.ci
fi

# Produce the jre equivalent from the jdk (https://blog.adoptium.net/2021/10/jlink-to-produce-own-runtime/)
jlink \
--module-path=jdkout/jmods \
--add-modules java.base,java.compiler,java.datatransfer,java.desktop,java.instrument,java.logging,java.management,java.management.rmi,java.naming,java.net.http,java.prefs,java.rmi,java.scripting,java.se,java.security.jgss,java.security.sasl,java.sql,java.sql.rowset,java.transaction.xa,java.xml,java.xml.crypto,jdk.accessibility,jdk.charsets,jdk.crypto.cryptoki,jdk.crypto.ec,jdk.dynalink,jdk.httpserver,jdk.jdwp.agent,jdk.jfr,jdk.jsobject,jdk.localedata,jdk.management,jdk.management.agent,jdk.management.jfr,jdk.naming.dns,jdk.naming.rmi,jdk.net,jdk.sctp,jdk.security.auth,jdk.security.jgss,jdk.scripting.nashorn,jdk.unsupported,jdk.xml.dom,jdk.zipfs$EXTRA_JLINK_OPTION \
--output jreout \
--strip-debug \
--no-man-pages \
--no-header-files \
--release-info=jdkout/release \
--compress=0

cp freetype-$BUILD_FREETYPE_VERSION/build_android-$TARGET_SHORT/lib/libfreetype.so jreout/lib/

#find jdkout -name "*.debuginfo" | xargs -- rm
find jdkout -name "*.debuginfo" -exec mv {}   dizout/ \;

find jdkout -name "*.dSYM"  | xargs -- rm -rf