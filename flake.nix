{
  description = ''
    breakwater is a very fast
    [Pixelflut](https://wiki.cccgoe.de/wiki/Pixelflut) server written in Rust.
    It is heavily inspired by
    [Shoreline](https://github.com/TobleMiner/shoreline).
  '';

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    fenix.url = "github:nix-community/fenix";
    crane.url = "github:ipetkov/crane";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [ ./nix ];
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    };
}
