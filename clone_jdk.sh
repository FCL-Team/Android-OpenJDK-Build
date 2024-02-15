#!/bin/bash
set -e
if [[ "$TARGET_JDK" == "arm" ]]; then
git clone --depth 1 https://github.com/openjdk/aarch32-port-jdk8u openjdk
else
git clone --depth 1 https://github.com/openjdk/jdk8u openjdk
fi