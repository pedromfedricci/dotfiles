{ pkgs, ... }:
let
  config = import ../../../config.nix;
	module = "zellij";
	files = [
	  "config.kdl"
	  "layouts/zjstatus.kdl"
	  "themes/nightfox.kdl"
	];
in
{
	home.file = config.insertModule module files;

  programs.zellij = {
    enable = true;
    package = pkgs.zellij;
  };
}
