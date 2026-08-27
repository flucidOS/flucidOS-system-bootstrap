kind: autotools
description: Temporary libstdc++ for the cross-toolchain

sources:
- kind: tar
  url: pkgsrc:cache-programming/gcc.tar.xz

build-depends:
- tools/import-fdo.bst
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst

variables:
  conf-cmd: "%{build-root}/libstdc++-v3/configure"
  gcc-version: $(%{bootstrap-triplet}-gcc -dumpversion)
  conf-local: >-
    --host=%{bootstrap-triplet}
    --disable-multilib
    --disable-libstdcxx-threads
    --disable-libstdcxx-pch
    --with-gxx-include-dir=%{prefix}/%{bootstrap-triplet}/include/c++/%{gcc-version}
environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"
