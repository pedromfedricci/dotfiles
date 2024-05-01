{ pkgs, ... }:
let
  config = import ../../../config.nix;
	module = "bat";
	files = [ "config" ];
in
{
  home.file = config.insertModule module files;

  programs.bat = {
    enable = true;
    package = pkgs.bat;
  };

  programs.zsh = {
    shellAliases = {
      cat = "bat";
    };
  };
}
