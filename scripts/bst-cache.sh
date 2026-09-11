#!/usr/bin/env bash
#
# bst-cache.sh -- persist BuildStream's local cache directories to/from GHCR.
#
# This is the "GHCR/ORAS snapshot" caching approach: no BuildStream artifact
# server, no database, no long-running service -- just tar up a BuildStream
# cache subdirectory, push it to GHCR as a plain OCI artifact with `oras`,
# and pull it back down again at the start of the next run. Whatever GHCR
# access your workflow already has (a `GITHUB_TOKEN` with `packages: write`)
# is all that's required.
#
# Usage:
#   bst-cache.sh restore <subdir>
#   bst-cache.sh save    <subdir>
#
# <subdir> names a directory under $BST_CACHE_DIR, e.g. "sources" or "cas"
# (BuildStream's two cache directories: fetched source tarballs/git mirrors,
# and the content-addressable store of built artifacts).
#
# Required environment:
#   GHCR_CACHE_REPO   Base OCI repo, e.g. ghcr.io/owner/repo/bst-cache
#                     (must already be lowercase -- GHCR requires this).
#                     The subdir is appended as a suffix, e.g.
#                     ghcr.io/owner/repo/bst-cache-sources
#   CACHE_TAG         Tag to save under / prefer when restoring
#                     (e.g. a sanitized branch name).
#
# Optional environment:
#   FALLBACK_TAG      Tag to fall back to on restore if CACHE_TAG isn't found
#                     yet (default: "main"). Mirrors actions/cache's
#                     restore-keys behaviour.
#   BST_CACHE_DIR     Base cache directory (default: "$HOME/bst-cache").
#                     This is expected to be bind-mounted into the
#                     BuildStream container at ~/.cache/buildstream.
#   ZSTD_ARGS         Compression args passed to zstd (default: "-T0 -3",
#                     i.e. fast, multi-threaded, low compression -- CI time
#                     usually matters more than a few % of archive size).
#
set -euo pipefail

log() {
  echo "[bst-cache] $*" >&2
}

usage() {
  echo "usage: $0 <restore|save> <subdir>" >&2
  exit 1
}

[[ $# -eq 2 ]] || usage
ACTION="$1"
SUBDIR="$2"

: "${GHCR_CACHE_REPO:?GHCR_CACHE_REPO must be set, e.g. ghcr.io/owner/repo/bst-cache}"
: "${CACHE_TAG:?CACHE_TAG must be set, e.g. a sanitized branch name}"
FALLBACK_TAG="${FALLBACK_TAG:-main}"
BST_CACHE_DIR="${BST_CACHE_DIR:-$HOME/bst-cache}"
ZSTD_ARGS="${ZSTD_ARGS:--T0 -3}"

REPO="${GHCR_CACHE_REPO}-${SUBDIR}"
TARGET_DIR="${BST_CACHE_DIR}/${SUBDIR}"
MEDIA_TYPE="application/vnd.flucidos.bst-cache.${SUBDIR}.v1.tar+zstd"

# Pull one tag's snapshot into TARGET_DIR. Returns non-zero (without dying,
# since we're under `set -e`) if the tag doesn't exist or has no content.
pull_tag() {
  local tag="$1"

  if ! oras manifest fetch "${REPO}:${tag}" >/dev/null 2>&1; then
    return 1
  fi

  local workdir
  workdir="$(mktemp -d)"

  log "found ${REPO}:${tag}, restoring into ${TARGET_DIR}"
  oras pull "${REPO}:${tag}" -o "$workdir"

  local archive
  archive="$(find "$workdir" -maxdepth 1 -type f | head -n1)"
  if [[ -z "$archive" ]]; then
    log "manifest for '${tag}' had no archive inside it -- ignoring"
    rm -rf "$workdir"
    return 1
  fi

  mkdir -p "$TARGET_DIR"
  case "$archive" in
    *.zst) tar --zstd -xpf "$archive" -C "$TARGET_DIR" ;;
    *.gz)  tar -xpzf "$archive" -C "$TARGET_DIR" ;;
    *)     tar -xpf "$archive" -C "$TARGET_DIR" ;;
  esac

  rm -rf "$workdir"
}

do_restore() {
  mkdir -p "$TARGET_DIR"

  if pull_tag "$CACHE_TAG"; then
    log "restored '${SUBDIR}' cache from tag '${CACHE_TAG}'"
    return 0
  fi

  if [[ "$CACHE_TAG" != "$FALLBACK_TAG" ]] && pull_tag "$FALLBACK_TAG"; then
    log "restored '${SUBDIR}' cache from fallback tag '${FALLBACK_TAG}'"
    return 0
  fi

  log "no existing '${SUBDIR}' cache found for '${CACHE_TAG}' or '${FALLBACK_TAG}' -- starting cold (this is normal on the first run)"
}

do_save() {
  if [[ ! -d "$TARGET_DIR" ]] || [[ -z "$(ls -A "$TARGET_DIR" 2>/dev/null || true)" ]]; then
    log "nothing to save: ${TARGET_DIR} is empty or missing"
    return 0
  fi

  local workdir archive
  workdir="$(mktemp -d)"
  archive="${workdir}/${SUBDIR}.tar.zst"

  log "snapshotting ${TARGET_DIR}"
  # -I (not --zstd) so we can pass custom zstd args like -T0 for threading.
  tar --exclude='./tmp' --exclude='./logs' \
    -I "zstd ${ZSTD_ARGS}" -cpf "$archive" -C "$TARGET_DIR" .

  log "pushing snapshot to ${REPO}:${CACHE_TAG} ($(du -h "$archive" | cut -f1))"
  oras push "${REPO}:${CACHE_TAG}" \
    --artifact-type "$MEDIA_TYPE" \
    "$archive"

  rm -rf "$workdir"
}

case "$ACTION" in
  restore) do_restore ;;
  save)    do_save ;;
  *) usage ;;
esac
