kind: autotools
description: GNU Grep
sources:
- kind: tar
  url: pkgsrc:cache-core/grep.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
