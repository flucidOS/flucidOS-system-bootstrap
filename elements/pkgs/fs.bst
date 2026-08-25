kind: manual

description: |
  Minimal filesystem layout that every bootstrap package installs into.
  Creates /tools and the expected directory hierarchy so that later
  packages can assume a consistent prefix.

config:
  build-commands:
  - |
    mkdir -p "%{install-root}%{prefix}"/{bin,sbin,lib,include,share,etc,var}
    mkdir -p "%{install-root}%{prefix}/share"/{man,info,doc}
    # Provide a /tools/lib64 → lib convenience symlink on 64-bit
    ln -sf lib "%{install-root}%{prefix}/lib64" || true
