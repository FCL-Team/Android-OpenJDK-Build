export NDK_VERSION=r21

if [[ -z "$BUILD_FREETYPE_VERSION" ]]
then
  export BUILD_FREETYPE_VERSION="2.10.0"
fi

if [[ -z "$JDK_DEBUG_LEVEL" ]]
then
  export JDK_DEBUG_LEVEL=release
fi

if [[ "$TARGET_JDK" == "aarch64" ]]
then
  export TARGET_SHORT=arm64
else
  export TARGET_SHORT=$TARGET_JDK
fi

if [[ -z "$JVM_VARIANTS" ]]
then
  export JVM_VARIANTS=server
fi

export JVM_PLATFORM=linux
# Set NDK
export API=21
# Always use the NDK this repository downloads (r21). The build does not
# work with any other NDK (see README), and CI runner images preinstall
# their own NDK and export ANDROID_NDK_ROOT, which would silently hijack
# the toolchain here.
export NDK=$PWD/android-ndk-$NDK_VERSION
export ANDROID_NDK_ROOT=$NDK
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64

export ANDROID_INCLUDE=$TOOLCHAIN/sysroot/usr/include

export CPPFLAGS="-I$ANDROID_INCLUDE -I$ANDROID_INCLUDE/$TARGET"
export LDFLAGS="-L$NDK/platforms/android-$API/arch-$TARGET_SHORT/usr/lib"

export thecc=$TOOLCHAIN/bin/${TARGET}${API}-clang
export thecxx=$TOOLCHAIN/bin/${TARGET}${API}-clang++

# Configure and build.
export AR=$TOOLCHAIN/bin/llvm-ar
export AS=$TOOLCHAIN/bin/llvm-as
export CC=$PWD/android-wrapped-clang
export CXX=$PWD/android-wrapped-clang++
export LD=$TOOLCHAIN/bin/ld
export OBJCOPY=$TOOLCHAIN/bin/llvm-objcopy
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip