kind: autotools
description: GNU M4

sources:
- kind: tar
  url: pkgsrc:cache-core/m4.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: ""
