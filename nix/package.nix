{ inputs, ... }:
{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      packages.breakwater =
        let
          craneLib = (inputs.crane.mkLib pkgs).overrideToolchain (_: self'.packages.rust);
          # if the version is not specified by the user, try to get it from the `Cargo.toml` file
          pnameVersion = craneLib.crateNameFromCargoToml { cargoToml = ../Cargo.toml; };
          inherit (pnameVersion) version pname;
          # cleaned sources
          src = craneLib.cleanCargoSource ./../breakwater/src;
          # artifact derivation
          cargoArtifacts = craneLib.buildDepsOnly { inherit src pname version; };
        in
        craneLib.buildPackage {
          inherit
            src
            pname
            version
            cargoArtifacts
            ;
        };
    };
}
