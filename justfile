# FlucidOS System Bootstrap – convenience recipes
# Requires: BuildStream ≥ 2.0, just

_default: help

# Build the complete adjusted bootstrap toolchain
@build:
    bst build elements/adjusted.bst

[private]
alias b := build

# Remove tracking files so the next track is clean
@_untrack:
    [ -f ./project.refs ] && rm -f ./project.refs || true
    [ -f ./junction.refs ] && rm -f ./junction.refs || true

# Track all sources (plugins, freedesktop-sdk junction, packages)
@track: _untrack
    bst source track elements/bst-plugins.bst
    bst source track elements/bst-plugins-experimental.bst
    bst source track elements/freedesktop-sdk.bst
    bst source track -d all elements/all.bst

# Update package versions (manual step) then re-track
@update: _untrack && track
    tools/manual-updates

[private]
alias up := update

# Check out a built element into ./result/
@checkout ELEMENT:
    [ -d result ] && rm -rf result/
    bst --no-strict artifact checkout -d none --no-integrate {{ELEMENT}} --directory result/

# Show available recipes
@help:
    echo "FlucidOS System Bootstrap"
    echo "USAGE: just <recipe> [ARGS...]"
    echo
    just --list
