kind: autotools
description: GNU Findutils
sources:
- kind: tar
  url: pkgsrc:cache-core/findutils.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
