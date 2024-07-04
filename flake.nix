{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          inko = pkgs.callPackage ./inko.nix { };
          ivm = pkgs.callPackage ./ivm.nix { };
          default = self.packages.${system}.inko;
        };
      });
}
