kind: autotools

description: m4 (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/m4.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-gcc-warnings
  make-args: -j%{max-jobs} MAKEINFO=true HELP2MAN=true
