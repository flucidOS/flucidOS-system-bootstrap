kind: autotools

description: |
  Cross binutils – first package built (carbonOS).
  Host gcc comes only from tools/import-fdo.bst.

sources:
- kind: tar
  url: github:flucidOS/pkg-src/releases/download/cache-core/binutils.tar.xz

build-depends:
- freedesktop-sdk.bst:components/texinfo.bst
- tools/import-fdo.bst

environment:
  CFLAGS: "%{cflags}"
  CXXFLAGS: "%{cxxflags}"
  LDFLAGS: "%{ldflags}"

variables:
  build-dir: build
  
  # Relax GCC 14 strictness for older autotools and clear target sysroot flags
  cflags: "-O2 -g -Wno-error=implicit-int -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types -Wno-error=format-overflow -Wno-error=format-truncation -Wno-error=stringop-overflow"
  cxxflags: "-O2 -g"
  ldflags: ""

  conf-local: >-
    --with-sysroot=%{bootstrap-sysroot}
    --target=%{bootstrap-triplet}
    --with-lib-path=%{libdir}
    --disable-nls --disable-werror --disable-plugins
        
config:
  configure-commands:
    (<):
    - |
      # binutils re-enables -Werror by default whenever bfd/development.sh
      # says development=true (true for git/dev snapshots, false in real
      # GNU release tarballs). Our mirrored source tarball still has
      # development=true, so gas/ld/etc. re-add -Werror to their compile
      # flags AFTER our CFLAGS, silently overriding --disable-werror and
      # any -Wno-error=... we set in CFLAGS (GCC: last matching flag on
      # the command line wins). Flip it here instead of chasing every
      # individual warning category one GCC-14 error at a time.
      if [ -f bfd/development.sh ]; then
        sed -i 's/^development=true/development=false/' bfd/development.sh
      fi
  install-commands:
    (>):
    - ln -sv lib %{install-root}%{prefix}/lib64
    - rm -rf %{install-root}%{datadir}/info
    - rm -rf %{install-root}%{libdir}/bfd-plugins
