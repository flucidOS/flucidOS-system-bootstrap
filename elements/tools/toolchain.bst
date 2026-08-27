kind: stack

description: |
  Native bootstrap toolchain. Everything in pkgs/ that is not part of the
  early cross chain must build-depend on this (carbonOS).

depends:
- pkgs/linux-api-headers.bst
- pkgs/glibc.bst
- pkgs/gcc.bst
- pkgs/binutils.bst
- tools/import-fdo.bst
- tools/sysroot-setup.bst
