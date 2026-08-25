kind: manual

description: |
  Creates the minimal directory layout and symlinks required for the
  bootstrap sysroot (/sysroot). Runs early so that subsequent packages
  can install into a consistent tree.

build-depends:
- freedesktop-sdk.bst:bootstrap-import.bst   # or equivalent minimal host tools

config:
  build-commands:
  - |
    mkdir -p "%{install-root}%{bootstrap-sysroot}"/{usr,lib,bin,sbin,etc,var,tmp}
    mkdir -p "%{install-root}%{bootstrap-sysroot}/usr"/{bin,sbin,lib,include,share}
    # Provide the classic /lib → /usr/lib etc. layout expected by many packages
    ln -sf usr/lib  "%{install-root}%{bootstrap-sysroot}/lib"
    ln -sf usr/bin  "%{install-root}%{bootstrap-sysroot}/bin"
    ln -sf usr/sbin "%{install-root}%{bootstrap-sysroot}/sbin"
