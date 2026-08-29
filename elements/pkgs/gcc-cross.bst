kind: autotools
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
  ref: a7b39bc69cbf9e25826c5a60ab26477001f7c08d85cec04bc0e29cabed6f3cc9
- kind: tar
  url: gnu:gmp/gmp-6.3.0.tar.xz
  directory: gmp
  ref: a3c2b80201b89e68616f4ad30bc66aee4927c3ce50e33929ca819d5c43538898
- kind: tar
  url: gnu:mpfr/mpfr-4.2.1.tar.xz
  directory: mpfr
  ref: 277807353a6726978996945af13e52829e3abd7a9a5b7fb2793894e18f1fcbb2
- kind: tar
  url: gnu:mpc/mpc-1.3.1.tar.gz
  directory: mpc
  ref: ab642492f5cf882b74aa0cb730cd410a81edcdbec895183ce930e706c1c759b8

environment:
  # Relax strict GCC 14 warnings to prevent aborts
  CFLAGS: "-O2 -g -Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types -Wno-error=format-overflow -Wno-error=format-truncation -Wno-error=stringop-overflow"
  CXXFLAGS: "-O2 -g"

variables:
  # Out-of-tree build: BuildStream creates ./build in the sandbox and runs
  # every command there. conf-root then has to be set explicitly to ".."
  # (it does NOT default to "..", it defaults to "." — same dir as
  # command-subdir) so configure is found back up in build-root.
  command-subdir: build
  conf-root: ".."

  # Crucial: Disable the plugin from running autoreconf
  autogen: ""

  # Override BuildStream's default /usr paths
  prefix: /tools
  sysconfdir: /tools/etc
  localstatedir: /tools/var
  infodir: /tools/share/info
  mandir: /tools/share/man

  conf-local: >-
    --with-sysroot=/sysroot
    --target=%{target_arch}-flucidos-linux-gnu
    --with-newlib
    --without-headers
    --disable-nls
    --disable-shared
    --disable-multilib
    --disable-threads
    --disable-libatomic
    --disable-libgomp
    --disable-libquadmath
    --disable-libssp
    --disable-libvtv
    --disable-libstdcxx
    --disable-libcc1
    --disable-decimal-float
    --enable-languages=c,c++

config:
  configure-commands:
    (<):
    - |
      for file in ../gcc/config/{linux,i386/linux{,64}}.h; do
        cp -v $file{,.orig}
        sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools/lib/ld@g' \
            -e 's@/usr@/tools@g' $file.orig > $file
        echo '#undef STANDARD_STARTFILE_PREFIX_1' >> $file
        echo '#undef STANDARD_STARTFILE_PREFIX_2' >> $file
        echo '#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"' >> $file
        echo '#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
      done
      sed -e '/m64=/s/lib64/lib/' -i.orig ../gcc/config/i386/t-linux64
