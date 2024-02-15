# Android-OpenJDK-Build
 Build and packaging script for building OpenJDK, used for FoldCraftLauncher.

## Branch information
 This branch is used to compile JRE 11.

## Setup and Build
 Use Android NDK to build.

### Setup
- Download Android NDK r21.
- **Warning**: Do not attempt to build use newer or older NDK, it will lead to compilation errors.

### Build
 Run in this directory:
```
export BUILD_FREETYPE_VERSION=[2.6.2/.../2.10.0] # default: 2.10.0
export JDK_DEBUG_LEVEL=[release/fastdebug/slowdebug] # default: release
export JVM_VARIANTS=[client/server] # default: server

# Setup NDK, run once
./extract_ndk.sh
./make_toolchain.sh

# Get boot JDK, JDK 10 is needed when building JDK 11.
./get_boot_jdk.sh

# Get CUPS, Freetype and build Freetype
./get_libs.sh
./build_libs.sh

# Clone JDK, run once
./clone_jdk.sh

# Configure JDK and build
./build_jdk.sh

# Pack the built JDK
./remove_jdk_debug_info.sh
./tar_jdk.sh
```