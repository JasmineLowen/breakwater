{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    let
      fnx = inputs.fenix.packages.${system};
      nightly = fnx.complete;
    in
    {
      packages.rust = fnx.combine [
        nightly.cargo
        nightly.clippy
        nightly.rust-analyzer
        nightly.rust-src
        nightly.rustc

        nightly.rustfmt
      ];
    };
}
