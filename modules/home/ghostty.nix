{
  flake.homeModules.ghostty = {pkgs, ...}: let
    dotfiles = import ../../dotfiles.nix;
    module = "ghostty";
    files = ["config"];
  in {
    home.file = dotfiles.insertManyHomeConfigWithDir module files;

    programs.ghostty = {
      enable = true;
      package = pkgs.unstable.ghostty;
    };
  };
}
