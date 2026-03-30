{
  inputs,
  self,
  ...
}: let
  inherit (import ../_data/defaults.nix) host user;
in {
  flake.nixosConfigurations.thinkpad = inputs.stable.lib.nixosSystem {
    specialArgs = {inherit inputs host user;};
    modules = [
      ./_config/thinkpad.nix

      ./_hardware/lenovo-thinkpad-e14-amd.nix
      inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd

      {nixpkgs.overlays = builtins.attrValues self.overlays;}

      self.nixosModules.bluetooth
      self.nixosModules.fonts
      self.nixosModules.hosts
      self.nixosModules.i18n
      self.nixosModules.lanzaboote
      self.nixosModules.networking
      self.nixosModules.niri
      self.nixosModules.nix
      self.nixosModules.noctalia
      self.nixosModules.power
      self.nixosModules.steam
    ];
  };
}
