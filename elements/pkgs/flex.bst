kind: autotools
description: The Fast Lexical Analyzer
sources:
- kind: tar
  url: pkgsrc:cache-core/flex.tar.xz
build-depends:
- pkgs/m4.bst
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix} --disable-nls
