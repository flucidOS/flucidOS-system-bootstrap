kind: autotools
description: GNU Multiple Precision Arithmetic Library (cross-compiled)

sources:
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.xz

build-depends:
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/import-fdo.bst
- tools/sysroot-setup.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --host=%{bootstrap-triplet}
    --enable-cxx
    --disable-static
environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"
