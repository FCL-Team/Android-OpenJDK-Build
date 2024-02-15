#!/bin/bash
set -e
. set_devkit_path.sh

export JDK_DEBUG_LEVEL=release

sudo chmod 777 android-wrapped-clang
sudo chmod 777 android-wrapped-clang++

# Install build dependencies
sudo apt update
sudo apt -y install autoconf python unzip zip systemtap-sdt-dev libxtst-dev libasound2-dev libelf-dev libfontconfig1-dev libx11-dev libxext-dev libxrandr-dev libxrender-dev libxtst-dev libxt-dev

wget -nc -nv -O android-ndk-$NDK_VERSION-linux-x86_64.zip "https://dl.google.com/android/repository/android-ndk-$NDK_VERSION-linux-x86_64.zip"

sudo chmod 777 extract_ndk.sh
sudo chmod 777 make_toolchain.sh
sudo chmod 777 get_boot_jdk.sh
sudo chmod 777 get_libs.sh
sudo chmod 777 build_libs.sh
sudo chmod 777 clone_jdk.sh
sudo chmod 777 build_jdk.sh
sudo chmod 777 remove_jdk_debug_info.sh
sudo chmod 777 tar_jdk.sh

./extract_ndk.sh
./make_toolchain.sh
./get_boot_jdk.sh
./get_libs.sh
./build_libs.sh
./clone_jdk.sh
./build_jdk.sh
./remove_jdk_debug_info.sh
./tar_jdk.sh
