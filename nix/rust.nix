{ inputs, ... }:
{
  perSystem =
    { pkgs, system, ... }:
    let
      fnx = inputs.fenix.packages.${system};
      stable = fnx.stable;
      nightly = fnx.complete;
    in
    {
      packages.rust = fnx.combine [
        stable.cargo
        stable.clippy
        stable.rust-analyzer
        stable.rust-src
        stable.rustc

        nightly.rustfmt
      ];
    };
}
