kind: autotools

description: |
  Cross binutils. First stage — host gcc from import-fdo (bootstrap-import).
  Do not depend on toolchain.bst.

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz
  # ref: must exist in project.refs (track if missing)

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
