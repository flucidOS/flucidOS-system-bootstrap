kind: autotools
description: GNU Cpio
sources:
- kind: tar
  url: pkgsrc:cache-system-utilities/cpio.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
