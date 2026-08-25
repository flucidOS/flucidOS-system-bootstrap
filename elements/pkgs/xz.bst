kind: autotools
description: XZ Utils
sources:
- kind: tar
  url: pkgsrc:cache-core/xz.tar.zst
  # ref managed by track
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-static --disable-nls
