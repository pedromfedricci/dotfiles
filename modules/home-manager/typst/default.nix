{pkgs, ...}: {
  home.packages = with pkgs.unstable; [
    tinymist
    typst
    typstyle
  ];
}
