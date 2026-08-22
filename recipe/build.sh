#!/bin/bash

set -ex

# https://github.com/conda-forge/libdispatch-feedstock/pull/21#issuecomment-5374865695
if [[ "$target_platform" == "linux-ppc64le" ]]; then
  CFLAGS="$(echo $CFLAGS | sed 's/-fno-plt //g')"
  CXXFLAGS="$(echo $CXXFLAGS | sed 's/-fno-plt //g')"
fi

cmake ${CMAKE_ARGS} \
    -G Ninja \
    -B build \
    -D BUILD_SHARED_LIBS=YES \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} \
    -D CMAKE_PREFIX_PATH=${PREFIX} \
    -D BUILD_TESTING=NO \
    -S ${SRC_DIR}

cmake --build build -j ${CPU_COUNT} --target install
