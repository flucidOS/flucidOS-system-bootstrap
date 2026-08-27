kind: stack

description: |
  Host tools from Freedesktop SDK for the earliest bootstrap stages.
  GHA adaptation: bootstrap-import.bst stages a working host gcc, binutils,
  glibc, make, coreutils. carbonOS only lists buildsystem-autotools because
  their CI image already exposes host gcc via PATH=/usr/bin.

depends:
- freedesktop-sdk.bst:bootstrap-import.bst
- freedesktop-sdk.bst:public-stacks/buildsystem-autotools.bst
- freedesktop-sdk.bst:components/bison.bst
- freedesktop-sdk.bst:components/gzip.bst
- freedesktop-sdk.bst:components/patch.bst
- freedesktop-sdk.bst:components/python3.bst
- freedesktop-sdk.bst:components/tar.bst
- freedesktop-sdk.bst:components/texinfo.bst
