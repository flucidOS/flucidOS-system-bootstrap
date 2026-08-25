kind: make

description: |
  Linux kernel headers required to build glibc and later kernel modules.
  These headers are the only place the bootstrap touches kernel ABI;
  the final image will re-install the exact headers that match the
  kernel that ships in flucid:latest / flucid:nvidia.

sources:
- kind: tar
  url: pkgsrc:cache-core/linux.tar.xz

build-depends:
- tools/sysroot-setup.bst
- tools/import-fdo.bst

variables:
  make-args: headers_install INSTALL_HDR_PATH=%{install-root}%{prefix}

config:
  install-commands:
  - make headers_install INSTALL_HDR_PATH="%{install-root}%{prefix}"
