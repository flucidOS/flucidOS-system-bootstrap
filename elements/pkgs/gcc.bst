kind: autotools
description: Final GCC (native)

sources:
- kind: tar
  url: pkgsrc:cache-programming/gcc.tar.xz
- kind: tar
  url: pkgsrc:cache-core/mpfr.tar.xz
  directory: mpfr
- kind: tar
  url: pkgsrc:cache-core/mpc.tar.xz
  directory: mpc

depends:
- pkgs/gmp.bst

build-depends:
- pkgs/libstdcxx.bst
- pkgs/binutils.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst
- tools/import-fdo.bst

variables:
  conf-local: >-
    --enable-languages=c,c++
    --disable-multilib
    --enable-default-pie
    --enable-default-ssp
environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"
  AR: "%{bootstrap-triplet}-ar"
  RANLIB: "%{bootstrap-triplet}-ranlib"
