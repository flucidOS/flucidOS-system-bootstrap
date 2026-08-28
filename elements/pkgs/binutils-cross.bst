kind: autotools

description: |
  Cross binutils – first package built (carbonOS).
  Host gcc comes only from tools/import-fdo.bst.

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz

build-depends:
- freedesktop-sdk.bst:components/texinfo.bst
- tools/import-fdo.bst

variables:
  build-dir: build
  
  # Prevent global target sysroot flags from bleeding into the host build
  cflags: "-O2 -g"
  cxxflags: "-O2 -g"
  ldflags: ""

  conf-local: >-
    --with-sysroot=%{bootstrap-sysroot}
    --target=%{bootstrap-triplet}
    --with-lib-path=%{libdir}
    --disable-nls --disable-werror --disable-plugins
    
config:
  install-commands:
    (>):
    - ln -sv lib %{install-root}%{prefix}/lib64
    - rm -rf %{install-root}%{datadir}/info
    - rm -rf %{install-root}%{libdir}/bfd-plugins
