kind: autotools

description: |
  Bootstrap glibc installed into %{bootstrap-sysroot} (carbonOS / LFS).

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/glibc.tar.xz

build-depends:
- tools/import-fdo.bst
- tools/sysroot-setup.bst
- pkgs/linux-api-headers.bst
- pkgs/binutils-cross.bst
- pkgs/gcc-cross.bst

environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"

variables:
  build-dir: build
  conf-local: >-
    --host=%{bootstrap-triplet}
    --prefix=/usr
    --with-headers=%{bootstrap-sysroot}/usr/include
    --disable-multilib
    --disable-nls
    --enable-kernel=4.19
    libc_cv_slibdir=/usr/lib

config:
  install-commands:
    (>):
    - |
      mkdir -p "%{install-root}%{bootstrap-sysroot}"
      # Move installed tree under sysroot
      if [ -d "%{install-root}/usr" ]; then
        cp -a "%{install-root}/usr" "%{install-root}%{bootstrap-sysroot}/"
        rm -rf "%{install-root}/usr"
      fi
      if [ -d "%{install-root}/lib" ]; then
        cp -a "%{install-root}/lib" "%{install-root}%{bootstrap-sysroot}/"
        rm -rf "%{install-root}/lib"
      fi
      if [ -d "%{install-root}/lib64" ]; then
        cp -a "%{install-root}/lib64" "%{install-root}%{bootstrap-sysroot}/"
        rm -rf "%{install-root}/lib64"
      fi
