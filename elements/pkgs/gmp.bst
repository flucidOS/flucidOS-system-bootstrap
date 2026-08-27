kind: autotools

description: |
  GMP with cross compiler after bootstrap glibc (carbonOS mid-stage).
  Must NOT depend on tools/toolchain.bst (would cycle with final gcc).

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/gmp.tar.xz

build-depends:
- tools/import-fdo.bst
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- pkgs/glibc.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst

environment:
  CC: "%{bootstrap-triplet}-gcc"
  AR: "%{bootstrap-triplet}-ar"
  RANLIB: "%{bootstrap-triplet}-ranlib"

variables:
  build-dir: build
  conf-local: --enable-cxx --disable-static
