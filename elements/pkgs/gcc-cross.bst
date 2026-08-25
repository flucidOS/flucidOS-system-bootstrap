kind: autotools

description: |
  First stage: cross GCC (C only) used to build the bootstrap glibc.
  Built against binutils-cross.

sources:
- kind: tar
  url: pkgsrc:cache-programming/gcc.tar.xz
- kind: tar
  url: pkgsrc:cache-core/mpfr.tar.xz
  directory: mpfr
- kind: tar
  url: pkgsrc:cache-core/mpc.tar.xz
  directory: mpc
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.xz
  directory: gmp

build-depends:
- pkgs/binutils-cross.bst
- tools/import-fdo.bst
- tools/sysroot-setup.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --target=%{bootstrap-triplet}
    --with-sysroot=%{bootstrap-sysroot}
    --enable-languages=c
    --disable-nls
    --disable-shared
    --disable-threads
    --disable-multilib
    --disable-libstdcxx
    --without-headers
