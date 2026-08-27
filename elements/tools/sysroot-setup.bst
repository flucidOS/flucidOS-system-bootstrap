kind: manual

description: |
  Creates %{bootstrap-sysroot} layout used by cross tools.
  (carbonOS pattern)

build-depends:
- tools/import-fdo.bst
- freedesktop-sdk.bst:bootstrap-import.bst

config:
  build-commands:
  - |
    mkdir -p "%{install-root}%{bootstrap-sysroot}"
    mkdir -p "%{install-root}%{bootstrap-sysroot}/usr"
    ln -sfv usr/lib "%{install-root}%{bootstrap-sysroot}/lib"
    ln -sfv usr/lib "%{install-root}%{bootstrap-sysroot}/lib64"
    ln -sfv lib "%{install-root}%{bootstrap-sysroot}/usr/lib64"
    mkdir -p "%{install-root}%{bootstrap-sysroot}/usr/include"
