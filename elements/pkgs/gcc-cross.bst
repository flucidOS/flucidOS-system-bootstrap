kind: autotools

description: |
  GCC pass 1 (cross) – carbonOS / LFS chapter 5 style.
  No libc yet; --with-newlib --without-headers.

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/gcc.tar.xz
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/mpfr.tar.xz
  directory: mpfr
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/mpc.tar.xz
  directory: mpc
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/gmp.tar.xz
  directory: gmp

build-depends:
- tools/import-fdo.bst
- pkgs/binutils-cross.bst
- tools/sysroot-setup.bst

variables:
  build-dir: build

  cflags: "-O2 -g -Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types"
  cxxflags: "-O2 -g"
  ldflags: ""
  
  conf-local: >-
    --target=%{bootstrap-triplet}
    --with-sysroot=%{bootstrap-sysroot}
    --with-glibc-version=2.11
    --with-newlib
    --without-headers
    --with-local-prefix=%{prefix}
    --with-native-system-header-dir=%{includedir}
    --disable-nls
    --disable-shared
    --disable-multilib
    --disable-decimal-float
    --disable-threads
    --disable-libatomic
    --disable-libgomp
    --disable-libquadmath
    --disable-libssp
    --disable-libvtv
    --disable-libstdcxx
    --enable-deterministic-archives
    --enable-linker-build-id
    --enable-languages=c,c++

config:
  configure-commands:
    (<):
    - |
      for file in gcc/config/{linux,i386/linux{,64}}.h; do
        cp -v $file{,.orig}
        sed -e 's@/lib\(64\)\?\(32\)\?/ld@%{libdir}/ld@g' \
            -e 's@/usr@%{prefix}@g' $file.orig > $file
        echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $file
        echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $file
        echo '#define STANDARD_STARTFILE_PREFIX_1 "%{libdir}/"' >> $file
        echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
      done
    - sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
