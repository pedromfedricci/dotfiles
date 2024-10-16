{
  description = "My NixOS and Home Manager configuration";

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
        modules = [(./hosts + ("/" + host.hostName))];
        specialArgs = {inherit inputs outputs host user;};
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      ${user.username} = home-manager.lib.homeManagerConfiguration {
        # Per system config?
        # Discussion: https://github.com/nix-community/home-manager/issues/3075
        pkgs = stable.legacyPackages.x86_64-linux;
        modules = [(./users + ("/" + user.username))];
        extraSpecialArgs = {inherit inputs outputs user;};
      };
    };
  };

  inputs = {
    # Nixpkgs.
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home-manager.
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "stable";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "stable";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "stable";
    };

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "stable";
    };

    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "stable";
    };

    # Relative flake inputs doe not work well, bunch of weirdness.
    # Sometimes nix fails to `fetch input` because it `uses relative path`,
    # others will build just fine. Awful error messages. Unreliable.
    # See:
    # https://github.com/NixOS/nix/issues/3978
    # https://github.com/NixOS/nix/issues/3978#issuecomment-1774113898
    # kernel = {
    #   url = "path:inputs/kernel";
    # };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "unstable";
    };

    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "stable";
    };

    nix = {
      url = "github:NixOS/nix/2.23.0";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    yazi = {
      url = "github:sxyazi/yazi";
      inputs.nixpkgs.follows = "unstable";
    };

    zen-browser = {
      url = "github:heywoodlh/flakes/main?dir=zen-browser";
    };
  };
}
# Issues:
#
# `nix flake lock --update-input` updates other input changes as well,
# defeating its on purpose.
# Link: https://github.com/NixOS/nix/issues/8755
# Release 2.19 fixes the issue, but we are still at 2.18 on stable.
# Link: https://nix.dev/manual/nix/2.23/release-notes/rl-2.19

