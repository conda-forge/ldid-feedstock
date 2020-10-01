#!/bin/bash

set -e

if [[ "$target_platform" == linux* ]]; then
  export LDFLAGS="$LDFLAGS -lcrypto"
fi

$CXX $CXXFLAGS -I. -O3 -g0 -DLDID_NOSMIME -DLDID_NOPLIST -c -o ldid.o ldid.cpp
$CC $CFLAGS -I. -O3 -g0 -DLDID_NOSMIME -DLDID_NOPLIST -c -o lookup2.o lookup2.c
$CXX $CXXFLAGS -I. -O3 -g0 -o ldid ldid.o lookup2.o $LDFLAGS

mkdir -p $PREFIX/bin
cp ldid $PREFIX/bin

if [[ "$target_platform" != "$build_platform" && "$target_platform" == "osx-arm64" ]]; then
  $BUILD_PREFIX/bin/ldid -S $PREFIX/bin/ldid
fi

