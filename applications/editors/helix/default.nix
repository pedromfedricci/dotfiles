{ pkgs, inputs, ... }:
let
  config = import ../../../config.nix;
	module = "helix";
	files = [ "config.toml" "languages.toml" "themes/nightfox.toml" ];
in
{
  home.file = config.insertModule module files;

  programs.helix = {
    enable = true;
    defaultEditor = true;
    package = inputs.helix.packages.${pkgs.system}.helix;
  };
}
