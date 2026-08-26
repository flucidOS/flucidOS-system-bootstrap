kind: autotools
description: GNU M4 macro processor
sources:
- kind: tar
  url: pkgsrc:cache-core/m4.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
