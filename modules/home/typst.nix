{
  flake.homeModules.typst = {pkgs, ...}: {
    home.packages = with pkgs; [
      tinymist
      typst
      typstyle
    ];
  };
}
