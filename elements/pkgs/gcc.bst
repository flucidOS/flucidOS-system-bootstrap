kind: manual
description: GCC cross-compiler pass 1

depends:
- filename: tools/import-fdo.bst
  type: build
- filename: tools/sysroot-setup.bst
  type: build
- filename: pkgs/binutils-cross.bst
  type: build
- filename: freedesktop-sdk.bst:components/tar.bst
  type: build

sources:
- kind: tar
  url: gnu:gcc/gcc-14.2.0/gcc-14.2.0.tar.xz
- kind: tar
  url: gnu:gmp/gmp-6.3.0.tar.xz
  directory: gmp
- kind: tar
  url: gnu:mpfr/mpfr-4.2.1.tar.xz
  directory: mpfr
- kind: tar
  url: gnu:mpc/mpc-1.3.1.tar.gz
  directory: mpc

environment:
  # Relax strict GCC 14 warnings to prevent aborts
  CFLAGS: "-O2 -g -Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types -Wno-error=format-overflow -Wno-error=format-truncation -Wno-error=stringop-overflow"
  CXXFLAGS: "-O2 -g"

config:
  configure-commands:
  - |
    for file in gcc/config/{linux,i386/linux{,64}}.h; do
      cp -v $file{,.orig}
      sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools/lib/ld@g' \
          -e 's@/usr@/tools@g' $file.orig > $file
      echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $file
      echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $file
      echo '#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"' >> $file
      echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
    done
    sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64
  - |
    mkdir -p build
    cd build
    ../configure \
      --prefix=/tools \
      --with-sysroot=/sysroot \
      --target=%{target_arch}-flucidos-linux-gnu \
      --with-newlib \
      --without-headers \
      --disable-nls \
      --disable-shared \
      --disable-multilib \
      --disable-threads \
      --disable-libatomic \
      --disable-libgomp \
      --disable-libquadmath \
      --disable-libssp \
      --disable-libvtv \
      --disable-libstdcxx \
      --disable-libcc1 \
      --disable-decimal-float \
      --enable-languages=c,c++

  build-commands:
  - |
    cd build
    # Explicitly separate targets to eliminate libgcc.mvars race condition
    make -j%{max-jobs} all-gcc
    make -j%{max-jobs} all-target-libgcc

  install-commands:
  - |
    cd build
    # Force a serial install (-j1) to prevent binary hardlinking races
    make -j1 DESTDIR="%{install-root}" install-gcc
    make -j1 DESTDIR="%{install-root}" install-target-libgcc
