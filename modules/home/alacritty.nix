{
  flake.homeModules.alacritty = {...}: let
    dotfiles = import ../../dotfiles.nix;
    module = "alacritty";
    files = ["alacritty.toml" "themes/nightfox.toml" "themes/catppuccin-mocha.toml"];
  in {
    home.file = dotfiles.insertManyHomeConfigWithDir module files;

    programs.alacritty.enable = true;
  };
}
