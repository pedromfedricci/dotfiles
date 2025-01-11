{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    # package = pkgs.unstable.rofi;
    # font = "FiraCode 14";
  };
}
