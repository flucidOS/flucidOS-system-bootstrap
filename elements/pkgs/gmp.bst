kind: manual
description: GNU Multiple Precision Arithmetic Library
sources:
- kind: tar
  url: pkgsrc:cache-core/gmp.tar.xz
build-depends:
- tools/import-fdo.bst
config:
  build-commands:
  - chmod +x configure
  - ./configure --prefix=%{prefix} --enable-cxx --disable-static
  - make -j%{max-jobs}
  - make install DESTDIR=%{install-root}
