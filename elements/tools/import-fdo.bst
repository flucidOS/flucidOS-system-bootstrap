kind: stack

description: |
  Imports a minimal set of tools from the Freedesktop SDK junction that
  are needed only while the bootstrap is still incomplete (texinfo,
  basic shell utilities, etc.). Once the native bootstrap tools exist
  this stack is no longer required.

depends:
- freedesktop-sdk.bst:bootstrap-import.bst
# Add further minimal FDO components here only if strictly necessary.
# Prefer building them from source under pkgs/ once the toolchain is ready.
