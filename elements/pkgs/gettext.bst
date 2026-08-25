kind: autotools
description: GNU gettext (minimal, for build scripts)
sources:
- kind: tar
  url: pkgsrc:cache-core/gettext.tar.zst
build-depends:
- tools/import-fdo.bst
variables:
  conf-args: >-
    --prefix=%{prefix}
    --disable-nls
    --disable-java
    --disable-csharp
    --disable-libasprintf
