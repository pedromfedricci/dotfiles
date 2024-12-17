{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "starship";
  files = ["starship.toml"];
in {
  home.file = dotfiles.insertManyHomeConfig module files;

  programs.starship = {
    enable = true;
    package = pkgs.unstable.starship;
  };
}
