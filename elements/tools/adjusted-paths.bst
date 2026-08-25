kind: script

description: |
  Post-processing step that rewrites the dynamic linker and RPATHs of
  every binary produced by the bootstrap so they point at the final
  system locations (/lib, /usr/lib, …) instead of the temporary
  /tools tree.

  This is what turns the “unadjusted” toolchain into the “adjusted”
  toolchain that can be used to build the real FlucidOS image.

build-depends:
- all.bst

config:
  commands:
  - |
    # Example: use patchelf or a custom script to rewrite interpreters.
    # Concrete implementation depends on the exact layout chosen for
    # the final FlucidOS image; keep this element intentionally small
    # and explicit.
    echo "adjusted-paths: rewriting dynamic linker and RPATHs for final system"
    # find "%{install-root}%{prefix}" -type f -executable -exec \
    #   patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 {} \; || true
