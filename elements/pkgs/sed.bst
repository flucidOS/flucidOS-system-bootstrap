kind: autotools
description: GNU Sed
sources:
- kind: tar
  url: pkgsrc:cache-core/sed.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
