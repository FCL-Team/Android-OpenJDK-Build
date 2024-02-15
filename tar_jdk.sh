#!/bin/bash
set -e
. set_devkit_path.sh

unset AR AS CC CXX LD OBJCOPY RANLIB STRIP CPPFLAGS LDFLAGS
git clone --depth 1 --branch 'v2.2.0' https://github.com/termux/termux-elf-cleaner || true
cd termux-elf-cleaner
autoreconf --install
bash configure
make CFLAGS=-D__ANDROID_API__=24
cd ..

findexec() { find $1 -type f -name "*" -not -name "*.o" -exec sh -c '
    case "$(head -n 1 "$1")" in
      ?ELF*) exit 0;;
      MZ*) exit 0;;
      #!*/ocamlrun*)exit0;;
    esac
exit 1
' sh {} \; -print
}

findexec jreout | xargs -- ./termux-elf-cleaner/termux-elf-cleaner
findexec jdkout | xargs -- ./termux-elf-cleaner/termux-elf-cleaner

cp -rv jre_override/lib/* jreout/lib/ || true

cd jreout

# Strip in place all .so files thanks to the ndk
find ./ -name '*.so' -execdir $NDK/toolchains/llvm/prebuilt/linux-x86_64/${NDK_PREBUILT_ARCH}-linux-android/bin/strip {} \;

tar cJf ../jre11-${TARGET_SHORT}-`date +%Y%m%d`-${JDK_DEBUG_LEVEL}.tar.xz .