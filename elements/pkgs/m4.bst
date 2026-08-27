kind: autotools

description: |
  GNU m4. Only after tools/toolchain.bst. Skip failing doc/check targets.

sources:
- kind: gnu
  name: m4
# or your tar + ref

build-depends:
- tools/toolchain.bst

variables:
  conf-local: --disable-gcc-warnings
  make-args: -j%{max-jobs} MAKEINFO=true HELP2MAN=true
