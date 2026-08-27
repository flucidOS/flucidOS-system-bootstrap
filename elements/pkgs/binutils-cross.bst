kind: autotools
description: First stage cross binutils

sources:
- kind: tar
  url: pkgsrc:cache-core/binutils.tar.xz

build-depends:
- freedesktop-sdk.bst:components/texinfo.bst
- tools/import-fdo.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --target=%{bootstrap-triplet}
    --with-sysroot=%{bootstrap-sysroot}
    --with-lib-path=%{libdir}
    --disable-nls
    --disable-werror
    --disable-plugins
