{pkgs, ...}: let
  dotfiles = import ../../../dotfiles.nix;
  module = "bat";
  files = ["config"];
in {
  home.file = dotfiles.insertManyHomeConfigWithDir module files;

  programs.bat = {
    enable = true;
    package = pkgs.unstable.bat;
    extraPackages = with pkgs.unstable.bat-extras; [
      batdiff
      batgrep
      batman
      batwatch
    ];
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
    };
  };
}
