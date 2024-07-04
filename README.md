# inko & ivm Nix flake

## Remaining issues:

+ [x] `ivm` fails to properly build `inko` because of missing libraries

## TODO:

+ [x] Write `meta` attributes
+ [ ] Optionally write package tests
+ [x] Figure out which of the `llvm_16.dev` attributes are actually needed (probably only the one in the program wrapper)
  + [x] Figuring out I needed `.dev` was such a mess to debug
+ [ ] Upstream to nixpkgs

