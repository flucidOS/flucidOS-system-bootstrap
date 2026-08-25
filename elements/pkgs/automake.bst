kind: autotools
description: GNU Automake
sources:
- kind: tar
  url: pkgsrc:cache-core/automake.tar.zst
build-depends:
- pkgs/autoconf.bst
- pkgs/perl.bst
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix}
