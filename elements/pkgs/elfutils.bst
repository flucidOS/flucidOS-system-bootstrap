kind: autotools
description: elfutils
sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/elfutils.tar.xz
build-depends:
- tools/toolchain.bst
variables:
  conf-local: --disable-debuginfod --disable-libdebuginfod
