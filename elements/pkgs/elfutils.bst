kind: autotools
description: elfutils (eu-*) – needed for debuginfo handling
sources:
- kind: tar
  url: pkgsrc:cache-core/elfutils.tar.xz
build-depends:
- pkgs/zlib.bst
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-debuginfod --disable-libdebuginfod
