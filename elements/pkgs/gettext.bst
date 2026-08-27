kind: autotools

description: gettext (after native toolchain – carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/gettext.tar.xz

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-nls --disable-java --disable-csharp
