kind: autotools

description: |
  Final (native) binutils linked against the bootstrap glibc.
  Replaces the cross binutils for all subsequent builds.

sources:
- kind: tar
  url: pkgsrc:cache-core/binutils.tar.xz

build-depends:
- pkgs/glibc.bst
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --with-sysroot=%{bootstrap-sysroot}
    --disable-nls
    --disable-werror
    --enable-64-bit-bfd
    --enable-gold
    --enable-plugins
environment:
  CC: "%{bootstrap-triplet}-gcc"
  AR: "%{bootstrap-triplet}-ar"
  RANLIB: "%{bootstrap-triplet}-ranlib"
