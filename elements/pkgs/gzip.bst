kind: autotools
description: GNU Gzip
sources:
- kind: tar
  url: pkgsrc:cache-core/gzip.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix}
