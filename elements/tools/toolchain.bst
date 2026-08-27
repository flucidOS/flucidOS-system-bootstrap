kind: stack
description: |
  The native toolchain barrier.
  General packages MUST depend on this, not import-fdo.

depends:
- pkgs/linux-api-headers.bst
- pkgs/glibc.bst
- pkgs/binutils.bst
- pkgs/gcc.bst
- tools/sysroot-setup.bst
- tools/import-fdo.bst
