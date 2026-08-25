kind: autotools

description: |
  Bootstrap glibc. Built with the cross compiler so that the resulting
  libraries live under the temporary /tools tree and never touch the
  final system image.

sources:
- kind: tar
  url: pkgsrc:cache-core/glibc.tar.zst

build-depends:
- pkgs/linux-api-headers.bst
- pkgs/gcc-cross.bst
- pkgs/binutils-cross.bst
- tools/sysroot-setup.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --host=%{bootstrap-triplet}
    --enable-kernel=5.15
    --disable-nls
    --disable-werror
  # glibc needs a dedicated build directory
  build-dir: build
