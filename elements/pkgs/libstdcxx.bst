kind: autotools
description: Temporary libstdc++ for the cross-toolchain

sources:
- kind: tar
  url: pkgsrc:cache-programming/gcc.tar.xz

build-depends:
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/import-fdo.bst
- tools/sysroot-setup.bst

variables:
  # Target the nested libstdc++ folder inside the extracted GCC tarball
  conf-root: "%{build-root}/libstdc++-v3"
  conf-args: >-
    --prefix=%{prefix}
    --host=%{bootstrap-triplet}
    --disable-multilib
    --disable-nls
    --disable-libstdcxx-pch
environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"
