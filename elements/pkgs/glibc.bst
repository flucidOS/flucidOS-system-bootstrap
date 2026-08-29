kind: autotools
description: Bootstrap glibc installed into /sysroot

depends:
- filename: tools/import-fdo.bst
  type: build
- filename: tools/sysroot-setup.bst
  type: build
- filename: pkgs/linux-api-headers.bst
  type: build
- filename: pkgs/binutils-cross.bst
  type: build
- filename: pkgs/gcc-cross.bst
  type: build

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/glibc.tar.xz
  ref: 64c61decc3bfca6f0a01e573aca60fe1f1f671e04cac6aa61de9f3a155601e01

environment:
  PATH: "/tools/bin:/usr/bin:/bin:/usr/sbin:/sbin"
  CC: "%{bootstrap-triplet}-gcc"
  CXX: "%{bootstrap-triplet}-g++"

variables:
  bootstrap-triplet: "%{target_arch}-flucidos-linux-gnu"
  bootstrap-sysroot: "/sysroot"

  # Out-of-tree build: BuildStream creates ./build and runs every command inside it.
  command-subdir: build
  conf-root: ".."

  # Disable autogen/autoreconf fallback to preserve our sed patches
  autogen: ""
  prefix: /usr

  # Inject bypasses for the crt1.o chicken-and-egg configure tests
  conf-local: >-
    --host=%{bootstrap-triplet}
    --with-headers=%{bootstrap-sysroot}/usr/include
    --disable-multilib
    --disable-nls
    --enable-kernel=4.19
    libc_cv_slibdir=/usr/lib
    libc_cv_forced_unwind=yes
    libc_cv_c_cleanup=yes
    libc_cv_cxx_far_data=no

config:
  configure-commands:
    (<):
    - |
      # Neutralize the fatal regex version check for modern binutils/gcc
      sed -i 's/-n "\$critic_missing" &&/-n "" \&\&/' ../configure

  build-commands:
    (=):
    - make -j%{max-jobs}

  install-commands:
    (=):
    - |
      # Force a serial install to prevent GCC/Glibc race conditions
      make -j1 DESTDIR="%{install-root}" install
    - |
      # Move the natively installed tree into the sysroot
      mkdir -p "%{install-root}%{bootstrap-sysroot}"
      
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
