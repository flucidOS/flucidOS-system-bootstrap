kind: autotools

description: |
  Cross binutils. First stage — host gcc comes only from import-fdo
  (bootstrap-import). Do not depend on toolchain.bst.

sources:
- kind: tar
  url: https://github.com/flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz
  ref: eeddc2fbd3f9d3af7ce7f93039bce24d467770f5f701ba85810a1fecb29bfca1

build-depends:
- tools/import-fdo.bst

variables:
  build-dir: build
  conf-local: >-
    --target=%{bootstrap-triplet}
    --with-sysroot=%{bootstrap-sysroot}
    --with-lib-path=%{libdir}
    --disable-nls
    --disable-werror
    --disable-plugins

config:
  install-commands:
    (>):
    - ln -sv lib %{install-root}%{prefix}/lib64
    - rm -rf %{install-root}%{datadir}/info
    - rm -rf %{install-root}%{libdir}/bfd-plugins
