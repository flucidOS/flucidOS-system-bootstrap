kind: stack
description: Native toolchain barrier

depends:
- pkgs/linux-api-headers.bst
- pkgs/glibc.bst
- pkgs/binutils.bst
- pkgs/gcc.bst
- tools/sysroot-setup.bst
- tools/import-fdo.bst
