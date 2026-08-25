kind: manual
description: Perl (minimal, enough for autoconf/automake)
sources:
- kind: tar
  url: pkgsrc:cache-programming/perl.tar.xz
build-depends:
- tools/import-fdo.bst
config:
  build-commands:
  - ./Configure -des -Dprefix=%{prefix} -Dusethreads -Dusedevel -Dusedevel
  - make -j%{max-jobs}
  - make install DESTDIR=%{install-root}
