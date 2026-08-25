kind: autotools
description: pkg-config
sources:
- kind: tar
  url: pkgsrc:cache-core/pkgconf.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --with-internal-glib --disable-host-tool
