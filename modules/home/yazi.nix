{
  flake.homeModules.yazi = {
    # pkgs,
    # inputs,
    ...
  }: let
    dotfiles = import ../../dotfiles.nix;
    module = "yazi";
    files = ["theme.toml"];
    # system = pkgs.stdenv.hostPlatform.system;
  in {
    home.file = dotfiles.insertManyHomeConfigWithDir module files;

    programs.yazi = {
      enable = true;
      shellWrapperName = "y";
      # package = inputs.yazi.packages.${system}.yazi;
    };
  };
}
