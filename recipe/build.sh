#!/bin/bash

set -ex

if [[ "$target_platform" == "linux-riscv64" ]]; then
    CMAKE_ARGS+=" -D CMAKE_C_COMPILER=$BUILD_PREFIX/bin/clang-17 -D CMAKE_CXX_COMPILER=$BUILD_PREFIX/bin/clang-17 -D CMAKE_C_COMPILER_TARGET=$CONDA_TOOLCHAIN_HOST -D CMAKE_CXX_COMPILER_TARGET=$CONDA_TOOLCHAIN_HOST -D CMAKE_SYSROOT=$CONDA_BUILD_SYSROOT"
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
