kind: autotools

description: ncurses (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/ncurses.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --with-shared --without-debug --without-ada --enable-widec --disable-nls
