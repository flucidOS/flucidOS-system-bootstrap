kind: autotools
description: GNU Cpio
sources:
- kind: tar
  url: pkgsrc:cache-system-utilities/cpio.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
