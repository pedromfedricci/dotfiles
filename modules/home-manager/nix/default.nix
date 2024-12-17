{pkgs, ...}: {
  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 14d";
    };
    settings = {
      substituters = [
        # NOTE: NixOS's cache url MUST BE added with home-manager's `nix.settings`,
        # it is not added automatically.
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://helix.cachix.org"
      ];
      trusted-public-keys = [
        # NOTE: NixOS's public key MUST BE added with home-manager's `nix.settings`,
        # it is not added automatically.
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      ];
    };
  };
}
