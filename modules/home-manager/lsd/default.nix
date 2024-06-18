{pkgs, ...}: {
  home.packages = [
    pkgs.lsd
  ];

  programs.zsh = {
    shellAliases = {
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -a";
      lt = "lsd --tree";
      lla = "lsd -la";
    };
  };
}
