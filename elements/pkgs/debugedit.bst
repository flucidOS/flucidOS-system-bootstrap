kind: autotools

sources:
- kind: git_tag
  url: sourceware:debugedit.git
  track: main

depends:
- pkgs/glibc.bst
- pkgs/elfutils.bst

runtime-depends:
- pkgs/dwz.bst
- pkgs/cpio.bst # Needed to copy sources into /usr/src
- pkgs/xz.bst # Needed for minidebuginfo
- pkgs/gdb.bst # Needed for gdb-add-index

build-depends:
- pkgs/help2man.bst
- tools/toolchain.bst
