kind: autotools
description: ncurses library
sources:
- kind: tar
  url: pkgsrc:cache-core/ncurses.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: >-
    --prefix=%{prefix}
    --with-shared
    --without-debug
    --without-ada
    --enable-widec
