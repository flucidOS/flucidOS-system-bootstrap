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

environment:
  CFLAGS: "%{cflags}"
  CXXFLAGS: "%{cxxflags}"
  LDFLAGS: "%{ldflags}"

variables:
  build-dir: build
  
  # Relax GCC 14 strictness for older autotools and clear target sysroot flags
  cflags: "-O2 -g -Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types"
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
