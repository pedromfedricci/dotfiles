{pkgs, ...}: {
  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      # dates = "weekly"; # default: weekly
      options = "--delete-older-than 14d";
    };
    extraOptions = "!include access-tokens.conf";
    settings = {
      substituters = [
        # NOTE: NixOS's cache url MUST BE added with home-manager's `nix.settings`,
        # it is not added automatically.
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://helix.cachix.org"
      ];
      trusted-public-keys = [
        # NOTE: NixOS's public key MUST BE added with home-manager's `nix.settings`,
        # it is not added automatically.
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      ];
    };
  };
  home.packages = with pkgs; [
    alejandra
    nil
    nixd
    # nixfmt-classic
    # nixfmt-rfc-style
    nix-tree
  ];
}
