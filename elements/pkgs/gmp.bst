kind: autotools
description: GMP (cross-compiled)

sources:
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.xz

build-depends:
- tools/import-fdo.bst
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst

variables:
  conf-local: >-
    --host=%{bootstrap-triplet}
    --enable-cxx
    --disable-static
environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"
