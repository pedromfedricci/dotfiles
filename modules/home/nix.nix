{
  flake.homeModules.nix = {pkgs, ...}: {
    # Allow unfree packages (default false).
    nixpkgs.config.allowUnfree = true;

    # Allow broken packages (default false).
    # nixpkgs.config.allowBroken = true;

    nix.settings = {
      substituters = [
        # NOTE: NixOS's cache url MUST BE added with home-manager's `nix.settings`.
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://helix.cachix.org"
        "https://noctalia.cachix.org"

        # "https://niri.cachix.org"
        # "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        # NOTE: NixOS's public key MUST BE added with home-manager's `nix.settings`.
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="

        # "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
        # "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    # Automates nix garbage collection.
    nix.gc = {
      automatic = true;
      dates = "weekly"; # Default: weekly
      options = "--delete-older-than 14d";
    };

    # NOTE: Including uncommited config file.
    nix.extraOptions = "!include access-tokens.conf";

    # A corresponding Nix package must be specified via `nix.package`
    # for generating nix.conf.
    nix.package = pkgs.nix;

    home.packages = with pkgs; [
      alejandra
      nil
      nixd
      # nixfmt-classic
      # nixfmt-rfc-style
      nix-tree
    ];
  };
}
