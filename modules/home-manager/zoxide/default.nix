# Zoxide:
# https://github.com/ajeetdsouza/zoxide
{pkgs, ...}: {
  programs.zoxide = {
    enable = true;
    package = pkgs.unstable.zoxide;
    options = ["--cmd cd"];
  };
}
