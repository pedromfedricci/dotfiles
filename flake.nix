{
  description = "My NixOS and Home Manager configuration";

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;}
    (inputs.import-tree ./modules);

  # Core.
  inputs = {
    nixpkgs.follows = "stable";

    # https://github.com/NixOS/nixpkgs/tree/nixos-25.11
    stable.url = "github:nixos/nixpkgs/nixos-25.11";

    # https://github.com/NixOS/nixpkgs/tree/nixos-unstable
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # https://github.com/nix-community/home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "stable";
    };

    # https://github.com/hercules-ci/flake-parts
    flake-parts.url = "github:hercules-ci/flake-parts";

    # https://github.com/vic/import-tree
    import-tree.url = "github:vic/import-tree";
  };

  # Other, in lexicographical order.
  inputs = {
    # https://github.com/kamadorueda/alejandra
    # alejandra.url = "github:kamadorueda/alejandra";

    # https://github.com/cachix/devenv
    # devenv.url = "github:cachix/devenv";

    # https://github.com/ghostty-org/ghostty
    # ghostty.url = "github:ghostty-org/ghostty";

    # https://github.com/helix-editor/helix
    helix.url = "github:helix-editor/helix";

    # https://github.com/StevenBlack/hosts
    hosts = {
      url = "github:StevenBlack/hosts";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/hyprwm/Hyprland
    # hyprland.url = "github:hyprwm/Hyprland";

    # https://github.com/hyprwm/hyprland-plugins
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # https://github.com/nix-community/lanzaboote
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # https://github.com/sodiboo/niri-flake
    # niri.url = "github:sodiboo/niri-flake";

    # https://github.com/NixOS/nix
    # nix.url = "github:NixOS/nix;

    # https://github.com/Mic92/nix-ld
    # nix-ld.url = "github:Mic92/nix-ld";

    # https://github.com/NixOS/nixos-hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    # https://docs.noctalia.dev/getting-started/nixos/
    noctalia.url = "github:noctalia-dev/noctalia-shell/v4.7.1";

    # https://github.com/sxyazi/yazi
    # yazi.url = "github:sxyazi/yazi";

    # https://github.com/0xc000022070/zen-brozen-browser-flake
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
