kind: autotools

description: GNU Multiple Precision Arithmetic Library (needed by gcc)

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
  - |
    mkdir -p "%{build-dir}"
    cd "%{build-dir}"
    sh "%{conf-root}/configure" %{conf-args}
