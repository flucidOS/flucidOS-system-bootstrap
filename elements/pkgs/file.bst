kind: autotools
description: file – determine file type
sources:
- kind: tar
  url: pkgsrc:cache-core/file.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-static
