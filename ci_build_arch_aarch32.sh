#!/bin/bash
set -e

export TARGET=arm-linux-androideabi
export TARGET_JDK=arm
export NDK_PREBUILT_ARCH=arm

bash ci_build_global.sh

