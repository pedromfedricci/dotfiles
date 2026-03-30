{
  inputs,
  self,
  ...
}: let
  inherit (import ../_data/defaults.nix) user;
in {
  imports = [
    inputs.home-manager.flakeModules.home-manager
  ];

  flake.homeConfigurations.pdmfed = inputs.home-manager.lib.homeManagerConfiguration {
    # https://github.com/nix-community/home-manager/issues/3075
    pkgs = inputs.stable.legacyPackages.x86_64-linux;
    extraSpecialArgs = {inherit inputs user;};
    modules = [
      ./_config/pdmfed.nix

      {nixpkgs.overlays = builtins.attrValues self.overlays;}

      self.homeModules.alacritty
      self.homeModules.atuin
      self.homeModules.bat
      self.homeModules.cursor
      self.homeModules.delta
      self.homeModules.direnv
      self.homeModules.electron
      self.homeModules.fish
      self.homeModules.fonts
      self.homeModules.fzf
      self.homeModules.git
      self.homeModules.go
      self.homeModules.gtk
      self.homeModules.helix
      self.homeModules.kanshi
      self.homeModules.lsd
      self.homeModules.niri
      self.homeModules.nix
      self.homeModules.noctalia
      self.homeModules.python
      self.homeModules.rust
      self.homeModules.starship
      self.homeModules.typst
      self.homeModules.yazi
      self.homeModules.zellij
      self.homeModules.zoxide
    ];
  };
}
