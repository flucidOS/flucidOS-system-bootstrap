# FlucidOS System Bootstrap

BuildStream project that produces the native `/tools` bootstrap toolchain for FlucidOS.

Layout follows [carbonOS system-bootstrap](https://gitlab.com/carbonOS/system-bootstrap) and Freedesktop SDK practice, adapted for GitHub Actions:

| Adaptation | Why |
|------------|-----|
| `freedesktop-sdk.bst:bootstrap-import.bst` in `import-fdo` | GHA runners have no host gcc inside the BuildStream sandbox |
| `kind: tar` + `github:flucidOS/pkg-src/...` | You generate your own source tarballs |
| `bootstrap-triplet: x86_64-flucidOS-linux-gnu` | Avoid collision with host tool names |
| Strict mid-stage barrier | `gmp` / `libstdcxx` never depend on `toolchain.bst` |

## Bootstrap order

1. `import-fdo` (FDO host tools + bootstrap-import)
2. `binutils-cross` → `gcc-cross` → `linux-api-headers` → `glibc`
3. Mid-stage: `gmp`, `libstdcxx`
4. Final: `binutils`, `gcc`
5. `toolchain.bst` then all remaining packages

## Build

```bash
# Track refs for any new/changed tar sources (commit project.refs)
bst source track -d all all.bst

bst build all.bst
```

## CI notes

- Run `bst source track` when adding packages, then commit `project.refs`.
- Every non-early package must `build-depends: [tools/toolchain.bst]`.
