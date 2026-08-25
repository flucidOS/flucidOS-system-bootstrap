kind: stack

description: |
  Public API – bootstrap toolchain that links against the bootstrap’s own
  libraries (i.e. the temporary glibc living under /tools).

  Use this while building the final linux-api-headers and the final glibc
  of the real FlucidOS image. After those two exist, switch to adjusted.bst.

depends:
- pkgs/fs.bst                 # minimal filesystem layout under /tools
- all.bst
