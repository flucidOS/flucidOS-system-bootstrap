kind: autotools
description: GNU Bash (required for almost every configure script)
sources:
- kind: tar
  url: pkgsrc:cache-core/bash.tar.xz
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: >-
    --prefix=%{prefix}
    --without-bash-malloc
    --disable-nls
