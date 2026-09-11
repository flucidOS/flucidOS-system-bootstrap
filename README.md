# flucidOS Bootstrap

This is the bootstrap module used to build flucidOS. It starts itself off
with a few packages from freedesktop-sdk (mostly their autotools stack),
and then builds a usable system image in such a way that it won't conflict
with a "final" OS build

## Usage

To use the bootstrap, simply junction off of it. You can pull `unadjusted.bst`
through the junction to get a bootstrap toolchain that produces functional
executables that link against the bootstrap's libraries (this will be necessary
to build linux-headers and glibc). Once you build a functional glibc, however,
you can pull `adjusted.bst` through the junction. This will give you a bootstrap
toolchain that will link binaries against the final system's glibc & other libraries.

You'll also need to add `/tools/bin` to the end of `PATH` in your buildstream project

## Bootstrap Process

flucidOS ultimately bootstraps itself off of the
[Freedesktop SDK](https://gitlab.com/freedesktop-sdk/freedesktop-sdk). A cross-toolchain
is built to separate flucidOS's libraries from fd.o's, and then the cross-toolchain is
used to build flucidOS's system-bootstrap toolchain. Once the system-bootstrap is built,
the fd.o SDK is discarded. The system-bootstrap module is then used to build flucidOS's
final toolchain, along with some other related packages, and is finally discarded.

This bootstrap was originally heavily inspired by the instructions in LinuxFromScratch
v9 Chapter 5, though keep in mind that it is not identical & no effort will be made to
keep up-to-date with the instructions in LFS.

Here's the toolchain build order:
1. binutils-cross
2. gcc-cross
3. linux-api-headers
4. glibc
5. libstdcxx, binutils
6. gcc
7. Everything else in `pkgs/`
8. (in final OS, using unadjusted bootstrap) linux-api-headers
9. (in final OS, using unadjusted bootstrap) glibc
10. (in final OS, using adjusted bootstrap) everything else

## Project structure

- `elements/`: [BuildStream](https://buildstream.build) elements that define the bootstrap's components
    - `pkgs/`: Individual packages that make up the bootstrap
    - `tools/`: Elements that are there to help the build in some way
    - `all.bst`: List of all the packages that make up the bootstrap toolchain
    - `freedesktop-sdk.bst`: Junction to fdo sdk
    - `bst-plugins.bst` and `bst-plugins-experimental.bst`: Buildstream plugin junctions
    - `unadjusted.bst`: API. Bootstrap toolchain that links against bootstrap libs
    - `adjusted.bst`: API. Bootstrap toolchain that links against final system libs
- `files/`: Various auxiliary files that are part of flucidOS's build (i.e. default config)
- `patches/`: Patches that get applied onto packages in `elements/`. Ideally kept to a minimum
- `plugins/`: Custom BuildStream plugins that are used in `elements/`
- `project.conf`: The BuildStream project configuration
- `*.refs`: Used by BuildStream to keep track of the versions of various components
- `result/`: Standard location that `just checkout` exports BuildStream artifacts to

## Build instructions

#### Auto-building

If you followed the usage instructions, the bootstrap should be built & rebuilt as appropriate
automatically by Buildstream when a downstream project junctions off of it. However, if you want
to build the bootstrap manually for whatever reason, keep reading.

#### Dependencies

First, you need to install build dependencies. If you are running flucidOS, this
is simple:
```bash
TODO
```

Your system should now be set up for flucidOS development. If you are not
running flucidOS, you'll need to install these packages to compile the bootstrap module:

- buildstream 2.0.1+ (with `buildbox-casd`, `buildbox-fuse` and `buildbox-run-bubblewrap` -- see
  [BuildStream's install docs](https://docs.buildstream.build/master/main_install.html), or just
  use `docker.io/buildstream/buildstream:latest`, which bundles all of this)
- python3-dulwich
- [just](https://just.systems) (not needed to use via a junction!)

#### Building

To build the bootstrap, simply run `just build`. This will build the entire
bootstrap module. You can then use buildstream's built-in artifact caching & related
features to handle the output of this build efficiently.

## Continuous integration (GitHub Actions)

This repository builds itself on every push/PR using GitHub Actions -- see
[`.github/workflows/bootstrap.yml`](.github/workflows/bootstrap.yml). The workflow:

1. Runs `docker.io/buildstream/buildstream:latest` (the same image referenced above) in
   `--privileged` mode, since BuildStream needs to run element build commands in a nested,
   bubblewrap-sandboxed container.
2. Restores BuildStream's local `sources` and `cas` (build/artifact) caches before the build,
   and snapshots + saves them again afterwards -- see "Persistent caching" below.
3. Builds `adjusted.bst`, runs the toolchain smoke test (`tools/test.bst`), checks out the
   result, and uploads it as a workflow artifact.

### Persistent caching: GHCR + ORAS, no cache server

BuildStream normally gets its speed from a long-lived local cache (fetched sources under
`~/.cache/buildstream/sources`, and built artifacts in the CAS under `~/.cache/buildstream/cas`).
On GitHub-hosted runners that cache would otherwise start from zero on every single job, which
would mean rebuilding the entire cross-toolchain (glibc, two passes of gcc, binutils, gdb, python,
perl, ...) from scratch every time.

Instead of standing up a dedicated BuildStream artifact/source cache server, this project
snapshots those two cache directories, compresses them, and pushes them to **GHCR** (GitHub
Container Registry) as plain OCI artifacts using **[ORAS](https://oras.land)**. GHCR is already
available to any repository with `packages: write` permission on its `GITHUB_TOKEN` -- there's
no extra service, database, or long-lived infrastructure to run or pay for.

- [`scripts/bst-cache.sh`](scripts/bst-cache.sh) implements `restore` and `save` for a given
  cache subdirectory (`sources` or `cas`), talking to `oras` directly.
- Each cache is stored under `ghcr.io/<owner>/<repo>/bst-cache-<sources|cas>`, tagged with a
  sanitized branch/ref name. If no cache exists yet for the current branch, the workflow falls
  back to the cache tagged `main`, similar to `actions/cache`'s `restore-keys`.
- The cache is saved again at the end of every run (even if the build failed), so the very next
  run on that branch picks up right where the previous one left off.
- `sources` and `cas` are cached and pushed independently, since sources change far less often
  than build artifacts do -- there's no need to re-upload the (large, slow-changing) sources
  cache just because a build artifact changed.

Because the OCI artifacts pushed for a given tag accumulate historical, untagged versions in
GHCR over time (only the tag pointer moves; old digests remain and count toward storage until
pruned), there's an optional weekly [`cache-gc.yml`](.github/workflows/cache-gc.yml) workflow that
prunes old, untagged versions of the `bst-cache-*` packages. Adjust `package-name` in that
workflow if your GHCR package path differs from the default.

**First run:** the very first build on a fresh repository won't find any cache and will build
everything from scratch (this is expected and can take a long time -- it's building a full
cross-toolchain). Every run after that should be significantly faster.

**A note on sandboxing:** some GitHub-hosted runner images (Ubuntu 24.04+) restrict unprivileged
user namespace creation via AppArmor, which is what `bwrap`/BuildStream's sandbox relies on. The
workflow runs the build container with `--privileged` specifically to avoid this. If you move
this workflow to a self-hosted runner where privileged containers aren't available, see
[this note on Ubuntu 24.04 + bubblewrap](https://etbe.coker.com.au/2024/04/24/ubuntu-24-04-bubblewrap/)
for the AppArmor-profile-based alternative.
