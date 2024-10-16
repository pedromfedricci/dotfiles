{pkgs, ...}: {
  programs.bacon = {
    enable = true;
    package = pkgs.unstable.bacon;
  };
}
