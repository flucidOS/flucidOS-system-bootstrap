kind: manual

description: Perl (after native toolchain – needed for autoconf)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/perl.tar.xz

build-depends:
- tools/toolchain.bst

config:
  build-commands:
  - ./Configure -des -Dprefix=%{prefix} -Dusethreads
  - make -j%{max-jobs}
  install-commands:
  - make install DESTDIR=%{install-root}
