kind: autotools
description: GNU m4 macro processor
sources:
- kind: tar
  url: pkgsrc:cache-core/m4.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
