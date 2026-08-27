kind: manual

description: Minimal /tools filesystem layout

config:
  build-commands:
  - "true"
  install-commands:
  - |
    mkdir -p "%{install-root}%{prefix}"/{bin,lib,include,share,etc,var}
    ln -sfv lib "%{install-root}%{prefix}/lib64"
