kind: autotools
description: GNU M4 macro processor

sources:
- kind: tar
  url: pkgsrc:cache-core/m4.tar.xz

build-depends:
- tools/toolchain.bst  # <--- THIS IS THE FIX. Do NOT use import-fdo.bst here.

variables:
  conf-args: >-
    --prefix=%{prefix}
    --disable-nls
