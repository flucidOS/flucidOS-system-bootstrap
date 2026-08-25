kind: autotools
description: GNU Make
sources:
- kind: tar
  url: pkgsrc:cache-core/make.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
