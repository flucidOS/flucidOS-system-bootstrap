kind: stack

description: |
  Complete set of packages that constitute the FlucidOS bootstrap toolchain.
  External consumers should depend on adjusted.bst or unadjusted.bst.

depends:
# Core C library & compiler (order is documented in README)
- pkgs/linux-api-headers.bst
- pkgs/glibc.bst
- pkgs/gcc.bst
- pkgs/binutils.bst
- pkgs/libstdcxx.bst

# Build-system tools
- pkgs/m4.bst
- pkgs/make.bst
- pkgs/bison.bst
- pkgs/flex.bst
- pkgs/gettext.bst
- pkgs/autoconf.bst
- pkgs/automake.bst
- pkgs/libtool.bst
- pkgs/pkg-config.bst

# Shell & core userland
- pkgs/bash.bst
- pkgs/coreutils.bst
- pkgs/findutils.bst
- pkgs/diffutils.bst
- pkgs/gawk.bst
- pkgs/grep.bst
- pkgs/sed.bst
- pkgs/tar.bst
- pkgs/gzip.bst
- pkgs/xz.bst
- pkgs/cpio.bst
- pkgs/file.bst
- pkgs/which.bst

# Compression / debug
- pkgs/zlib.bst
- pkgs/elfutils.bst

# Language runtimes needed by build scripts
- pkgs/perl.bst
- pkgs/python.bst
- pkgs/ncurses.bst
- pkgs/gmp.bst

# Optional but useful
