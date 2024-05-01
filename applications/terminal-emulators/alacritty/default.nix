{ pkgs, ... }:
let
  config = import ../../../config.nix;
	module = "alacritty";
	files = [ "alacritty.toml" "themes/nightfox.toml" ];
in
{
	home.file = config.insertModule module files;

  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };
}
