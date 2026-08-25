kind: manual
description: Perl (minimal, enough for autoconf/automake)
sources:
- kind: tar
  url: pkgsrc:cache-programming/perl.tar.zst
build-depends:
- tools/import-fdo.bst
config:
  build-commands:
  - ./Configure -des -Dprefix=%{prefix} -Dusethreads
  - make -j%{max-jobs}
  - make install DESTDIR=%{install-root}
