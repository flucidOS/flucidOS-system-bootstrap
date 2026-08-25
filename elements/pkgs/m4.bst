kind: manual
description: GNU M4 macro processor
sources:
- kind: tar
  url: pkgsrc:cache-core/m4.tar.xz
build-depends:
- tools/import-fdo.bst
config:
  build-commands:
  - cd %{conf-root} && chmod +x configure && ./configure --prefix=%{prefix} --disable-nls && make -j%{max-jobs} && make install DESTDIR=%{install-root}
