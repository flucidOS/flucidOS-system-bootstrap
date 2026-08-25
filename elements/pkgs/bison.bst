kind: autotools
description: GNU Bison parser generator
sources:
- kind: tar
  url: pkgsrc:cache-core/bison.tar.zst
build-depends:
- pkgs/m4.bst
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
