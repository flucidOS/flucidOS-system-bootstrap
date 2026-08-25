# FlucidOS System Bootstrap

**“Computing without Chaos”**

This repository defines the BuildStream bootstrap used to produce the toolchain
that builds FlucidOS’s sealed, read-only OCI base images (`flucid:latest`,
`flucid:nvidia`, and any local `flucid-rebase --local` variants).

The bootstrap is a **throw-away stage**. Once the final toolchain and the first
composefs-sealed bootc deployment exist, this module is no longer needed on the
running system. Nothing it installs is ever written into a live host root
filesystem.

## Why a dedicated bootstrap?

FlucidOS enforces two architectural invariants that ordinary package managers
and hybrid immutable distros cannot:

1. **Single Index Invariant** – `modules.dep` is written exactly once, against a
   closed set of modules, inside an isolated build container or CI. Runtime
   tools (DKMS, akmods, systemd-sysext) are structurally blocked.
2. **Zero local re-stitching** – the live host is always a perfect 1:1 replica
   of a server-built (or fully sealed local) image. No client-side layering of
   RPMs/DEBs is possible.

A clean bootstrap is required so that the final image build can start from a
known, auditable, from-source toolchain that does not inherit the host’s
package state or any previous system drift.

## High-level flow

```
Freedesktop SDK (junction)
        │
        ▼
  Cross toolchain          (binutils-cross → gcc-cross)
        │
        ▼
  Bootstrap sysroot        (linux-api-headers → glibc → libstdcxx → binutils → gcc)
        │
        ▼
  Full bootstrap tools     (make, bash, coreutils, autotools, …)
        │
        ▼
  adjusted.bst / unadjusted.bst   ← public API for the rest of FlucidOS
        │
        ▼
  Final FlucidOS image build (CI or flucid-rebase --local)
        │
        ▼
  Sealed composefs + bootc deployment
```

### Toolchain build order (strict)

1. `binutils-cross`
2. `gcc-cross`
3. `linux-api-headers`
4. `glibc`
5. `libstdcxx` + final `binutils`
6. final `gcc`
7. remaining packages under `elements/pkgs/`
8. (later, in the final OS build) re-build headers + glibc with the unadjusted
   bootstrap, then everything else with the adjusted bootstrap

This ordering follows the classic “temporary tools → final tools” pattern so
that the bootstrap never links against itself in a circular way.

## Public API (what the rest of FlucidOS consumes)

| Element            | Purpose                                                                 |
|--------------------|-------------------------------------------------------------------------|
| `unadjusted.bst`   | Toolchain that links against the bootstrap’s own libraries. Required while building the final `linux-api-headers` and `glibc`. |
| `adjusted.bst`     | Toolchain that links against the final system libraries. Used for everything after glibc exists. |

When you junction this project, also append `/tools/bin` to `PATH` in the
consuming project so the bootstrap tools are found.

## Project layout

```
elements/
  pkgs/                 Individual packages (autotools, gcc, glibc, …)
  tools/                Helper elements (sysroot setup, path rewriting, …)
  all.bst               Stack of every bootstrap package
  adjusted.bst          Public API – final-system linking
  unadjusted.bst        Public API – bootstrap-library linking
  freedesktop-sdk.bst   Junction to Freedesktop SDK (seed)
  bst-plugins*.bst      BuildStream plugin junctions
files/                  Auxiliary files needed by elements
patches/                Minimal patches (kept as small as possible)
plugins/                Custom BuildStream plugins (gnu source tracker, …)
tools/                  Host-side helper scripts
project.conf            BuildStream configuration
*.refs                  Source tracking (managed by BuildStream)
justfile                Convenience recipes
```

## Building

Requirements:

- BuildStream ≥ 2.0
- python3-dulwich
- [just](https://just.systems) (optional)

```bash
just build          # builds adjusted.bst
just track          # track all sources
just update         # run manual version bumps then track
just checkout adjusted.bst
```

Artifact caching, remote execution and CI are the responsibility of the
consumer (the main FlucidOS image pipeline).

## Relation to the rest of FlucidOS

- The output of this bootstrap becomes the compiler/runtime used inside the
  **ephemeral build container** (`Containerfile.local`) that produces out-of-tree
  modules and the unified `modules.dep`.
- It is never present on a running FlucidOS host. Developers use Distrobox for
  mutable userland tools; the host itself stays sealed.
- Secure Boot / MOK signing, composefs sealing and the Deployment Integrity
  Layer sit *after* this stage.

## Non-goals

- Runtime package installation or layering on a live system.
- N-way composition of optional drivers (handled by the image pipeline).
- Any form of host filesystem mutation.

## License

MIT – see `LICENSE`.
