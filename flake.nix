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
    # Link: https://github.com/NixOS/nixpkgs
    stable.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Link: https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "unstable";
    };

    # Link: https://github.com/kamadorueda/alejandra
    # alejandra = {
    #   url = "github:kamadorueda/alejandra";
    # };

    # Link: https://github.com/cachix/devenv
    # devenv = {
    #   url = "github:cachix/devenv";
    # };

    # Link: https://github.com/ghostty-org/ghostty
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    # };

    # Link: https://github.com/helix-editor/helix
    helix = {
      url = "github:helix-editor/helix";
    };

    # Link: https://github.com/hyprwm/Hyprland
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    # };

    # Link: https://github.com/hyprwm/hyprland-plugins
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # Link: https://github.com/StevenBlack/hosts
    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "unstable";
    };

    # Link: https://github.com/nix-community/lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "unstable";
    };

    # # Link: https://github.com/sodiboo/niri-flake
    # niri = {
    #   url = "github:sodiboo/niri-flake";
    # };

    # Link: https://github.com/NixOS/nix
    # nix = {
    #   url = "github:NixOS/nix/2.23.0";
    # };

    # Link: https://github.com/Mic92/nix-ld
    # nix-ld = {
    #   url = "github:Mic92/nix-ld";
    # };

    # Link: https://github.com/NixOS/nixos-hardware
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };

    # Link: https://docs.noctalia.dev/getting-started/nixos/
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.1";
      # inputs.nixpkgs.follows = "unstable";
    };

    # Link: https://github.com/sxyazi/yazi
    # yazi = {
    #   url = "github:sxyazi/yazi";
    # };

    # Link: https://github.com/0xc000022070/zen-brozen-browser-flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "unstable";
    };
  };
}
