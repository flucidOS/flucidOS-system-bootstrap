kind: stack

description: |
  Public API – bootstrap toolchain that has been rewritten to link against
  the final system libraries (the real /usr glibc that will ship in the
  sealed FlucidOS image).

  This is the element the rest of the FlucidOS image pipeline should
  depend on once a usable final glibc exists.

depends:
- pkgs/fs.bst
- tools/adjusted-paths.bst    # rewrites rpaths / interpreter to final system
- all.bst
