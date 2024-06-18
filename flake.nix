{
  description = "Pedro's NixOS and Home Manager configuration";

  inputs = {
    # Nixpkgs.
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home-manager.
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "stable";
    };

    # Other flake inputs.
    alejandra.url = "github:kamadorueda/alejandra/main";
    devenv.url = "github:cachix/devenv/main";
    helix.url = "github:helix-editor/helix/master";
    hosts.url = "github:StevenBlack/hosts/master";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    yazi.url = "github:sxyazi/yazi/main";
  };

  outputs = {
    self,
    stable,
    unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = unstable.lib.genAttrs systems;

    # Default host information.
    host = {
      hostName = "thinkpad";
      timeZone = "America/Sao_Paulo";
    };

    # Default user informantion.
    user = {
      userName = "Pedro Fedricci";
      userEmail = "pedromfedricci@gmail.com";
      username = "pdmfed";
      homeDirectory = "/home/" + user.username;
    };
  in {
    # Your custom packages.
    # Accessible through 'nix build', 'nix shell', etc.
    packages = forAllSystems (system: import ./pkgs unstable.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'.
    # Other options beside 'alejandra' include 'nixpkgs-fmt'.
    formatter = forAllSystems (system: unstable.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays.
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export.
    # These are usually stuff you would upstream into nixpkgs.
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export.
    # These are usually stuff you would upstream into home-manager.
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint.
    # Available through 'nixos-rebuild --flake .#your-hostname'.
    nixosConfigurations = {
      ${host.hostName} = stable.lib.nixosSystem {
        modules = [(./host + ("/" + host.hostName))];
        specialArgs = {inherit inputs outputs host user;};
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      ${user.username} = home-manager.lib.homeManagerConfiguration {
        pkgs = stable.legacyPackages.x86_64-linux;
        modules = [(./home + ("/" + user.username))];
        extraSpecialArgs = {inherit inputs outputs user;};
      };
    };
  };
}
