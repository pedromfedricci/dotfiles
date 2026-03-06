{user, ...}: {
  # Allow unfree packages (default false).
  nixpkgs.config.allowUnfree = true;

  # Allow broken packages (default false).
  # nixpkgs.config.allowBroken = true;

  nix.settings = {
    substituters = [
      # NOTE: NixOS cache url is automatically added to the config file.
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      # "https://helix.cachix.org"
      # "https://niri.cachix.org"
      # "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      # NOTE: NixOS public key is automatically added to the config file.
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      # "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
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

  # Allow flakes experimental feature.
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Add default user to nix's trusted-users list sot they can add binary caches.
  nix.settings.trusted-users = ["${user.username}"];

  # Automatically create hard links for identical content in the store,
  # saving disk space. Runs every build, may slow it down.
  # Link: https://nixos.wiki/wiki/Storage_optimization.
  nix.settings.auto-optimise-store = true;

  # Which nix package instance to use throughout the system.
  # On stable it is currenty at 2.18. Something greater or equal to 2.19
  # would be better, since that release fixed `nix flake lock` always
  # updating every existing input.
  # Link: https://nix.dev/manual/nix/2.23/release-notes/rl-2.19.
  #
  # nix.package = pkgs.nixVersions.nix_2_21;
}
