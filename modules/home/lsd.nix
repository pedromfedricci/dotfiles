{
  flake.homeModules.lsd = {pkgs, ...}: {
    home.packages = [
      pkgs.lsd
    ];

    home.shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -a";
      lt = "lsd --tree";
      lla = "lsd -la";
    };
  };
}
