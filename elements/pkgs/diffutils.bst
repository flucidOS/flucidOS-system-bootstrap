kind: autotools
description: GNU Diffutils
sources:
- kind: tar
  url: pkgsrc:cache-core/diffutils.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
