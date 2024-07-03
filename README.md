# inko & ivm Nix flake

## Remaining issues:

+ `ivm` fails to properly build `inko` because of missing libraries

## TODO:

+ Write `meta` attributes
+ Optionally write package tests
+ Figure out which of the `llvm_16.dev` attributes are actually needed (probably only the one in the program wrapper)
  + Figuring out I needed `.dev` was such a mess to debug

