kind: autotools

description: |
  GNU m4. Only after tools/toolchain.bst.

sources:
- kind: tar
  url: pkgsrc:cache-core/m4.tar.xz
  # ref: must exist in project.refs

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-gcc-warnings
  make-args: -j%{max-jobs} MAKEINFO=true HELP2MAN=true
