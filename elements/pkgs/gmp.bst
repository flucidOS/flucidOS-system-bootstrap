kind: autotools
description: GNU Multiple Precision Arithmetic Library
sources:
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: >-
    --prefix=%{prefix}
    --enable-cxx
    --disable-static
config:
  configure-commands:
  - chmod +x %{conf-root}/configure || true
  - '%{conf-root}/configure %{conf-args}'
