{
  flake.homeModules.kanshi = {pkgs, ...}: let
    dotfiles = import ../../dotfiles.nix;
    module = "kanshi";
    binFile = "kanshi-cycle.sh";
    configFile = "config";
  in {
    home.file =
      dotfiles.insertHomeLocalBin module binFile
      // dotfiles.insertHomeConfigWithDir module configFile;

    services.kanshi.enable = true;

    # Used by kanshi-cycle.sh script.
    home.packages = [
      pkgs.bash
    ];

    # Used by kanshi-cycle.sh script.
    programs.jq.enable = true;
  };
}
