#!/bin/bash
set -e

export TARGET=i686-linux-android
export TARGET_JDK=x86
export NDK_PREBUILT_ARCH=i686

bash ci_build_global.sh

