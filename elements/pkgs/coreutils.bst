kind: autotools
description: GNU Coreutils
sources:
- kind: tar
  url: pkgsrc:cache-core/coreutils.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
