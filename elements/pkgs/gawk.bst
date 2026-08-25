kind: autotools
description: GNU Awk
sources:
- kind: tar
  url: pkgsrc:cache-core/gawk.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
