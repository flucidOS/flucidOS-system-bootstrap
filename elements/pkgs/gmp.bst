kind: autotools
description: GNU Multiple Precision Arithmetic Library
sources:
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.xz
build-depends:
- tools/import-fdo.bst
- pkgs/m4.bst
variables:
  conf-args: --prefix=%{prefix} --enable-cxx --disable-static
