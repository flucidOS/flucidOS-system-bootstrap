kind: autotools
description: GNU Libtool
sources:
- kind: tar
  url: pkgsrc:cache-core/libtool.tar.xz
build-depends:
- pkgs/m4.bst
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-static
