# Junction to Freedesktop SDK – the only external binary seed.
# Once the bootstrap toolchain is complete this junction is discarded.

kind: junction

description: |
  Imports a pinned Freedesktop SDK release to obtain the initial
  autotools stack and a few build helpers. No FlucidOS code depends
  on Freedesktop SDK at runtime.

sources:
- kind: git
  url: gitlab:freedesktop-sdk/freedesktop-sdk.git
  track: release/24.08
  # Pin is managed by `bst source track` / project.refs
