{ pkgs, ... }:
let
  config = import ../../../config.nix;
	module = "starship";
	files = [ "starship.toml" ];
in
{
  home.file = config.insertModule module files;

  programs.starship = {
    enable = true;
    package = pkgs.starship;
    # enableZshIntegration = true;
  };

  programs.zsh = {
    oh-my-zsh = {
      plugins = [ "starship" ];
    };
  };
}
