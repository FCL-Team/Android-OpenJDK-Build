#!/bin/bash
set -e

export TARGET=armv7a-linux-androideabi
export TARGET_JDK=arm
export NDK_PREBUILT_ARCH=arm

bash ci_build_global.sh

