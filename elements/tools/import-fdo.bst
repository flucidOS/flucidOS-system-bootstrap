kind: stack
description: Imports host compiler and basic tools from Freedesktop SDK.

depends:
- freedesktop-sdk.bst:public-stacks/buildsystem-autotools.bst
- freedesktop-sdk.bst:components/bison.bst
- freedesktop-sdk.bst:components/gzip.bst
- freedesktop-sdk.bst:components/patch.bst
- freedesktop-sdk.bst:components/python3.bst
- freedesktop-sdk.bst:components/tar.bst
- freedesktop-sdk.bst:components/texinfo.bst
