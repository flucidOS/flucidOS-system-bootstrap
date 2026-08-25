kind: autotools
description: GNU Tar
sources:
- kind: tar
  url: pkgsrc:cache-core/tar.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
