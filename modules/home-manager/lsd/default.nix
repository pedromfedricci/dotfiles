{pkgs, ...}: {
  home.packages = [
    pkgs.unstable.lsd
  ];

  home.shellAliases = {
    ls = "lsd";
    ll = "lsd -l";
    la = "lsd -a";
    lt = "lsd --tree";
    lla = "lsd -la";
  };
}
