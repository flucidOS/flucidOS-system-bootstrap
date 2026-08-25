kind: autotools

description: |
  Final GCC (C/C++) that will be used by the rest of the FlucidOS
  image pipeline. Built after glibc and the final binutils exist.

sources:
- kind: tar
  url: pkgsrc:cache-programming/gcc.tar.xz
- kind: tar
  url: pkgsrc:cache-core/mpfr.tar.xz
  directory: mpfr
- kind: tar
  url: pkgsrc:cache-core/mpc.tar.xz
  directory: mpc

depends:
- pkgs/gmp.bst

build-depends:
- pkgs/glibc.bst
- pkgs/binutils.bst
- pkgs/linux-api-headers.bst
- tools/sysroot-setup.bst

variables:
  conf-args: >-
    --prefix=%{prefix}
    --enable-languages=c,c++
    --disable-nls
    --disable-multilib
    --enable-default-pie
    --enable-default-ssp
environment:
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"
  AR: "%{bootstrap-triplet}-ar"
  RANLIB: "%{bootstrap-triplet}-ranlib"
