kind: stack

description: |
  libstdc++ is produced by the final gcc build. This element exists so
  that other packages can declare an explicit dependency on the C++
  runtime without pulling the whole compiler.

depends:
- pkgs/gcc.bst
