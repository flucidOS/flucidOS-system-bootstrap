kind: autotools
description: GNU Autoconf
sources:
- kind: tar
  url: pkgsrc:cache-core/autoconf.tar.zst
build-depends:
- pkgs/m4.bst
- pkgs/perl.bst
- tools/import-fdo.bst
variables:
  conf-args: --prefix=%{prefix}
