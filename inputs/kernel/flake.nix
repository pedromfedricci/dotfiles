{
  description = "The latest Linux kernel package";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

  # Systems on default-linux: ["x86_64-linux", "aarch64-linux"].
  inputs.systems.url = "github:nix-systems/default-linux";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.flake-utils.inputs.systems.follows = "systems";

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        legacyPackages = {
          latest = pkgs.linuxPackages_latest;
        };
      }
    );
}
