kind: autotools

description: |
  Cross binutils.
  pkg-src tree is git-style (bfd/development.sh development=true), which
  re-enables -Werror after configure. Force development=false before
  configure; pass -Wno-error only to make (not environment CFLAGS — that
  breaks the configure link test: "C compiler cannot create executables").

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz

build-depends:
- freedesktop-sdk.bst:components/texinfo.bst
- tools/import-fdo.bst

variables:
  build-dir: build
  conf-local: >-
    --with-sysroot=%{bootstrap-sysroot}
    --target=%{bootstrap-triplet}
    --with-lib-path=%{libdir}
    --disable-nls
    --disable-werror
    --disable-plugins
  # Only for the build, not configure
  make-args: -j%{max-jobs} CFLAGS="-O2 -Wno-error" CXXFLAGS="-O2 -Wno-error"

config:
  configure-commands:
    (<):
    - |
      if [ -f bfd/development.sh ]; then
        sed -i 's/^development=true/development=false/' bfd/development.sh
      fi
  install-commands:
    (>):
    - ln -sv lib %{install-root}%{prefix}/lib64
    - rm -rf %{install-root}%{datadir}/info
    - rm -rf %{install-root}%{libdir}/bfd-plugins
