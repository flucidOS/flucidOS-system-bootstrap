kind: make
description: dwz
sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/dwz.tar.xz
build-depends:
- tools/toolchain.bst
variables:
  make-args: -j%{max-jobs} PREFIX=%{prefix}
  make-install-args: PREFIX=%{prefix} DESTDIR=%{install-root} install
