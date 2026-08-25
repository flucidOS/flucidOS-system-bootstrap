kind: autotools
description: GNU which
sources:
- kind: tar
  url: pkgsrc:cache-system-utilities/which.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix}
