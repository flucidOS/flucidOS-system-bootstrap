kind: manual
description: zlib compression library
sources:
- kind: tar
  url: pkgsrc:cache-core/zlib.tar.zst
build-depends:
- tools/import-fdo.bst
config:
  build-commands:
  - ./configure --prefix=%{prefix}
  - make -j%{max-jobs}
  - make install DESTDIR=%{install-root}
