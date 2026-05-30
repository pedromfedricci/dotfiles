# Links:
# https://mynixos.com/home-manager/options/programs.bat
{
  flake.homeModules.bat = {pkgs, ...}:
  # let
  # dotfiles = import ../../dotfiles.nix;
  # module = "bat";
  # files = ["config"];
  # in
  {
    # home.file = dotfiles.insertManyHomeConfigWithDir module files;

    programs.bat = {
      enable = true;
      config = {
        theme = "Catppuccin Mocha";
      };
      extraPackages = with pkgs.bat-extras; [
        # batdiff
        batgrep
        batman
        # batpipe
        batwatch
        # prettybat
      ];
    };
  };
}
