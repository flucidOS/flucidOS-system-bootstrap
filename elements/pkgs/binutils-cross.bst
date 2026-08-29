kind: autotools
description: Binutils cross-compiler for FlucidOS

depends:
- filename: tools/import-fdo.bst
  type: build
- filename: tools/sysroot-setup.bst
  type: build

sources:
- kind: tar
  url: gnu:binutils/binutils-2.42.tar.xz

  ref: f6e4d41fd5fc778b06b7891457b3620da5ecea1006c6a4a41ae998109f85a800
variables:
  # Override BuildStream's default /usr paths
  prefix: /tools
  sysconfdir: /tools/etc
  localstatedir: /tools/var
  infodir: /tools/share/info
  mandir: /tools/share/man

  conf-local: >-
    --with-sysroot=/sysroot
    --target=%{target_arch}-flucidos-linux-gnu
    --disable-nls
    --disable-werror
    --with-lib-path=/tools/lib
