kind: autotools

description: |
  First stage: cross binutils targeting the FlucidOS triplet.
  Must be built before gcc-cross.

sources:
- kind: tar
  url: pkgsrc:cache-core/binutils.tar.xz

build-depends:
- tools/import-fdo.bst
- tools/sysroot-setup.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --target=%{bootstrap-triplet}
    --with-sysroot=%{bootstrap-sysroot}
    --disable-nls
    --disable-werror
    --enable-64-bit-bfd
