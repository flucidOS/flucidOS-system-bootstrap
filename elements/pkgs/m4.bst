kind: autotools

description: |
  GNU m4. Only after tools/toolchain.bst. Skip failing doc/check targets.

sources:
- kind: tar
  url: https://github.com/flucidOS/pkg-src/releases/download/cache-core/m4.tar.xz
  ref: f218f1a44a403c1f9bb47b9c84c2a4a6ea1b023c25d6e6c6ceeb2d4a30cf96f2

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-gcc-warnings
  make-args: -j%{max-jobs} MAKEINFO=true HELP2MAN=true
