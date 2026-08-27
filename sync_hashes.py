#!/usr/bin/env python3
"""
Sync project.refs to match the actual bytes of the locally-built lookaside
tarballs. Reads each element's own `sources:` list to know which ref index
maps to which tarball -- required for multi-source elements like gcc.bst
(main + mpfr + mpc) / gcc-cross.bst (+ gmp), where a plain "<name>.bst" text
match can't tell which of several bare `- ref:` entries is which.
"""
import hashlib
import sys
from pathlib import Path

import yaml

REFS_PATH = Path("project.refs")
ELEMENTS_DIR = Path("elements")
CACHE_DIR = Path.home() / "pkg-fetcher" / "lookaside-cache"

PKGSRC_PREFIX = "pkgsrc:"


def sha256_of(path: Path) -> str:
    h = hashlib.sha256()
    with open(path, "rb") as f:
        while chunk := f.read(1 << 20):
            h.update(chunk)
    return h.hexdigest()


def tar_sources(element_path: Path):
    """Ordered list of pkgsrc tar.xz refs (e.g. 'cache-core/gmp.tar.xz')
    from an element's `sources:` list, in file order -- this order is what
    project.refs' bare `- ref:` list is positionally keyed against."""
    data = yaml.safe_load(element_path.read_text()) or {}
    out = []
    for src in data.get("sources", []):
        if src.get("kind") != "tar":
            continue
        url = src.get("url", "")
        if url.startswith(PKGSRC_PREFIX):
            out.append(url[len(PKGSRC_PREFIX):])
    return out


def main():
    if not REFS_PATH.exists():
        sys.exit("Error: project.refs not found in current directory.")
    if not CACHE_DIR.exists():
        sys.exit(f"Error: cache directory not found at {CACHE_DIR}")

    refs = yaml.safe_load(REFS_PATH.read_text())
    project_name = next(iter(refs["projects"]))
    entries = refs["projects"][project_name]

    updated = 0
    for element_rel, ref_list in entries.items():
        element_path = ELEMENTS_DIR / element_rel
        if not element_path.exists():
            continue

        tar_rels = tar_sources(element_path)
        if len(tar_rels) != len(ref_list):
            print(f"[!] {element_rel}: {len(ref_list)} ref(s) but "
                  f"{len(tar_rels)} tar source(s) in the element -- "
                  f"skipping, check by hand")
            continue

        for i, (tar_rel, ref_entry) in enumerate(zip(tar_rels, ref_list)):
            # "cache-core/gmp.tar.xz" -> lookaside-cache/core/gmp.tar.xz
            # (the pkgsrc alias' "cache-" prefix names the GitHub release
            # tag / push-lookaside.sh's category grouping, not a real dir).
            cache_subpath = tar_rel.replace("cache-", "", 1)
            local_tar = CACHE_DIR / cache_subpath
            if not local_tar.exists():
                continue

            new_hash = sha256_of(local_tar)
            old_hash = ref_entry.get("ref")
            if old_hash != new_hash:
                print(f"Updated {element_rel} [{i}] ({tar_rel}): "
                      f"{(old_hash or '')[:8]}... -> {new_hash[:8]}...")
                ref_entry["ref"] = new_hash
                updated += 1

    REFS_PATH.write_text(yaml.safe_dump(refs, sort_keys=False, default_flow_style=False))
    print(f"\nSuccessfully synced {updated} hash(es) to project.refs!")


if __name__ == "__main__":
    main()
