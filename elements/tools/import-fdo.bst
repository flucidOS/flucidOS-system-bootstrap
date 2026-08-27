kind: stack

description: |
  Host tools from Freedesktop SDK for the earliest bootstrap stages.
  bootstrap-import.bst is required: it stages a working host gcc, binutils,
  glibc, make, coreutils, etc. public-stacks/buildsystem-autotools alone
  does NOT provide a C compiler (only autoconf/automake/libtool scripts).

depends:
- freedesktop-sdk.bst:bootstrap-import.bst
- freedesktop-sdk.bst:public-stacks/buildsystem-autotools.bst
- freedesktop-sdk.bst:components/bison.bst
- freedesktop-sdk.bst:components/gzip.bst
- freedesktop-sdk.bst:components/patch.bst
- freedesktop-sdk.bst:components/python3.bst
- freedesktop-sdk.bst:components/tar.bst
- freedesktop-sdk.bst:components/texinfo.bst
