kind: manual
description: Linux kernel API headers into the bootstrap sysroot.

variables:
  bootstrap-sysroot: /sysroot

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/linux.tar.xz
  ref: 6d4e735c326d58e51069a36bafead96efe21d7177e9813fd2c312a3a5e5d4f36
build-depends:
- tools/import-fdo.bst
- tools/sysroot-setup.bst
- pkgs/binutils-cross.bst
- pkgs/gcc-cross.bst
config:
  build-commands:
  - make mrproper
  - make headers
  - find usr/include -name '.*' -delete
  - rm -f usr/include/Makefile
  install-commands:
  - mkdir -p "%{install-root}%{bootstrap-sysroot}/usr"
  - cp -rv usr/include "%{install-root}%{bootstrap-sysroot}/usr/"
