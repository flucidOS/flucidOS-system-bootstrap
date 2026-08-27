kind: manual

description: Linux kernel API headers into the bootstrap sysroot (carbonOS)

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/linux.tar.xz

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
