#!/usr/bin/env bash

if [ ! -d "behave" ]; then
    git submodule update --init --recursive
fi

nix-shell -p "python311.withPackages(ps: with ps; [ castxml pygccxml ])" --run "python castxml.py behave/src/behave/behaveRun.h"
