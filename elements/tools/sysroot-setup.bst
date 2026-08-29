kind: script
description: Prepare the FlucidOS isolated sysroot

build-depends:
- tools/import-fdo.bst

config:
  commands:
  - mkdir -p "%{sysroot}/usr/include"
  - mkdir -p "%{sysroot}/usr/lib"
  - mkdir -p "%{tools}/bin"
  - ln -sfv usr/lib "%{sysroot}/lib"
  - ln -sfv usr/lib "%{sysroot}/lib64"
