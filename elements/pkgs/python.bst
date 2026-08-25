kind: autotools
description: Python 3 (minimal, for build scripts and later tooling)
sources:
- kind: tar
  url: pkgsrc:cache-programming/python.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: >-
    --prefix=%{prefix}
    --enable-shared
    --without-ensurepip
    --disable-test-modules
