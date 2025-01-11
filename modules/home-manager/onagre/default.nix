{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "onagre";
  files = ["theme.scss"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  home.packages = with pkgs.unstable; [
    onagre
  ];
}
