#!/bin/bash
# modified from https://github.com/wasmerio/llvm-custom-builds/blob/master/build.sh

# Display all commands before executing them.
set -o errexit
set -o errtrace

# Download llvm source from github
aria2c -x 16 -s 16 https://github.com/llvm/llvm-project/releases/download/llvmorg-18.1.8/llvm-project-18.1.8.src.tar.xz
mkdir -p llvm-project
tar Jxf llvm-project-18.1.8.src.tar.xz -C llvm-project --strip-components=1

cd llvm-project

# Create a directory to build the project.
mkdir -p build
cd build

# Create a directory to receive the complete installation.
mkdir -p install

# Run `cmake` to configure the project.
cmake \
  -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX="/" \
  -DCMAKE_C_COMPILER="clang" \
  -DCMAKE_CXX_COMPILER="clang++" \
  -DCMAKE_EXE_LINKER_FLAGS="-static" \
  -DLLVM_USE_LINKER=lld \
  -DLLVM_ENABLE_PROJECTS="clang;lld" \
  -DLLVM_ENABLE_TERMINFO=OFF \
  -DLLVM_ENABLE_ZLIB=OFF \
  -DLLVM_ENABLE_ZSTD=OFF \
  -DLLVM_INCLUDE_DOCS=OFF \
  -DLLVM_INCLUDE_EXAMPLES=OFF \
  -DLLVM_INCLUDE_GO_TESTS=OFF \
  -DLLVM_INCLUDE_TESTS=OFF \
  -DLLVM_INCLUDE_TOOLS=ON \
  -DLLVM_INCLUDE_UTILS=OFF \
  -DLLVM_OPTIMIZED_TABLEGEN=ON \
  -DLLVM_TARGETS_TO_BUILD="X86" \
  ../llvm

# Showtime!
cmake --build . --config Release -j $(nproc)
DESTDIR=destdir cmake --install . --strip --config Release

# move usr/bin/* to bin/ or llvm-config will be broken
if [ ! -d destdir/bin ];then
 mkdir destdir/bin
fi
mv destdir/usr/bin/* destdir/bin/