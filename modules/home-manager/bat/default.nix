{
  pkgs,
  lib,
  ...
}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "bat";
  files = ["config" "themes/Catppuccin Mocha.tmTheme"];
  use_source = true;
in {
  home = lib.mkIf use_source {
    file = dotfiles.insertManyHomeConfigWithDir module files;
  };

  programs.bat = {
    enable = true;
    package = pkgs.unstable.bat;
    extraPackages = with pkgs.unstable.bat-extras; [
      # batdiff
      batgrep
      batman
      # batpipe
      batwatch
      # prettybat
    ];
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
    };
  };
}
