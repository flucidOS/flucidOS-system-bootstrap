kind: autotools
description: First stage cross binutils

sources:
- kind: tar
  url: pkgsrc:cache-core/binutils.tar.xz

build-depends:
- tools/import-fdo.bst
- tools/sysroot-setup.bst

variables:
  conf-local: >-
    --target=%{bootstrap-triplet}
    --with-sysroot=%{bootstrap-sysroot}
    --with-lib-path=%{libdir}
    --disable-werror
    --disable-plugins
