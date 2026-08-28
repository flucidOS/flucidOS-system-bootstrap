kind: stack

description: |
  Host tools from FDO. With docker.io/buildstream/buildstream:latest,
  host gcc is on /usr/bin — same as carbonOS (no bootstrap-import).

depends:
- freedesktop-sdk.bst:public-stacks/buildsystem-autotools.bst
- freedesktop-sdk.bst:components/bison.bst
- freedesktop-sdk.bst:components/gzip.bst
- freedesktop-sdk.bst:components/patch.bst
- freedesktop-sdk.bst:components/python3.bst
- freedesktop-sdk.bst:components/tar.bst
