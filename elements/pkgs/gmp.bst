kind: autotools

description: GNU Multiple Precision Arithmetic Library (needed by gcc)

sources:
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.zst

build-depends:
- tools/import-fdo.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --enable-cxx
    --disable-static
